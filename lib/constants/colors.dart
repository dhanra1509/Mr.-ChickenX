import 'package:flutter/material.dart';

extension CustomTheme on ThemeData {
  CustomColors get colors => CustomColors(brightness == Brightness.dark);
}

class CustomColors {
  static const Color lightCustomColor1 = Color(0xFF123456);
  static const Color lightCustomColor2 = Color(0xFFabcdef);
  static const Color lightCustomColor3 = Color(0xFF0F1234);
  static const Color white = Colors.white;
  static const Color paleSpringBud = Color(0xFFF0F4C3);
  static const Color lemonYellow = Color(0xFFFFF59D);
  static const Color persianRed = Color(0xFFD32F2F);

  static const Color darkCustomColor1 = Color(0xFF654321);
  static const Color darkCustomColor2 = Color(0xFFfedcba);
  static const Color darkCustomColor3 = Color(0xFF1A2345);
  static const Color black = Colors.black;

  final bool isDarkMode;

  CustomColors(this.isDarkMode);

  Color get customColor1 => isDarkMode ? darkCustomColor1 : lightCustomColor1;
  Color get customColor2 => isDarkMode ? darkCustomColor2 : lightCustomColor2;
  Color get customColor3 => isDarkMode ? darkCustomColor3 : lightCustomColor3;
  Color get bg => isDarkMode ? black : white;
  Color get bgInverse => isDarkMode ? white : black;
  Color get whiteColor => isDarkMode ? black : white;
  Color get blackColor => isDarkMode ? white : black;
  Color get paleSpring => isDarkMode ? paleSpringBud : paleSpringBud;
  Color get lemon => isDarkMode ? lemonYellow : lemonYellow;
  Color get persianred => isDarkMode ? persianRed : persianRed; 


  Brightness get iconBrightness =>
      isDarkMode ? Brightness.light : Brightness.dark;
}
