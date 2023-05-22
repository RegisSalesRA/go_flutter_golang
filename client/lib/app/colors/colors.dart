import 'package:flutter/material.dart';

abstract class ColorsTheme {
  static const MaterialColor themeColor = MaterialColor(
    0xff65ccd9,
    <int, Color>{
      50: Color(0xFF65ccd9), //10%
      100: Color(0xFF65ccd9), //20%
      200: Color(0xFF00254d), //30%
      300: Color(0xFF00254d), //40%
      400: Color(0xFF00254d), //50%
      500: Color(0xFF021338), //60%
      600: Color(0xFF021338), //70%
      700: Color(0xFF021338), //80%
      800: Color(0xff170907), //90%
      900: Color(0xff000000), //100%
    },
  );

  static const Color primaryColor = Color(0xFF65ccd9);
  static const Color secondaryColor = Color(0xFF627C80);
  static Color backgroundColor = Colors.grey.shade300;
  static Color backgroundContainerColor = Colors.grey.shade200;
  static const Color iconColor = Color(0xFF85c1cc);
  static const Color splashColor = Color(0xFF0e0917);

  static const Color splashColorExtra = Color(0xFF1a1432);
}
