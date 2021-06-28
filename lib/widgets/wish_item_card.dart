import 'package:flutter/material.dart';
import 'package:will_buy_it/config/palette.dart';
import 'package:will_buy_it/config/strings.dart';
import 'package:will_buy_it/widgets/widgets.dart';

class WishItemCard extends StatelessWidget {
  final title;
  final description;
  final double cost;
  final bool isWishFullfilled;
  final VoidCallback onDeleteClicked;
  final VoidCallback onConfirmation;

  const WishItemCard(
      {required this.title,
      required this.description,
      required this.cost,
      required this.onDeleteClicked,
      required this.onConfirmation,
      this.isWishFullfilled = true});

  @override
  Widget build(BuildContext context) {
    final height = 200.0;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 30.0),
      height: height,
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Column(children: [
          Container(
            height: height - (height / 2.25),
            child: Stack(children: [
              Container(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildText(
                        title, TextStyle(color: Colors.black, fontSize: 24.0)),
                    buildText(description,
                        TextStyle(color: Palette.colorPrimary, fontSize: 18)),
                    buildText(
                      cost.toString() + ' \$',
                      TextStyle(
                          color: Palette.colorPrimary,
                          fontWeight: FontWeight.w400,
                          fontSize: 24),
                    ),
                  ],
                ),
              ),
              if (isWishFullfilled)
                Container(
                  decoration: BoxDecoration(
                      color: Palette.cardColorBought,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0))),
                  child: Center(
                    child: Icon(
                      Icons.done_all,
                      color: Colors.white,
                      size: 64.0,
                    ),
                  ),
                ),
            ]),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 20.0),
                CustomSlider(
                  width: 150.0,
                  height: height / 5,
                  onConfirmation: onConfirmation,
                  icon: Icons.card_giftcard,
                  textStyle:
                      TextStyle(fontSize: 20.0, color: Palette.colorPrimary),
                  text: isWishFullfilled
                      ? Strings.btnTextUnBuy
                      : Strings.btnTextBuy,
                  sliderElementColor: isWishFullfilled
                      ? Palette.sliderHeadUnBuy
                      : Palette.progressColorActive,
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                IconButton(
                    icon: Icon(Icons.delete, color: Palette.colorPrimary),
                    onPressed: onDeleteClicked),
                IconButton(
                    icon: Icon(Icons.link, color: Palette.colorPrimary),
                    onPressed: onDeleteClicked),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Padding buildText(String text, TextStyle textStyle) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Text(
        text,
        style: textStyle,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
