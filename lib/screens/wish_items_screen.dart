import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:will_buy_it/assets/custom_icons/will_buy_it_icons_icons.dart';
import 'package:will_buy_it/config/constants.dart';
import 'package:will_buy_it/config/palette.dart';
import 'package:will_buy_it/config/screen_args_models.dart';
import 'package:will_buy_it/config/strings.dart';
import 'package:will_buy_it/data/models/wish_item.dart';
import 'package:will_buy_it/data/view_state.dart';
import 'package:will_buy_it/helper/stateful_wrapper.dart';
import 'package:will_buy_it/providers/provider_manager.dart';
import 'package:will_buy_it/providers/providers.dart';
import 'package:will_buy_it/screens/add_wish_item_screen.dart';
import 'package:will_buy_it/screens/add_wish_list_screen.dart';
import 'package:will_buy_it/widgets/widgets.dart';

// ignore: must_be_immutable
class WishItemsScreen extends StatelessWidget {
  static const routeName = Constants.routeWishItem;
  late String listTitle;
  late String listDescription;

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as WishItemsScreenArgs;
    listTitle = args.listTitle;
    listDescription = args.listDescription;

    return StatefulWrapper(
      onInit: () {
        ProviderManager.getAllWishItemsOfTheList(context, listTitle);
      },
      child: Scaffold(
        appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(AddWishListScreen.routeName,
                    arguments:
                        AddWishListScreenArgs(listTitle, listDescription));
              },
              child: Text(
                listTitle,
                style: TextStyle(
                    fontFamily: GoogleFonts.playball().fontFamily,
                    fontSize: 22.0),
                overflow: TextOverflow.ellipsis,
              ),
            )),
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
                Consumer(
                  builder: (context, watch, child) {
                    final state =
                        watch(totalCostWishItemsNotifierProvider) as String;
                    return CustomSlider(
                      width: MediaQuery.of(context).size.width,
                      onConfirmation: () => _callSlideAction(context),
                      icon: Icons.delete,
                      text: state,
                      subText: Strings.descriptionTotalWishItemsCost,
                    );
                  },
                ),
                SizedBox(
                  height: 24.0,
                ),
                Expanded(child: Consumer(
                  builder: (context, watch, child) {
                    final state = watch(wishItemsNotifierProvider);
                    if (state is Loading) {
                      return Loader();
                    } else if (state is Success<WishItem>) {
                      if (state.items.isEmpty) {
                        return buildEmptyView(context, state.items);
                      } else {
                        return buildWishItems(context, state.items);
                      }
                    } else {
                      return Loader();
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
                Strings.btnTextAddAProduct,
                () => Navigator.of(context).pushNamed(
                    AddWishItemScreen.routeName,
                    arguments: AddWishItemScreenArgs(listTitle: listTitle))),
          )
        ]),
      ),
    );
  }

  ListView buildWishItems(BuildContext context, List<WishItem> wishItemsList) {
    Future.delayed(Duration.zero, () {
      ProviderManager.getTotalCostOfAllWishesOfTheList(
          context, wishItemsList, listTitle);
    });
    return ListView(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 120.0),
      children: [
        ...wishItemsList.map((wishItem) => GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(AddWishItemScreen.routeName,
                    arguments: AddWishItemScreenArgs(
                        listTitle: listTitle, wishItem: wishItem));
              },
              child: WishItemCard(
                  title: wishItem.itemName,
                  description: wishItem.itemDescription,
                  cost: wishItem.itemCost,
                  currency: wishItem.currency,
                  isWishFullfilled: wishItem.isWishFullfilled,
                  onDeleteClicked: () {
                    ProviderManager.deleteAWishItem(context, wishItem);
                    Future.delayed(Duration.zero, () {
                      ProviderManager.getAllWishListItems(context);
                      ProviderManager.getTotalCostOfAllWishLists(context, null);
                    });
                  },
                  onConfirmation: () {
                    print("Invoked");
                  }),
            ))
      ],
    );
  }

  Column buildEmptyView(BuildContext context, List<WishItem> wishItems) {
    Future.delayed(Duration.zero, () {
      ProviderManager.getTotalCostOfAllWishesOfTheList(
          context, wishItems, listTitle);
    });
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

  void _callSlideAction(BuildContext context) {
    final state = context.read(wishItemsNotifierProvider);
    if (state is Success<WishItem> && state.items.isNotEmpty) {
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
    ProviderManager.deleteAllWishItems(context, listTitle);
  }
}
