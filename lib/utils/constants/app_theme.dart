import 'package:flutter/material.dart';
import 'colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch:
        MaterialColor(AppColors.primaryColor.value, AppColors.colorMap),
    primaryColor: AppColors.primaryColor,
    accentColor: AppColors.colorMap[900],
    canvasColor: AppColors.colorMap[50],
    scaffoldBackgroundColor: AppColors.colorMap[50],
  );

  static ThemeData darkTheme = ThemeData(
    fontFamily: 'Open Sans',
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryColor,
    accentColor: AppColors.primaryColor,
  );
}
