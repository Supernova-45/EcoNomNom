# EcoNomNom: Go Green With Every Grocery 🌱

EcoNomNom is an AI-powered grocery assistant that helps consumers make eco-friendly choices by simply snapping a picture of a shelf. It ranks products based on sustainability factors like carbon footprint, packaging waste, ingredient sourcing, and more. The app empowers users to make informed decisions while shopping.

EcoNomNom aggregates sustainability data from open-source datasets like OpenFoodFacts and uses advanced AI and image processing technology to identify products from images. The app then compares similar items and ranks them based on environmental impact. Users can customize recommendations based on their sustainability preferences, such as reducing emissions or supporting fair trade sourcing. The app also tracks the user's eco-friendly purchases, showing how much carbon emissions they’ve saved over time.

Built with scalability in mind, EcoNomNom uses Firebase for data storage, IRIS for fast querying, and is deployed on Google Cloud Run for seamless performance. Whether you’re looking to reduce your carbon footprint, avoid harmful additives, or simply shop more sustainably, EcoNomNom makes it easy and convenient to make greener choices with every purchase.

## Inspiration 💡

Hershey’s… or Ghirardelli? Lay’s… or Kettle? Whether you’re craving frozen peas or protein bars, at some point, grocery shopping is the ultimate paradox of choice. As we agonize over per-ounce prices, expiration dates, nutritional labels, and scrumptiousness, one key factor often goes overlooked: which option is best for our planet?

Food production drives over a quarter of global greenhouse gas emissions. 88% of consumers want brands to help them make more eco-friendly choices, but the reality? Navigating conflicting sustainability labels feels like deciphering ancient hieroglyphs. The information consumers need is buried or inaccessible when it matters most — at the shelf.

We built EcoNomNom because we, as consumers, found it near-impossible to make eco-friendly choices while grocery shopping. Existing solutions offer piecemeal recommendations — one product at a time, one barcode at a time. There are apps that display sustainability data for a single product if you scan its barcode (inconvenient), and there are apps that compare the footprints of different foods (non-specific), but there is no existing app that provides brand and product-specific sustainability comparisons from just a picture of the shelf. EcoNomNom makes sustainability a seamless, intuitive part of your grocery shopping experience.

## What It Does 🌎

EcoNomNom is your personalized AI-powered grocery shopping assistant. Simply snap a picture of the shelf, and EcoNomNom ranks products in the image based on farm-to-shelf sustainability metrics.

For each item on the shelf, our app extracts product details and provides easy-to-understand ratings on key sustainability factors, including carbon footprint, packaging waste, ingredient sourcing, animal welfare, harmful chemicals, palm oil content, and more. These factors are aggregated into our own sustainability rating called the GreenScore.

You can customize recommendations based on the sustainability metrics that matter most to you — whether that’s reducing emissions, supporting fair trade sourcing, or avoiding harmful additives. EcoNomNom also tracks your footprint over time, showing how much carbon emissions you’ve saved by making eco-friendly purchases.
Every dollar you spend is a vote for the future you want. With EcoNomNom, you can vote for a greener planet — without sacrificing time, money, or taste.

## How We Built It 🦾

EcoNomNom has three primary technical components:

✅ Sustainability Database and Storage
We first created a database of sustainability metrics for various foods by aggregating several open-source datasets, such as OpenFoodFacts. These datasets provided product-specific attributes like carbon footprint, packaging materials, palm oil content, and ingredient origins, which we used to calculate an aggregate “GreenScore” for each product. This score reflects the overall environmental impact of each product.
The processed data was stored in Firebase, enabling us to persist product-specific information and sustainability flags. We then leveraged InterSystems IRIS for vector-based search, allowing fast and scalable querying across millions of products. IRIS Intelligence was critical in enabling semantic search by using vector embeddings of product descriptions. By querying the most related product entries, we were able to return the average eco score, carbon footprint, and other sustainability metrics for similar products in real-time.
For deployment and scalability, we containerized the application using Docker and deployed our FastAPI-based services to Google Cloud Run, making the APIs publicly accessible for integration with the FlutterFlow front-end.

✅ AI and Image Processing Pipeline
Next, we built an AI-driven image processing pipeline to analyze user-uploaded images of supermarket shelves, extract product names and brands, and match them to entries in our sustainability database. OpenAI’s Visual Language Models were used to interpret the image and identify text labels, enabling accurate detection of product names directly from the image.
The extracted product descriptions were converted into vector embeddings using Hugging Face’s Sentence Transformer model. These embeddings served as search queries in the IRIS Vector Search Engine, which returned the top 3 most similar products from the database. By averaging their eco scores and other sustainability flags, we provided users with a reliable measure of which products were the most environmentally friendly.
In the future, we aim to improve this pipeline by integrating RAG (Retrieval-Augmented Generation) to generate more detailed, context-specific sustainability explanations for users.

