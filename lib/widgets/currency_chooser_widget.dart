import 'package:flutter/material.dart';
import 'package:will_buy_it/config/constants.dart';
import 'package:will_buy_it/config/palette.dart';
import 'package:will_buy_it/config/strings.dart';

class CurrencyChooserBottomSheet extends StatelessWidget {
  final Function(String) onCurrencySelected;

  const CurrencyChooserBottomSheet(this.onCurrencySelected);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))),
      height: MediaQuery.of(context).size.height * 0.2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 20.0,
          ),
          Text(
            Strings.titleChooseACurrency,
            style: TextStyle(
                color: Palette.colorPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 26.0),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 1,
              scrollDirection: Axis.horizontal,
              children: Constants.currencies
                  .map((currency) => GestureDetector(
                        onTap: () {
                          onCurrencySelected(currency);
                          Navigator.of(context).pop();
                        },
                        child: Chip(
                          label: Text(
                            currency,
                            style: TextStyle(
                                color: Palette.colorPrimary,
                                fontSize: 26.0,
                                fontWeight: FontWeight.bold),
                          ),
                          backgroundColor: Palette.colorSecondary,
                        ),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),

      // child: Center(
      //   child: Icon(Icons.ac_unit_rounded),
      // ),
    );
  }
}
