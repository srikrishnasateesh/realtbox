
import 'package:flutter/material.dart';

import 'font_manager.dart';


TextStyle _getTextStyle(double fontSize , String fontFamily, FontWeight  fontWeight, Color color) {
  return
    TextStyle(
        fontSize: fontSize,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
        color: color,
    );
}


TextStyle _getHintStyle(double fontSize , String fontFamily, FontWeight  fontWeight, Color color) {
  return
    TextStyle(
        fontSize: fontSize,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
        color: color);
}

// regular style

TextStyle getRegularStyle({double fontSize = FontSize.s12 , required Color color}) {
  //return TextStyle(fontSize: fontSize, fontFamily : FontConstants.fontFamily,color: color);
  return _getTextStyle(fontSize, FontConstants.fontFamily, FontWeightManager.regular,color);
}

// bold style

TextStyle getBoldStyle({double fontSize = FontSize.s12 , required Color color}) {
  //return TextStyle(fontSize: fontSize, fontFamily : FontConstants.fontFamily,color: color);
  return _getTextStyle(fontSize, FontConstants.fontFamily, FontWeightManager.bold,color);
}

// light style

TextStyle getLightStyle({double fontSize = FontSize.s12 , required Color color}) {
  //return TextStyle(fontSize: fontSize, fontFamily : FontConstants.fontFamily,color: color);
  return _getTextStyle(fontSize, FontConstants.fontFamily, FontWeightManager.light,color);
}

// light style

TextStyle getSemiBoldStyle({double fontSize = FontSize.s12 , required Color color}) {
  //return TextStyle(fontSize: fontSize, fontFamily : FontConstants.fontFamily,color: color);
  return _getTextStyle(fontSize, FontConstants.fontFamily, FontWeightManager.semiBold,color);
}


TextStyle getMediumStyle({double fontSize = FontSize.s12 , required Color color}) {
  //return TextStyle(fontSize: fontSize, fontFamily : FontConstants.fontFamily,color: color);
  return _getTextStyle(fontSize, FontConstants.fontFamily, FontWeightManager.medium,color);
}