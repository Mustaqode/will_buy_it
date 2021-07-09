import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:will_buy_it/providers/providers.dart';
import 'package:will_buy_it/data/models/wish_item.dart';
import 'package:will_buy_it/data/models/wish_list_item.dart';

class ProviderManager {
  static getAllWishListItems(BuildContext context) {
    context.read(wishListItemsNotifierProvider.notifier).getAllWishListItems();
  }

  static getAllWishItemsOfTheList(BuildContext context, String key) {
    context.read(wishItemsNotifierProvider.notifier).getAllWishItems(key);
  }

  static getTotalCostOfAllWishLists(
      BuildContext context, List<WishListItem>? wishListItems) {
    context
        .read(totalCostNotifierProvider.notifier)
        .getTotalCostOfAllWishes(wishListItems ?? null);
  }

  static getTotalCostOfAllWishesOfTheList(
      BuildContext context, List<WishItem>? wishItemsList, String key) {
    context
        .read(totalCostWishItemsNotifierProvider.notifier)
        .getTotalCostOfAllWishes(wishItemsList ?? null, key);
  }

  static deleteAllWishListItems(BuildContext context) {
    context.read(wishListItemsNotifierProvider.notifier).deleteAllWishItems();
  }

  static deleteAWishListItem(BuildContext context, String key) {
    context
        .read(wishListItemsNotifierProvider.notifier)
        .deleteAWishListItem(key);
  }

  static deleteAllWishItems(BuildContext context, String key) {
    context.read(wishItemsNotifierProvider.notifier).deleteAllWishItems(key);
  }

  static deleteAWishItem(BuildContext context, WishItem wishItem) {
    context.read(wishItemsNotifierProvider.notifier).deleteAWishItem(wishItem);
  }

  static addAWishItem(
      {required BuildContext context,
      required WishItem wishItem,
      String? key}) {
    context
        .read(wishItemsNotifierProvider.notifier)
        .addAWishItem(wishItem, key);
  }

  static addAWishListItem(
      BuildContext context, WishListItem wishListItem, String? key) {
    context
        .read(wishListItemsNotifierProvider.notifier)
        .addAWishListItem(wishListItem, key);
  }
}
