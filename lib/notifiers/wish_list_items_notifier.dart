import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:will_buy_it/data/view_state.dart';
import 'package:will_buy_it/repository/wish_repo.dart';

class WishListItemNotifier extends StateNotifier<ViewState> {
  final WishRepository wishListRepository;

  WishListItemNotifier(this.wishListRepository) : super(Loading());

  Future<void> getAllWishListItems() async {
    try {
      state = Loading();
      final wishListItems = await wishListRepository.getAllWishListItem();
      state = Success(wishListItems);
    } catch (e) {
      state = Error("Some error"); //Handle later
    }
  }

  Future<void> deleteAllWishItems() async {
    try {
      state = Loading();
      await wishListRepository.deleteAllWishLists();
      await Future.delayed(Duration(milliseconds: 500), () {
        getAllWishListItems();
      });
    } catch (e) {
      state = Error("Some error");
    }
  }

  Future<void> deleteAWishListItem(String key) async {
    try {
      state = Loading();
      await wishListRepository.deleteAWishListItem(key);
      await Future.delayed(Duration(milliseconds: 500), () {
        getAllWishListItems();
      });
    } catch (e) {
      state = Error("Some Error");
    }
  }
}
