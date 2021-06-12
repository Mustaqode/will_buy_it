import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:will_buy_it/config/palette.dart';

class WishListCard extends StatelessWidget {
  final title;
  final description;
  final double cost;
  final double progress;
  final bool isWishFullfilled;
  final Function onDeleteClicked;

  const WishListCard(
      {required this.title,
      required this.description,
      required this.cost,
      required this.progress,
      this.isWishFullfilled = false,
      required this.onDeleteClicked});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildText(title, TextStyle(color: Colors.black, fontSize: 24.0)),
              buildText(description,
                  TextStyle(color: Palette.colorPrimary, fontSize: 18)),
              buildText(
                cost.toString() + ' \$',
                TextStyle(
                    color: Palette.colorPrimary,
                    fontWeight: FontWeight.w400,
                    fontSize: 24),
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
