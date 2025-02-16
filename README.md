## Inspiration

Hershey’s… or Ghirardelli? Lay’s… or Kettle? Whether you’re craving frozen peas or protein bars, at some point, grocery shopping is the ultimate paradox of choice. As we agonize over per-ounce prices, expiration dates, nutritional labels, and scrumptiousness, one key factor often goes overlooked: **which option is best for our planet?**

**Food production** drives **over a quarter of global greenhouse gas emissions.** 88% of consumers want brands to help them make more eco-friendly choices, but the reality? Navigating conflicting sustainability labels feels like deciphering ancient hieroglyphs. The information consumers need is buried or inaccessible when it matters most — at the shelf.

We built EcoNomNom because we, as consumers, found it near-impossible to make eco-friendly choices while grocery shopping. Existing solutions offer piecemeal recommendations — one product at a time, one barcode at a time. There are apps that display sustainability data for a single product if you scan its barcode, and there are apps that compare the footprints of different foods, but there is _no existing app_ that provides brand and product-specific sustainability comparisons from just a picture of the shelf. EcoNomNom makes sustainability a seamless, intuitive part of your grocery shopping experience.

## What it does

EcoNomNom is your personalized AI-powered grocery shopping assistant. Simply **snap a picture of the shelf,** and EcoNomNom **ranks products in the image** based on farm-to-shelf sustainability metrics.

For each item on the shelf, our app extracts product details and provides easy-to-understand ratings on key sustainability factors, including **carbon footprint, packaging waste, ingredient sourcing, animal welfare, harmful chemicals, palm oil content, and more.** These factors are aggregated into our own sustainability rating called the _GreenScore._

You can customize recommendations based on the sustainability metrics that matter most to you — whether that’s reducing emissions, supporting fair trade sourcing, or avoiding harmful additives. EcoNomNom also tracks your footprint over time, showing how much carbon emissions you’ve saved by making eco-friendly purchases.
Every dollar you spend is a vote for the future you want. With EcoNomNom, you can vote for a greener planet — without sacrificing time, money, or taste.

## How we built it

EcoNomNom has three primary components:

1. **Sustainability Database and Storage**
- We created a **database of sustainability metrics** for various foods by aggregating several open-source datasets, such as OpenFoodFacts and the Food Sustainability Index. These datasets provided product-specific attributes like carbon footprint, packaging materials, palm oil content, and ingredient origins, which we used to calculate an aggregate “GreenScore” for each product's overall environmental impact. The processed data was stored in **Firebase.** 
- We leveraged **InterSystems IRIS** for vector-based search, allowing fast and scalable querying across millions of products. IRIS Intelligence was critical in enabling **semantic search** by using vector embeddings of product descriptions. By querying the most related product entries, we were able to return the average eco score, carbon footprint, and other sustainability metrics for similar products.
- For deployment, we containerized the application using **Docker** and deployed our **FastAPI**-based services to **Google Cloud Run,** making the APIs publicly accessible for integration with the front-end.

2. **AI and Image Processing Pipeline**
- We built an **AI-driven image processing pipeline** to analyze user-uploaded images of supermarket shelves, extract product names and brands, and match them to entries in our sustainability database. **OpenAI’s Visual Language Models** were used to interpret the image and identify text labels, enabling accurate detection of product names directly from the image.
- The extracted product descriptions were converted into vector embeddings using **Hugging Face’s Sentence Transformer** model. These embeddings served as search queries in the **IRIS Vector Search Engine**, which returned the top 3 most similar products from the database. By averaging their eco scores and other sustainability flags, we provided users with a reliable measure of which products were the most environmentally friendly.

3. **Mobile/Web App and Frontend** 
- Using **FlutterFlow**, we configured our app to display product recommendations and sustainability data for each. We also built a profile landing page to store user preferences and carbon footprint. This app can be accessed on mobile or web.

## Challenges we ran into

Aggregating data from multiple open-source datasets (e.g., OpenFoodFacts) was difficult due to the datasets missing several values. Cleaning and trimming these datasets required significant time.

Performing vector searches across millions of product entries in the sustainability database was extremely slow at first and required optimizing the IRIS Intelligence engine.

## Accomplishments that we're proud of

- We’re proud of the end-to-end image-to-recommendation AI pipeline we built, which integrates APIs from several LLMs for image processing and text extraction.
- We're proud of the GreenScore metric we aggregated based on multiple sustainability metrics; we feel it encapsulates the environmental impact of food products not only on carbon emissions but also on humans involved in the process of production.
- None of our team members had previously worked with app development, so we’re proud we were able to deploy a functional product.  

## What we learned

We assumed finding sustainability data would be straightforward — after all, most companies advertise their eco-friendly practices. Instead, we discovered that transparency and quantification are rare, and crucial data is often missing or misleading. Creating our sustainability rating required aggregating data from multiple sources and looking beyond buzzwords.

## What's next for EcoNomNom

Sustainability means different things to different companies and people. Some users prioritize carbon footprint, while others care more about ethical labor practices. We would like to take EcoNomNom’s personalization to the next level, allowing users to provide more input on how they would like to weigh different sustainability factors. We also want to account for individualized preferences such as dietary restrictions and allergies. Our ultimate goal is to create a lightweight shopping assistant that doesn’t tell you the “best” product in a generic sense, but rather, tells you which product is best for you. 

We hope to integrate Retrieval-Augmented Generation (RAG) into our AI pipeline to generate context-specific explanations of the environmental impact of products for each user.

Convenience, affordability, and sustainability don’t have to be at odds. With EcoNomNom, they go hand in hand—one purchase, one planet-friendly choice at a time.
