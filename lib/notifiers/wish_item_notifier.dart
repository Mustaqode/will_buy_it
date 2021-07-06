import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:will_buy_it/data/models/wish_item.dart';
import 'package:will_buy_it/data/view_state.dart';
import 'package:will_buy_it/repository/wish_repo.dart';

class WishItemsNotifier extends StateNotifier<ViewState> {
  final WishRepository wishListRepository;

  WishItemsNotifier(this.wishListRepository) : super(Loading());

  Future<void> getAllWishItems(String key) async {
    try {
      state = Loading();
      final wishItems = await wishListRepository.getAllWishItemOfTheList(key);
      final currency = wishListRepository.getCurrentCurrency();
      List<WishItem> _wishItems = [];
      wishItems.forEach((element) {
        _wishItems.add(element.edit(currency: currency));
      });
      state = Success(_wishItems);
    } catch (e) {
      state = Error("Some error");
    }
  }

  Future<void> deleteAllWishItems(String key) async {
    try {
      state = Loading();
      await wishListRepository.deleteAllItemsOfTheList(key);
      await Future.delayed(Duration(milliseconds: 500), () {
        getAllWishItems(key);
      });
    } catch (e) {
      state = Error("Some error");
    }
  }

  Future<void> addAWishItem(WishItem wishItem, String? key) async {
    try {
      state = Loading();
      await wishListRepository.addAWishItem(wishItem, key);
      await Future.delayed(Duration(milliseconds: 500), () {
        getAllWishItems(wishItem.listTitle);
      });
    } catch (e) {
      state = Error("Some error");
    }
  }

  Future<void> deleteAWishItem(WishItem wishItem) async {
    try {
      state = Loading();
      await wishListRepository.deleteAWishItem(wishItem);
      await Future.delayed(Duration(milliseconds: 500), () {
        getAllWishItems(wishItem.listTitle);
      });
    } catch (e) {}
  }
}
