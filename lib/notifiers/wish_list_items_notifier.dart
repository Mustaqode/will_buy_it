import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:will_buy_it/data/models/wish_list_item.dart';
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
      // state = Success([] as List<WishListItem>);
    } catch (e) {
      state = Error("Some error");
    }
  }
}
