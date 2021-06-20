import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:will_buy_it/data/custom_wish_state.dart';
import 'package:will_buy_it/repository/wish_list_repo.dart';

class WishListItemNotifier extends StateNotifier<WishListState> {
  final WishListRepository wishListRepository;

  WishListItemNotifier(this.wishListRepository) : super(Loading());

  Future<void> getAllWishListItems() async {
    try {
      state = Loading();
      final wishListItems = await wishListRepository.getAllWishList();
      state = Success(wishListItems);
    } catch (e) {
      state = Error("Some error");
    }
  }
}
