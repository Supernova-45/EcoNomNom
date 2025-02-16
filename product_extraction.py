from openai import OpenAI
client = OpenAI()
import json

response = client.chat.completions.create(
    model="gpt-4o-mini",
    messages=[
        {
            "role": "user",
            "content": [
                {"type": "text", "text": "List the brand, product name, and price without any descriptive texts of the products available in this picture; separate the products using semicolon."},
                {
                    "type": "image_url",
                    "image_url": {
                        "url": "https://worldlinkintegration.com/wp-content/uploads/2019/08/Screen-Shot-2019-08-12-at-10.59.19-AM.png",
                    },
                },
            ],
        }
    ],
    max_tokens=300,
)

received_text = response.choices[0].message.content
product_list = received_text.split("; ")
product_info_dict = {}
index = 0
for product in product_list:
    if (product[-1] == "."):
        product = product[:-1]
    single_product_info = product.split(", ")
    single_product_dict = { 
                            "brand": single_product_info[0],
                            "product name": single_product_info[1],
                            "price": single_product_info[2]
                          }
    product_info_dict[index + 1] = single_product_dict
    index += 1

print(product_info_dict)

# Serializing json
json_object = json.dumps(product_info_dict, indent=4)
 
# Writing to sample.json
with open("sample.json", "w") as outfile:
    outfile.write(json_object)

