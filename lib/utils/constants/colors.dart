import 'package:flutter/material.dart';

class AppColors {
  AppColors._();
  static const Color primaryColor = const Color(0xFF11999E);
  static const Map<int, Color> colorMap = const <int, Color>{
    50: const Color(0xFFE4F9F5),
    100: const Color(0xFFCAEDEB),
    200: const Color(0xFFA3DBDB),
    300: const Color(0xFF7BC9CA),
    400: const Color(0xFF46B1B4),
    500: primaryColor,
    600: const Color(0xFF188084),
    700: const Color(0xFF1E676A),
    800: const Color(0xFF254E50),
    900: const Color(0xFF2B3536),
  };

  static Color bgColor = colorMap[50];
  static Color white = Colors.white;
  static Color black = Colors.black;

  /// side menu
  static Color bgSideMenu = colorMap[900];
  static Color iconSideMenu = colorMap[50];
  static Color textSideMenu = colorMap[50];
}
