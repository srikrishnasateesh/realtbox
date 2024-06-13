import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:realtbox/config/resources/assests_manager.dart';
import 'package:realtbox/config/resources/color_manager.dart';

class PasswordInputField extends StatefulWidget {
  final String labelText;
  final String hint;
  final int maxLength;
  final TextEditingController textEditingController;
  const PasswordInputField({
    super.key,
    this.labelText = "Otp",
    this.hint = "Enter your Otp",
    required this.textEditingController,
    this.maxLength = 6,
  });

  @override
  State<PasswordInputField> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  bool _obscureText = true;

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.textEditingController,
      keyboardType:
          const TextInputType.numberWithOptions(signed: true, decimal: true),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      obscureText: _obscureText,
      maxLength: widget.maxLength,
      decoration: InputDecoration(
        counterText: "",
        prefixIcon: Align(
          widthFactor: 1.0,
          heightFactor: 1.0,
          child: SvgPicture.asset(
            passwordSvg,
          ),
        ),
        suffixIcon: IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: _toggleObscureText,
          ),
        labelText: widget.labelText,
        hintText: widget.hint,
        filled: false,
        labelStyle: const TextStyle(
            color: textInputLabelColor, fontWeight: FontWeight.w500),
        hintStyle: const TextStyle(
            fontWeight: FontWeight.w400, color: textInputHintColor),
      ),
    );
  }
}
