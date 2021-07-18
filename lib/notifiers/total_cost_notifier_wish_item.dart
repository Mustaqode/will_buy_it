import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:will_buy_it/data/models/wish_item.dart';
import 'package:will_buy_it/repository/wish_repo.dart';

class TotalCostNotifierWishItem extends StateNotifier<String> {
  WishRepository wishRepository;

  TotalCostNotifierWishItem(this.wishRepository) : super(" 0.0 \$");

  void getTotalCostOfAllWishes(List<WishItem>? wishItems, String key) async {
    List<WishItem> _wishListItems = wishItems ?? await _getAllWishItems(key);
    state = await wishRepository.getCostOfAllItemsOfAWishList(_wishListItems);
  }

  Future<List<WishItem>> _getAllWishItems(String key) {
    return wishRepository.getAllWishItemOfTheList(key);
  }
}
