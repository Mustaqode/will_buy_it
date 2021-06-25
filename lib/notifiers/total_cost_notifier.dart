import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:will_buy_it/config/enums.dart';
import 'package:will_buy_it/data/models/wish_item.dart';
import 'package:will_buy_it/data/models/wish_list_item.dart';
import 'package:will_buy_it/helper/pair.dart';
import 'package:will_buy_it/repository/wish_repo.dart';

class TotalCostNotifier extends StateNotifier<Pair<Currency, String>> {
  WishRepository wishRepository;

  TotalCostNotifier(this.wishRepository)
      : super(Pair(Currency.dollar, "0.0 \$"));

  void getTotalWishCostFromHome(List<WishListItem> wishListItem) {
    state = wishRepository.getAllWishesCost(wishListItem);
  }

  void getTotalWishCostFromWishesScreen(List<WishItem> wishList) {
    state = wishRepository.getCostOfAllItemsOfAWishList(wishList);
  }

  void slideToChangeCurrencyFromHome(List<WishListItem> wishListItem) {
    state = wishRepository.changeCurrencyFromHomeScreen(wishListItem);
  }

  void slideToChangeCurrencyFromWishesScreen(List<WishItem> wishList) {
    state = wishRepository.changeCurrencyFromWishScreen(wishList);
  }
}
