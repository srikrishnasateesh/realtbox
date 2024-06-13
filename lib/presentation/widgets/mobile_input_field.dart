import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:realtbox/config/resources/assests_manager.dart';
import 'package:realtbox/config/resources/color_manager.dart';

class MobileInputField extends StatelessWidget {
  final String labelText;
  final String hint;
  final TextEditingController textEditingController;
  final ValueChanged<String> onInputChanged;
  const MobileInputField({
    super.key,
    this.labelText = "Phone Number",
    this.hint = "Enter your Phone Number",
    required this.textEditingController, 
    required this.onInputChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      keyboardType:
          const TextInputType.numberWithOptions(signed: true, decimal: true),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      maxLength: 10,
      onChanged: onInputChanged,
      decoration: InputDecoration(
        counterText: "",
        prefixIcon: Align(
          widthFactor: 1.0,
          heightFactor: 1.0,
          child: SvgPicture.asset(
            phoneSvg,
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