✅ Frontend: We configured our app to display product recommendations and sustainability data for each. We also built a profile landing page to store user preferences and carbon footprint.
Flutter
Dart

⭐ Overall Pipeline:

Step 1: User Input (FlutterFlow Frontend)
User uploads an image of a product or enters a product name in the FlutterFlow-based mobile app.
The app sends the image or product name to the backend via an HTTP request.

Step 2: AI and Image Processing (OpenAI + Visual Language Models)
For Image Input: OpenAI's Visual Language Models extract text (brand and product names) from the image.
The extracted text is converted into product descriptions and fed into the sustainability search pipeline.

Step 3: Data Matching and Vector Search (IRIS Intelligence)
Embeddings Creation: Product descriptions are embedded into vector representations using Hugging Face’s SentenceTransformer model.
IRIS Vector Search: These embeddings are used to query a pre-computed vector database containing millions of product entries.
Top 3 Matches are returned based on vector similarity for further processing.

Step 4: Sustainability Database and Metrics Calculation (OpenFoodFacts + Firebase)
Sustainability data, such as carbon footprint, packaging impact, palm oil content, and ingredient origins, is aggregated from open-source datasets.
A GreenScore is calculated for each product based on these metrics.
Product data and sustainability flags are stored in Firebase for persistent access.

Step 5: API Integration (FastAPI + Docker + Google Cloud Run)
FastAPI-based services handle requests for sustainability flags and eco scores.
The APIs are containerized using Docker and deployed to Google Cloud Run for scalable and reliable access.

Step 6: Real-Time Results Display (FlutterFlow)
The FlutterFlow app retrieves the eco score and sustainability flags from the API and displays them to the user in real-time.
Users receive personalized recommendations on more sustainable product choices.

## Challenges

Data Integration and Cleaning: Aggregating data from multiple open-source datasets (e.g., OpenFoodFacts) presented challenges due to missing values and inconsistencies in sustainability metrics. Cleaning and standardizing this data was crucial to ensure accurate GreenScore calculations.
Efficient Querying at Scale: Performing real-time vector search across millions of product entries in the sustainability database required optimizing the IRIS Intelligence engine for fast retrieval without sacrificing accuracy.
Image Recognition Accuracy: Extracting product names from user-uploaded images was complex due to varying image quality and multiple overlapping brands. Leveraging OpenAI's Visual Language Models helped improve the accuracy of text extraction, but required significant tuning.
Deployment and Scalability: Deploying our API using Docker and Google Cloud Run presented challenges in managing SSL certificates and ensuring consistent uptime for FlutterFlow integration.
Vector Similarity Search: Implementing vector-based product matching using Hugging Face SentenceTransformer embeddings required careful handling of vector dimensionality and normalization for cosine similarity scoring.

## Accomplishments We're Proud Of

End-to-End AI Pipeline: We’re proud of the end-to-end image-to-recommendation AI pipeline we built, which integrates APIs from several LLM (Large Language Models) for image processing and text extraction. This allowed us to provide users with real-time sustainability insights.
Scalable API Integration: Successfully deployed our API services using FastAPI, Docker, and Google Cloud Run, making the system reliable and scalable.
Real-Time Product Recommendations: Implemented a real-time recommendation system that combines AI, vector search, and sustainability metrics, offering users actionable insights on which products are more environmentally friendly.
Accurate Eco Score Calculation: Developed a GreenScore algorithm based on multiple product attributes like carbon footprint, packaging impact, and ingredient origins, providing users with a comprehensive sustainability rating.
 
None of our team members had previously worked with app development, so the learning curve was steep, and we’re proud we were able to deploy a functional product.  

## What We Learned

We assumed finding sustainability data would be straightforward — after all, most companies advertise their eco-friendly practices. Instead, we discovered that transparency and quantification is rare, and crucial data is often missing or misleading. Creating our sustainability rating required aggregating data from multiple sources and delving beyond buzzwords.

[ADD STUFF HERE]

## What's Next For EcoNomNom

Sustainability means different things to different companies and people. Some users prioritize carbon footprint, while others care more about ethical labor practices. We would like to improve upon the personalization of EcoNomNom…
[ADD NICE CONCLUSION]
