import 'package:flutter/material.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/style_manager.dart';
import '../resources/value_manager.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
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
      color: Colors.blue,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: Color(0XFFF08B8B)),
      titleTextStyle: TextStyle(color: Color(0XFFAA8B8B), fontSize: 18));
}
