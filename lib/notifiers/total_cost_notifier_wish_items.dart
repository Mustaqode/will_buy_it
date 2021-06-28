import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:will_buy_it/assets/custom_icons/will_buy_it_icons_icons.dart';
import 'package:will_buy_it/config/enums.dart';
import 'package:will_buy_it/data/models/wish_item.dart';
import 'package:will_buy_it/data/models/wish_list_item.dart';
import 'package:will_buy_it/helper/pair.dart';
import 'package:will_buy_it/repository/wish_repo.dart';

class WishItemsTotalCostNotifier extends StateNotifier<Pair<IconData, String>> {
  WishRepository wishRepository;

  WishItemsTotalCostNotifier(this.wishRepository)
      : super(Pair(Icons.attach_money, "0.0 \$"));

  void getTotalWishesCost(List<WishItem> wishListItem) {
    var totalCostObject =
        wishRepository.getCostOfAllItemsOfAWishList(wishListItem);
    Currency currency = totalCostObject.itemOne;
    IconData icon;
    switch (currency) {
      case Currency.rupee:
        icon = WillBuyItIcons.rupee_indian;
        break;
      default:
        icon = Icons.attach_money;
    }
    state = Pair(icon, totalCostObject.itemTwo);
  }

  // void getTotalWishCostFromWishesScreen(List<WishItem> wishList) {
  //   state = wishRepository.getCostOfAllItemsOfAWishList(wishList);
  // }

  Future<void> slideToChangeCurrency(String key) async {
    List<WishItem>? wishListItem =
        await wishRepository.getAllWishItemOfTheList(key);
    var totalCostObject =
        wishRepository.changeCurrencyFromWishScreen(wishListItem);
    Currency currency = totalCostObject.itemOne;
    IconData icon;
    switch (currency) {
      case Currency.rupee:
        icon = WillBuyItIcons.rupee_indian;
        break;
      default:
        icon = Icons.attach_money;
    }
    state = Pair(icon, totalCostObject.itemTwo);
  }
}
