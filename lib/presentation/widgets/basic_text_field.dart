import 'package:flutter/material.dart';
import '../../config/resources/font_manager.dart';
class BasicTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final InputDecoration decoration;
  final ValueChanged<String>? onChanged;
  final Widget? prefixIcon;
  final TextStyle? style;
  final int maxLength ;

  const BasicTextField({
    required this.hintText,
    required this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.decoration = const InputDecoration(),
    this.onChanged,
    this.prefixIcon,
    this.style,
    this.maxLength = TextField.noMaxLength,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      maxLength:maxLength,
      style: style,
      decoration: decoration.copyWith(
        counterText: '',
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.blue),
        ),
        filled: true,
        fillColor: Colors.grey[200],
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: FontSize.s16,
            fontFamily: FontConstants.fontFamily,
            fontWeight: FontWeightManager.regular),
        prefixIcon: prefixIcon,
      ),
      onChanged: onChanged,
    );
  }
}
