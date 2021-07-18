import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:will_buy_it/data/models/wish_list_item.dart';
import 'package:will_buy_it/repository/wish_repo.dart';

class TotalCostNotifier extends StateNotifier<String> {
  WishRepository wishRepository;

  TotalCostNotifier(this.wishRepository) : super(" 0.0 \$");

  void getTotalCostOfAllWishes(List<WishListItem>? wishListItems) async {
    List<WishListItem> _wishListItems =
        wishListItems ?? await _getAllWishListItems();
    state = await wishRepository.getAllWishesCost(_wishListItems);
  }

  Future<List<WishListItem>> _getAllWishListItems() {
    return wishRepository.getAllWishListItem();
  }
}
