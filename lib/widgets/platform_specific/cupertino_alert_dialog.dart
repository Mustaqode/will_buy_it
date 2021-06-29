import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:will_buy_it/config/palette.dart';

class CupertinoAlertDialogg extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback positiveButtonPress;
  final String positiveButtonText;
  final String negativeButtonText;
  final bool setCancellable;

  const CupertinoAlertDialogg(
      {required this.title,
      required this.message,
      required this.positiveButtonPress,
      this.positiveButtonText = "Yes",
      this.negativeButtonText = "No",
      this.setCancellable = false});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        CupertinoDialogAction(
            onPressed: () {
              positiveButtonPress();
              Navigator.of(context).pop();
            },
            child: Text(
              positiveButtonText,
              style: TextStyle(color: Palette.colorPrimary),
            )),
        CupertinoDialogAction(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              negativeButtonText,
              style: TextStyle(color: Palette.colorPrimary),
            ))
      ],
    );
  }
}
