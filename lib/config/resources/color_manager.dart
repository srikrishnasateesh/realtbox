import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFFFFB511);
const kSecondaryColor = Color(0xFF101820);
const kMainTextColor = Color(0xFF2E3E5C);
const kSecondaryTextColor = Color(0xFF9FA5C0);
const kOutlineColor = Color(0xFFD0DBEA);
const kFormColor = Color(0xFFF4F5F7);

const textInputHintColor = Color(0xFF000842);
const textInputBoxColor = Color(0xFF000842);
const textInputLabelColor = Color(0xFF999999);
const textInputPrefixIconColor = Color(0xFF000842);
const blueGreyColor = Color(0xFF415770);




class ColorManager {
  static Color primary = HexColor.fromHex("#ED9728");
  static Color darkGrey = HexColor.fromHex("#525252");
  static Color grey = HexColor.fromHex("#737477");
  static Color lightGrey = HexColor.fromHex("#9E9E9E");
  static Color primaryOpacity70 = HexColor.fromHex("#ffae42");// B3ED9728 //D79542 //E59F46
  //static Color white = Colors.white;FAF8F4 faf8f4
  //text color 45403C
  // new colors
  static Color buttonColor = HexColor.fromHex("#ffad3f");
  static Color textColor = HexColor.fromHex("#45403C");
  static Color backGround = HexColor.fromHex("#faf8f4");
  static Color darkPrimary = HexColor.fromHex("#d17d11");
  static Color grey1 = HexColor.fromHex("#707070");
  static Color grey2 = HexColor.fromHex("#797979");
  static Color white = HexColor.fromHex("#FFFFFF");
  static Color error = HexColor.fromHex("#e61f34"); // red color
  static Color black = HexColor.fromHex("#000000");
  static Color green = HexColor.fromHex("#FF1FCC79");
  static Color transparent = HexColor.fromHex("#00000000");
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = "FF$hexColorString"; // 8 char with opacity 100%
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}