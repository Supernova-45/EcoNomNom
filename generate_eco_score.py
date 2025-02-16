import pandas as pd
from sentence_transformers import SentenceTransformer
import iris
import os
import pickle
import json
import numpy as np
def process_data():
    columns_to_keep = ["carbon-footprint_100g", "carbon-footprint-from-meat-or-fish_100g",
                       "environmental_score_score", "product_name"]
    chunk_size = 100000
    chunk_iter = pd.read_csv("/Users/kyleenliao/Downloads/en.openfoodfacts.org.products.csv", encoding='utf-8', 
                             sep='\t', chunksize=chunk_size, on_bad_lines='skip')
    selected_chunks = [chunk[columns_to_keep] for chunk in chunk_iter]
    final_df = pd.concat(selected_chunks, ignore_index=True)
    final_df = final_df.dropna(subset=['product_name', 'environmental_score_score']).reset_index(drop=True)
    return final_df
def get_embeddings(model, final_df):
    """Generate embeddings for product names in batches and save them."""
    batch_size = 128
    embeddings = []
    for i in range(0, len(final_df['product_name']), batch_size):
        print(f"Generating embeddings for batch {i} to {i + batch_size}")
        batch = final_df['product_name'][i:i + batch_size].tolist()
        embeddings_batch = model.encode(batch, normalize_embeddings=True)
        embeddings.extend(embeddings_batch)
    
    # Save embeddings to a file
    with open('embeddings_list_values.pkl', 'wb') as pklfile:
        pickle.dump(embeddings, pklfile)
    print("Embeddings saved to embeddings_list_values.pkl")
    return embeddings
def check_table_populated(cursor, tableName):
    """Check if the table contains any data."""
    sql = f"SELECT COUNT(*) FROM {tableName}"
    try:
        cursor.execute(sql)
        count = cursor.fetchone()[0]
        return count > 0
    except Exception as e:
        print(f"Error checking table: {e}")
        return False
def query_top_matches(cursor, model, tableName, searchPhrase):
    """Query and find the top 5 closest matches based on vector similarity."""
    searchVector = model.encode(searchPhrase, normalize_embeddings=True).tolist()
    sql = f"""
        SELECT product_name, environmental_score_score, product_name_vector 
        FROM {tableName} 
        LIMIT 1000
    """
    try:
        cursor.execute(sql)
        results = cursor.fetchall()
    except Exception as e:
        print(f"Query failed: {e}")
        return
    top_matches = []
    for row in results:
        stored_vector = json.loads(row[2])
        similarity = np.dot(stored_vector, searchVector) / (np.linalg.norm(stored_vector) * np.linalg.norm(searchVector))
        top_matches.append((row[0], row[1], similarity))
    # Sort and get top 5
    top_matches = sorted(top_matches, key=lambda x: x[2], reverse=True)[:5]
    if top_matches:
        print(f"\nTop 5 Matches for '{searchPhrase}':")
        total_score = 0
        for match in top_matches:
            print(f"Product: {match[0]}, Environmental Score: {match[1]}, Similarity: {match[2]:.4f}")
            total_score += match[1]
        avg_score = total_score / len(top_matches)
        print(f"\nAverage Environmental Score of Top 5 Matches: {avg_score:.2f}")
    else:
        print(f"No matches found for '{searchPhrase}'.")
def test_query(cursor, model, tableName):
    """Allow the user to input a product name and query for similar products."""
    while True:
        searchPhrase = input("\nEnter a product to search for (or type 'exit' to quit): ")
        if searchPhrase.lower() == 'exit':
            break
        query_top_matches(cursor, model, tableName, searchPhrase)
def main():
    final_df = pd.read_csv("openFoodSelectedCols.csv")
    final_df = final_df[['environmental_score_score', 'product_name']]
    username = 'demo'
    password = 'demo'
    hostname = os.getenv('IRIS_HOSTNAME', 'localhost')
    port = '1972'
    namespace = 'USER'
    CONNECTION_STRING = f"{hostname}:{port}/{namespace}"
    print(f"Connecting to: {CONNECTION_STRING}")
    conn = iris.connect(CONNECTION_STRING, username, password)
    cursor = conn.cursor()
    tableName = "SchemaName.TableName"
    # Load SentenceTransformer model
    model = SentenceTransformer('all-MiniLM-L6-v2')
    # Check if embeddings file exists
    if os.path.exists("embeddings_list_values.pkl"):
        print("Loading embeddings from file...")
        with open("embeddings_list_values.pkl", 'rb') as file:
            embeddings = pickle.load(file)
    else:
        print("Generating embeddings...")
        embeddings = get_embeddings(model, final_df)
    final_df['product_name_vector'] = embeddings
    # Check if table is already populated
    if check_table_populated(cursor, tableName):
        print("Table already populated. Skipping data insertion.")
    else:
        print("Creating and populating the database table...")
        cursor.execute(f"DROP TABLE IF EXISTS {tableName}")
        cursor.execute(f"CREATE TABLE {tableName} (environmental_score_score DOUBLE, product_name VARCHAR(2000), product_name_vector TEXT)")
        sql_insert = f"INSERT INTO {tableName} (environmental_score_score, product_name, product_name_vector) VALUES (?, ?, ?)"
        batch_size = 500
        for i in range(0, len(final_df), batch_size):
            batch_data = [
                (row['environmental_score_score'], row['product_name'], json.dumps(row['product_name_vector'].tolist()))
                for _, row in final_df.iloc[i:i + batch_size].iterrows()
            ]
            cursor.executemany(sql_insert, batch_data)
            print(f"Inserted batch {i} to {i + batch_size}")
    print(f"{len(final_df)} entries added to the database.")
    # Run test queries
    test_query(cursor, model, tableName)
    cursor.close()
    conn.close()
if __name__ == '__main__':
    main()
