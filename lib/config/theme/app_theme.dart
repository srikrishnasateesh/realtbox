import 'package:flutter/material.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/style_manager.dart';
import '../resources/value_manager.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: FontConstants.fontFamily,
    appBarTheme: appBarTheme(),
    elevatedButtonTheme : ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            textStyle: getSemiBoldStyle(fontSize:FontSize.s18,color: ColorManager.white),
            backgroundColor: ColorManager.buttonColor,
            foregroundColor: ColorManager.white,
            //onPrimary: ColorManager.white,
            fixedSize: const Size(double.maxFinite,AppSize.s60),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.s12))
        )
    ),
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
      color: kPrimaryColor,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: kSecondaryColor),
      titleTextStyle: TextStyle(color: kSecondaryColor, fontSize: 18));
}
