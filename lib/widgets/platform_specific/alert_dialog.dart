import 'package:flutter/material.dart';
import 'package:will_buy_it/config/palette.dart';

class AlertDialogg extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback positiveButtonPress;
  final String positiveButtonText;
  final String negativeButtonText;
  final bool setCancellable;

  const AlertDialogg(
      {required this.title,
      required this.message,
      required this.positiveButtonPress,
      this.positiveButtonText = "Yes",
      this.negativeButtonText = "No",
      this.setCancellable = false});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: TextStyle(fontSize: 18),
      ),
      content: Text(
        message,
        style: TextStyle(fontSize: 16),
      ),
      backgroundColor: Palette.colorSecondary,
      actions: [
        TextButton(
            onPressed: () {
              positiveButtonPress();
              Navigator.of(context).pop();
            },
            child: Text(
              positiveButtonText,
              style: TextStyle(color: Palette.colorPrimary, fontSize: 16),
            )),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              negativeButtonText,
              style: TextStyle(color: Palette.colorPrimary, fontSize: 16),
            ))
      ],
    );
  }
}
