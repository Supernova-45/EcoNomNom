import openai 
import requests
import os
import json
from dotenv import load_dotenv
load_dotenv()
openai.api_key = os.getenv("YOUR_OPENAI_API_KEY")
def generate_sustainability_flags(product_type, brand):
    """Generate sustainability-related flags for a given product type and brand."""
    prompt = f"""
    The product is a {product_type} from the brand {brand}.
    
    Generate up to 5 relevant sustainability flags. Focus on high-level categories like packaging impact, ingredients, sourcing practices, and environmental concerns.
    A possible website you can use is: https://world.openfoodfacts.org/.
    
    Return the flags as a clean JSON list of short phrases, without descriptions. Example:
    ["High impact packaging", "Contains palm oil", "Vegetarian", "Organic ingredients", "Fair trade certified"]
    """
    try:
        response = openai.ChatCompletion.create(
            model="gpt-4o",
            messages=[
                {"role": "system", "content": "You are an AI assistant that generates sustainability flags as short, high-level categories."},
                {"role": "user", "content": prompt}
            ],
            max_tokens=150,
            temperature=0.7
        )
        message_content = response['choices'][0]['message']['content'].strip()
        print("GPT-4 Response:", message_content)  # Debugging output
        
        # Remove backticks if present
        if message_content.startswith("```"):
            message_content = message_content.split("```json")[-1].split("```")[0].strip()
        # Convert the response to a Python list
        flags = json.loads(message_content)
        
        # Ensure the result is a list of strings
        if isinstance(flags, list) and all(isinstance(flag, str) for flag in flags):
            return flags
        else:
            return ["No flags generated"]
    except json.JSONDecodeError as e:
        print(f"Error parsing JSON response: {e}")
        return ["No flags generated"]
    except Exception as e:
        print(f"Error generating flags with GPT-4: {e}")
        return ["No flags generated"]
# Example usage
product_type = "peanut butter"
brand = "Skippy"
flags = generate_sustainability_flags(product_type, brand)
print(f"Sustainability Flags for {brand} {product_type}: {flags}")
