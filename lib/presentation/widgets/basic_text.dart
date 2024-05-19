import "package:realtbox/config/resources/font_manager.dart";
import "package:flutter/material.dart";

class BasicText extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final TextAlign? textAlign;
  final TextStyle? textStyle;
  const BasicText(
      {required this.text,
      this.color = Colors.black,
      this.fontSize = 16.0,
      this.textAlign = TextAlign.left,
      this.textStyle,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: textStyle?.copyWith(fontFamily: FontConstants.fontFamily,),
    );
  }
}
