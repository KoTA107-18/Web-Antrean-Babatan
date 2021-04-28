import 'package:flutter/material.dart';
import 'package:web_antrean_babatan/screen/mainScreen.dart';
import 'package:web_antrean_babatan/screen/splashScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Website Antrian Babatan',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MainScreen(),
    );
  }
}
