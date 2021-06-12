import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:will_buy_it/assets/custom_icons/will_buy_it_icons_icons.dart';
import 'package:will_buy_it/config/palette.dart';
import 'package:will_buy_it/config/strings.dart';
import 'package:will_buy_it/model/models.dart';
import 'package:will_buy_it/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          Strings.appTitle,
          style: TextStyle(
            fontFamily: GoogleFonts.playball().fontFamily,
          ),
        ),
      ),
      body: Stack(alignment: Alignment.center, children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Palette.colorSecondary,
              borderRadius: BorderRadius.circular(40.0)),
          child: Column(
            children: [
              CustomSlider(
                onConfirmation: () {},
                icon: WillBuyItIcons.rupee_indian,
                text: '20,000 \$',
                subText: Strings.descriptionTotalWishItemsCost,
              ),
              SizedBox(
                height: 24.0,
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 120.0),
                  children: [
                    ...wishListItems.map((wishItem) => WishListCard(
                        title: wishItem.listTitle,
                        description: wishItem.listDescription,
                        cost: wishItem.totalListItemCost,
                        progress: wishItem.progress,
                        onDeleteClicked: () {}))
                  ],
                ),
              )
            ],
          ),
        ),
        Positioned(bottom: 0, left: 0, right: 0, child: BlurWidget()),
        Positioned(
          bottom: 60.0,
          child: ButtonWidget(Strings.btnTextStartAWishList, () {}),
        )
      ]),
    );
  }
}
