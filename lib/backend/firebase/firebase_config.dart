import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyBNW5hsUHtT1xnYwkU89_H1vgvlCqhlMno",
            authDomain: "eco-nom-nom-puznn8.firebaseapp.com",
            projectId: "eco-nom-nom-puznn8",
            storageBucket: "eco-nom-nom-puznn8.firebasestorage.app",
            messagingSenderId: "448443669057",
            appId: "1:448443669057:web:392b07ae4744b1b8aa44c0",
            measurementId: "G-RF4CDE7XQQ"));
  } else {
    await Firebase.initializeApp();
  }
}
