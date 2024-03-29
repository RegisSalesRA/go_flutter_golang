import 'package:client/app/colors/colors.dart';
import 'package:flutter/material.dart';

ThemeData themeDataMethod() {
  return ThemeData(
    primarySwatch: ColorsTheme.themeColor,
    iconTheme: const IconThemeData(color: ColorsTheme.iconColor),
    colorScheme: ColorScheme.fromSwatch(primarySwatch: ColorsTheme.themeColor)
        .copyWith(secondary: ColorsTheme.primaryColor),
  );
}
