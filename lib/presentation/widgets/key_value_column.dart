import 'package:flutter/material.dart';
import 'package:realtbox/presentation/widgets/basic_text.dart';

class KeyValueColumn extends StatelessWidget {
  final String keyText;
  final String valueText;
  Color? valueColor;
  Color? keyColor;
  KeyValueColumn({
    super.key,
    required this.keyText,
    required this.valueText,
    this.keyColor = Colors.blueAccent,
    this.valueColor = Colors.black87,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BasicText(
          text: valueText,
          textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: valueColor,
              ),
              
        ),
        BasicText(
          text: keyText,
          textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 8,
                color: keyColor,
                fontStyle: FontStyle.italic,
              ),
        )
      ],
    );
  }
}
