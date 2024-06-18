import 'package:flutter/material.dart';
import 'package:realtbox/config/resources/color_manager.dart';

class PrimaryButton extends StatelessWidget {
   PrimaryButton({super.key, required this.buttonText, required this.onPressed,});
  final String buttonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryColor,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        child: Text(
          buttonText,
          style: const TextStyle(
            fontSize: 18,
            color: kSecondaryColor,
          ),
        ),
      ),
    );
  }
}
