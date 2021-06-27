import 'package:flutter/material.dart';
import 'package:will_buy_it/config/palette.dart';

class Loader extends StatelessWidget {
  const Loader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: CircularProgressIndicator(
      backgroundColor: Palette.colorPrimary,
      valueColor: AlwaysStoppedAnimation(Palette.progressColorInActive),
    ));
  }
}
