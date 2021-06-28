import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:will_buy_it/config/palette.dart';
import 'package:will_buy_it/widgets/swipe_slider.dart';

class CustomSlider extends StatelessWidget {
  final height;
  final width;
  final sliderElementColor;
  final sliderBackgroundColor;
  final IconData icon;
  final text;
  final subText;
  final TextStyle textStyle;
  final TextStyle subTextStyle;
  final VoidCallback onConfirmation;

  const CustomSlider({
    required this.onConfirmation,
    required this.icon,
    required this.text,
    this.subText = '',
    this.height = 80.0,
    this.width = double.infinity,
    this.sliderBackgroundColor = Palette.sliderBackground,
    this.sliderElementColor = Palette.colorPrimary,
    this.textStyle = const TextStyle(
        color: Palette.colorPrimary,
        fontSize: 26.0,
        fontWeight: FontWeight.bold),
    this.subTextStyle =
        const TextStyle(color: Palette.colorPrimary, fontSize: 16.0),
  });

  @override
  Widget build(BuildContext context) {
    return SwipeSlider(
        height: height,
        width: width,
        backgroundColor: sliderBackgroundColor,
        foregroundColor: sliderElementColor,
        icon: icon,
        text: text,
        textStyle: textStyle,
        subText: subText,
        subTextStyle: subTextStyle,
        onConfirmation: () {
          HapticFeedback.lightImpact();
          onConfirmation();
        });
  }
}
