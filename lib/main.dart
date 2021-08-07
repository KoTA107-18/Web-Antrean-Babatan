import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_antrean_babatan/utils/constants/app_theme.dart';
import 'screenLayer/splashScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Website Antrian Babatan',
      theme: AppTheme.lightTheme.copyWith(
        textTheme: GoogleFonts.notoSansTextTheme(Theme.of(context).textTheme),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
    );
  }
}
