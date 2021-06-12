import 'package:flutter/material.dart';
import 'package:will_buy_it/config/palette.dart';

class BlurWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            Palette.progressColorInActive.withOpacity(0.01),
            Palette.progressColorInActive.withOpacity(0.4)
          ])),
    );
  }
}
