import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:will_buy_it/data/view_state.dart';
import 'package:will_buy_it/repository/wish_repo.dart';

class WishItemsNotifier extends StateNotifier<ViewState> {
  final WishRepository wishListRepository;

  WishItemsNotifier(this.wishListRepository) : super(Loading());

  Future<void> getAllWishItems(String key) async {
    try {
      state = Loading();
      final wishItems = await wishListRepository.getAllWishItemOfTheList(key);
      state = Success(wishItems);
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
}
