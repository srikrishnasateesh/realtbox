import 'package:flutter/material.dart';
import 'package:realtbox/config/resources/color_manager.dart';
import 'package:realtbox/presentation/widgets/basic_text.dart';

class KeyValueColumn extends StatelessWidget {
  final String displayKey;
  final String displayValue;
  const KeyValueColumn({
    super.key,
    required this.displayKey,
    required this.displayValue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16.0),
          const Divider(color: kOutlineColor, height: 1.0),
          const SizedBox(height: 16.0),
          BasicText(
            text: displayKey,
            textStyle: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8.0),
          BasicText(
            text: displayValue,
            textStyle: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: kSecondaryTextColor),
          ),
        ]);
    ;
  }
}
