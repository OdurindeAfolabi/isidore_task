
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:isidore_task/Utils/styles_manager.dart';
import 'package:isidore_task/Utils/values_manager.dart';

import 'color_manager.dart';
import 'font_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    // main colors of the app
      primaryColor: ColorManager.primary,
      primaryColorDark: ColorManager.secondary,
      disabledColor: ColorManager.grey,
      // ripple color
      splashColor: ColorManager.secondary.withOpacity(0.15),
      // card view theme
      cardTheme: CardTheme(
          color: ColorManager.white,
          shadowColor: ColorManager.grey,
          elevation: AppSize.s4),
      // App bar theme
      appBarTheme: AppBarTheme(
          centerTitle: false,
          color: ColorManager.primary,
          elevation: 0.0,
          titleTextStyle: getRegularStyle(
              color: ColorManager.white, fontSize: FontSize.s16),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: ColorManager.white,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark)));
}




