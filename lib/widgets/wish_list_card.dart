import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:will_buy_it/config/palette.dart';

class WishListCard extends StatelessWidget {
  final title;
  final description;
  final double cost;
  final String currency;
  final double progress;
  final bool isWishFullfilled;
  final VoidCallback onDeleteClicked;

  const WishListCard(
      {required this.title,
      required this.description,
      required this.cost,
      required this.currency,
      required this.progress,
      this.isWishFullfilled = true,
      required this.onDeleteClicked});

  @override
  Widget build(BuildContext context) {
    final height = 200.0;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 30.0),
      height: height,
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Stack(children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildText(
                    title, TextStyle(color: Colors.black, fontSize: 24.0)),
                buildText(description,
                    TextStyle(color: Palette.colorPrimary, fontSize: 18)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildText(
                      "${cost.toStringAsFixed(2)} $currency",
                      TextStyle(
                          color: Palette.colorPrimary,
                          fontWeight: FontWeight.w400,
                          fontSize: 24),
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Palette.colorPrimary,
                        ),
                        onPressed: onDeleteClicked)
                  ],
                ),
                ClipRRect(
                  clipBehavior: Clip.antiAlias,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0)),
                  child: Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: LinearPercentIndicator(
                      lineHeight: 20.0,
                      percent: progress,
                      linearStrokeCap: LinearStrokeCap.roundAll,
                      backgroundColor: Palette.progressColorInActive,
                      progressColor: Palette.progressColorActive,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (isWishFullfilled)
            Container(
              constraints: BoxConstraints(maxHeight: double.infinity),
              decoration: BoxDecoration(
                  color: Palette.cardColorBought,
                  borderRadius: BorderRadius.circular(20.0)),
              child: Stack(children: [
                Center(
                  child: Icon(
                    Icons.done_all,
                    color: Colors.white,
                    size: 76.0,
                  ),
                ),
                Positioned(
                    right: 16,
                    bottom: 10,
                    child: GestureDetector(
                      onTap: onDeleteClicked,
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 32.0,
                      ),
                    ))
              ]),
            ),
        ]),
      ),
    );
  }

  Padding buildText(String text, TextStyle textStyle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
      child: Text(
        text,
        style: textStyle,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
