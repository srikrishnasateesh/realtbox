import 'package:flutter/material.dart';
import 'package:realtbox/config/resources/color_manager.dart';
import 'package:realtbox/presentation/widgets/basic_text.dart';

class UnitItemHeader extends StatelessWidget {
  final String unitName;
  const UnitItemHeader({
    super.key,
    required this.unitName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: unitHeaderColor, // Background color for header
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: BasicText(
            text: unitName,
            textStyle: const TextStyle(
              color: kSecondaryColor,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
