import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:realtbox/config/resources/color_manager.dart';

class OutlineInputField extends StatelessWidget {
  final String labelText;
  final String hint;
  final TextEditingController textEditingController;
  final ValueChanged<String> onInputChanged;
  final TextInputType inputType;
  final bool readOnly;
  final FocusNode? focusNode;
  final int? maxLength;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Function()? onTap;
  final bool enabled;
  final int? minLines;
  final int? maxLines;

  const OutlineInputField({
    super.key,
    required this.labelText,
    required this.hint,
    required this.textEditingController,
    required this.onInputChanged,
    required this.inputType,
    this.readOnly = false,
    this.focusNode,
    this.onTap,
    this.maxLength,
    this.suffixIcon,
    this.prefixIcon,
    this.enabled = true,
    this.minLines = 1,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 45,
          child: TextField(
            minLines: minLines,
            maxLines: maxLines,
            enabled: enabled,
            onTap: onTap,
            maxLength: maxLength,
            focusNode: focusNode,
            readOnly: readOnly,
            controller: textEditingController,
            keyboardType: inputType,
            decoration: InputDecoration(
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              counterText: "",
              isDense: true,
              contentPadding: const EdgeInsets.all(10),
              labelText: labelText,
              hintText: hint,
              labelStyle: const TextStyle(color: kPrimaryColor),
              border: const OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
            ),
            onChanged: onInputChanged,
          ),
        ),
        
      ],
    );
  }
}
