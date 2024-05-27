import 'package:flutter/material.dart';
import 'package:realtbox/presentation/widgets/basic_text.dart';

class BorderedText extends StatelessWidget {
  final String text;
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;
  final TextStyle textStyle;
  final EdgeInsetsGeometry padding;

  const BorderedText({
    super.key, 
    required this.text,
    required this.borderColor,
    this.borderWidth = 2.0,
    this.borderRadius = 4.0,
    required this.textStyle,
    this.padding = const EdgeInsets.all(4.0),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: borderWidth),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: BasicText(
        text: text,
        textStyle: textStyle,
      ),
    );
  }
}
