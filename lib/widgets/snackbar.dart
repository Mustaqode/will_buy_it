import 'package:flutter/material.dart';
import 'package:will_buy_it/config/palette.dart';

SnackBar getSnackBar(bool isError, String message) {
  return SnackBar(
    content: Text(
      message,
      style: TextStyle(color: Colors.white, fontSize: 18),
    ),
    duration: const Duration(seconds: 1),
    behavior: SnackBarBehavior.floating,
    backgroundColor:
        isError ? Palette.sliderHeadUnBuy : Palette.progressColorActive,
  );
}
