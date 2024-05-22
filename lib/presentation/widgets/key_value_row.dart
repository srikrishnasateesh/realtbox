import 'package:flutter/material.dart';

class KeyValueRow extends StatelessWidget {
  final String keyText;
  final String valueText;

  KeyValueRow({required this.keyText, required this.valueText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              keyText,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(valueText),
          ),
        ],
      ),
    );
  }
}
