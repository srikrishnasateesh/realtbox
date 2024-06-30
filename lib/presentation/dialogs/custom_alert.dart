import 'package:flutter/material.dart';

class CustomAlert extends StatelessWidget {
  final String title;
  final String message;
  final String primaryActionLabel;
  final String? secondaryActionLabel;
  final VoidCallback onPrimaryAction;
  final VoidCallback onSecondaryAction;
  CustomAlert({
    super.key,
    required this.title,
    required this.message,
    required this.primaryActionLabel,
    this.secondaryActionLabel,
    required this.onPrimaryAction,
    required this.onSecondaryAction,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.red,
        ),
      ),
      content: Text(message),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onPrimaryAction();
              // Navigator.pop(context, true);
            },
            child: Text(primaryActionLabel)),
        Visibility(
            visible: secondaryActionLabel != null,
            child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  onSecondaryAction();
                },
                child: Text(secondaryActionLabel ?? ""))),
      ],
    );
  }
}
