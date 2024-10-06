import 'package:accurate_task/core/theme/color_manager.dart';
import 'package:flutter/material.dart';

ThemeData getThemeManager() {
  return ThemeData(
      iconTheme: const IconThemeData(
        color: ColorManager.labelTextColor,
      ),
      inputDecorationTheme:
          InputDecorationTheme(fillColor: ColorManager.inputTextColor),
      colorScheme: ColorScheme.fromSeed(
              seedColor: ColorManager.primaryColor,
              dynamicSchemeVariant: DynamicSchemeVariant.content
              // brightness: Brightness.dark,
              )
          .copyWith(
        primary: ColorManager.primaryColor,
      ),
      appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(color: ColorManager.primaryColor),
          foregroundColor: ColorManager.primaryColor,
          elevation: 0,
          backgroundColor: ColorManager.backGroundColorScaffold),
      scaffoldBackgroundColor: ColorManager.backGroundColorScaffold,
      elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
              overlayColor: WidgetStatePropertyAll(ColorManager.white),
              textStyle: WidgetStatePropertyAll(
                  TextStyle(color: ColorManager.labelTextColor)),
              foregroundColor: WidgetStatePropertyAll(ColorManager.white),
              backgroundColor:
                  WidgetStatePropertyAll(ColorManager.backGroundButton))));
}
