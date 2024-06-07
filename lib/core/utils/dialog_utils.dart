import 'package:flutter/material.dart';

Future<void> showConfirmationDialog(
  BuildContext context, {
  required String title,
  required String content,
  required void Function() onConfirmed,
  required void Function() onCancelled,
  bool showSecondaryAction = false,
  String confirmButtonText = 'Confirm',
  String cancelButtonText = 'Cancel',
}) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          if (showSecondaryAction)
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onCancelled();
              },
              child:  Text(cancelButtonText),
            ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onConfirmed();
            },
            child: Text(confirmButtonText),
          ),
        ],
      );
    },
  );
}
