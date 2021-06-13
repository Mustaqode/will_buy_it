import 'package:flutter/material.dart';
import 'package:will_buy_it/config/palette.dart';
import 'package:will_buy_it/config/strings.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData prefixIcon;
  final Function onSaved;
  final bool isAmountField;
  final bool isUrlField;

  const CustomTextField(
      {required this.hint,
      required this.prefixIcon,
      required this.onSaved,
      this.isAmountField = false,
      this.isUrlField = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(8.0),
        child: TextFormField(
          textAlignVertical: TextAlignVertical.center,
          keyboardType:
              isAmountField ? TextInputType.number : TextInputType.text,
          style: TextStyle(fontSize: 20.0),
          decoration: InputDecoration(
              prefixIcon: Icon(
                prefixIcon,
                color: Palette.colorPrimary,
              ),
              hintText: hint,
              hintStyle: TextStyle(color: Palette.colorPrimary, fontSize: 14),
              focusColor: Palette.colorPrimary,
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Palette.colorPrimary))),
          validator: (value) {
            if (isUrlField) return null;
            if (isAmountField) {
              if (value == null || value.length <= 0)
                return Strings.errorEmptyTextField;
            } else {
              if (value == null || value.length < 3)
                return Strings.errorEmptyTextField;
              else
                return null;
            }
          },
          onSaved: onSaved as void Function(String?)?,
        ));
  }
}
