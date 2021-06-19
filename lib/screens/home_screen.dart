import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:will_buy_it/assets/custom_icons/will_buy_it_icons_icons.dart';
import 'package:will_buy_it/config/palette.dart';
import 'package:will_buy_it/config/strings.dart';
import 'package:will_buy_it/data/models.dart';
import 'package:will_buy_it/screens/add_wish_list_screen.dart';
import 'package:will_buy_it/screens/wish_items_screen.dart';
import 'package:will_buy_it/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          Strings.appTitle,
          style: TextStyle(
              fontFamily: GoogleFonts.playball().fontFamily, fontSize: 22.0),
        ),
      ),
      body: Stack(alignment: Alignment.center, children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Palette.colorSecondary,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0))),
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
              wishListItems.isNotEmpty
                  ? Expanded(
                      child: ListView(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 120.0),
                      children: [
                        ...wishListItems.map((wishItem) => GestureDetector(
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) => WishItemsScreen())),
                              child: WishListCard(
                                  title: wishItem.listTitle,
                                  description: wishItem.listDescription,
                                  cost: wishItem.totalListItemCost,
                                  progress: wishItem.progress,
                                  isWishFullfilled: wishItem.isWishFullfilled,
                                  onDeleteClicked: () {}),
                            ))
                      ],
                    ))
                  : Expanded(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          WillBuyItIcons.favourite,
                          size: 76.0,
                          color: Palette.colorPrimary,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            Strings.tagEmptyWishListPage,
                            style: TextStyle(
                                fontFamily: GoogleFonts.playball().fontFamily,
                                fontSize: 14,
                                color: Palette.colorPrimary),
                          ),
                        ),
                        SizedBox(
                          height: 100.0,
                        )
                      ],
                    )),
            ],
          ),
        ),
        Positioned(bottom: 0, left: 0, right: 0, child: BlurWidget()),
        Positioned(
          bottom: 60.0,
          child: ButtonWidget(
              Strings.btnTextStartAWishList,
              () => Navigator.of(context).push(MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (_) => AddWishListScreen()))),
        )
      ]),
    );
  }
}
