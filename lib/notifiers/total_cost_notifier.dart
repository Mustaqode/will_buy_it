import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:will_buy_it/data/models/wish_list_item.dart';
import 'package:will_buy_it/repository/wish_repo.dart';

class TotalCostNotifier extends StateNotifier<String> {
  WishRepository wishRepository;

  TotalCostNotifier(this.wishRepository) : super(" 0.0 \$");

  void getTotalCostOfAllWishes() async {
    List<WishListItem> wishListItems = await _getAllWishListItems();
    state = wishRepository.getAllWishesCost(wishListItems);
  }

  Future<List<WishListItem>> _getAllWishListItems() {
    return wishRepository.getAllWishListItem();
  }
}
