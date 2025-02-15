// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> extractProductsFromImage(
    String imageUrl, String productName) async {
  final apiKey = 'YOUR_OPENAI_API_KEY';

  try {
    // Step 1: Call OpenAI API
    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "model": "gpt-4-vision-preview",
        "messages": [
          {
            "role": "system",
            "content":
                "You are an AI assistant that extracts product details from images."
          },
          {
            "role": "user",
            "content": [
              {
                "type": "text",
                "text":
                    "Extract the brand, product name, and price from this image."
              },
              {
                "type": "image_url",
                "image_url": {"url": imageUrl}
              }
            ]
          }
        ],
        "max_tokens": 200
      }),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final messageContent = jsonData["choices"][0]["message"]["content"];

      // Extract brand, product name, and price from OpenAI response
      final productData = jsonDecode(messageContent);
      final String brand = productData["brand"] ?? "Unknown Brand";
      final String productName = productData["product"] ?? "Unknown Product";
      final String price = productData["price"] ?? "Unknown Price";

      // Step 2: Update Firestore
      final userId = "";
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'brand': brand,
        'productName': productName,
        'price': price,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } else {
      throw Exception(
          "Failed to analyze image. HTTP Error: ${response.statusCode}");
    }
  } catch (e) {
    throw Exception("Error processing image analysis: $e");
  }
}
