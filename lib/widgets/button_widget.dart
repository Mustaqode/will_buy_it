import 'package:flutter/material.dart';
import 'package:will_buy_it/config/palette.dart';

class ButtonWidget extends StatelessWidget {
  final label;
  final VoidCallback onClick;

  const ButtonWidget(this.label, this.onClick);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
        decoration: BoxDecoration(
            color: Palette.colorPrimary,
            borderRadius: BorderRadius.circular(24.0)),
        child: Center(
          child: Text(
            label,
            style: TextStyle(color: Colors.white, fontSize: 26),
          ),
        ),
      ),
    );
  }
}
