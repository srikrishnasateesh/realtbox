import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:realtbox/config/resources/assests_manager.dart';
import 'package:realtbox/config/resources/color_manager.dart';

class NameInputField extends StatelessWidget {
  final String labelText;
  final String hint;
  final TextEditingController textEditingController;
  const NameInputField({
    super.key,
    this.labelText = "Username",
    this.hint = "Enter your User name",
    required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        counterText: "",
        prefixIcon: Align(
          widthFactor: 1.0,
          heightFactor: 1.0,
          child: SvgPicture.asset(
            userSvg,
          ),
        ),
        labelText: labelText,
        hintText: hint,
        filled: false,
        labelStyle: const TextStyle(
            color: textInputLabelColor, fontWeight: FontWeight.w500),
        hintStyle: const TextStyle(
            fontWeight: FontWeight.w400, color: textInputHintColor),
      ),
    );
  }
}
