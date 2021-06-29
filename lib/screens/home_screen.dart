import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:will_buy_it/assets/custom_icons/will_buy_it_icons_icons.dart';
import 'package:will_buy_it/config/palette.dart';
import 'package:will_buy_it/config/strings.dart';
import 'package:will_buy_it/data/models/wish_list_item.dart';
import 'package:will_buy_it/data/view_state.dart';
import 'package:will_buy_it/helper/pair.dart';
import 'package:will_buy_it/helper/stateful_wrapper.dart';
import 'package:will_buy_it/providers/providers.dart';
import 'package:will_buy_it/screens/add_wish_list_screen.dart';
import 'package:will_buy_it/screens/wish_items_screen.dart';
import 'package:will_buy_it/widgets/platform_specific/alert_dialog.dart';
import 'package:will_buy_it/widgets/platform_specific/cupertino_alert_dialog.dart';
import 'package:will_buy_it/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StatefulWrapper(
      onInit: () {
        context
            .read(wishListItemsNotifierProvider.notifier)
            .getAllWishListItems();
      },
      child: Scaffold(
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
                Consumer(builder: (context, watch, child) {
                  final state = watch(totalCostNotifierProvider) as String;
                  return CustomSlider(
                    width: MediaQuery.of(context).size.width,
                    onConfirmation: () => _callSlideAction(context),
                    icon: Icons.delete,
                    text: state,
                    subText: Strings.descriptionTotalWishItemsCost,
                  );
                }),
                SizedBox(
                  height: 24.0,
                ),
                Expanded(child: Consumer(
                  builder: (context, watch, child) {
                    final state = watch(wishListItemsNotifierProvider);
                    if (state is Loading) {
                      return Loader();
                    } else if (state is Success<WishListItem>) {
                      if (state.items.isEmpty) {
                        return buildEmptyView();
                      } else {
                        return buildWishListItems(context, state.items);
                      }
                    } else {
                      return buildEmptyView();
                    }
                  },
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
      ),
    );
  }

  Column buildEmptyView() {
    return Column(
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
    );
  }

  ListView buildWishListItems(
      BuildContext context, List<WishListItem> wishlistItemsList) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 120.0),
      children: [
        ...wishlistItemsList.map(
          (wishItem) => GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => WishItemsScreen(wishItem.listTitle))),
            child: WishListCard(
                title: wishItem.listTitle,
                description: wishItem.listDescription,
                cost: wishItem.totalListItemCost,
                progress: wishItem.progress,
                isWishFullfilled: wishItem.isWishFullfilled,
                onDeleteClicked: () {}),
          ),
        )
      ],
    );
  }

  void _callSlideAction(BuildContext context) {
    {
      if (Platform.isAndroid) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => new AlertDialogg(
                title: Strings.dialogDeleteAllTitle,
                message: Strings.dialogDeleteAllMessage,
                positiveButtonPress: () => _onDeleteAllClicked(context)));
      } else {
        showCupertinoDialog(
            context: context,
            builder: (_) => new CupertinoAlertDialogg(
                title: Strings.dialogDeleteAllTitle,
                message: Strings.dialogDeleteAllMessage,
                positiveButtonPress: () => _onDeleteAllClicked(context)));
      }
    }
  }

  void _onDeleteAllClicked(BuildContext context) {
    context.read(wishListItemsNotifierProvider.notifier).deleteAllWishItems();
    Future.delayed(Duration(microseconds: 500), () {
      context
          .read(totalCostNotifierProvider.notifier)
          .getTotalCostOfAllWishes();
    });
  }
}
