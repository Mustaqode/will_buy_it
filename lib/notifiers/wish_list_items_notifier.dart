import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:will_buy_it/data/models/wish_item.dart';
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
      final currency = wishListRepository.getCurrentCurrency();
      List<WishListItem> _wishListItems = [];
      wishListItems.forEach((element) {
        _wishListItems.add(element.edit(currency: currency));
      });
      state = Success(_wishListItems);
      _updateProgress(_wishListItems);
    } catch (e) {
      state = Error("Some error"); //Handle later
    }
  }

  void _updateProgress(List<WishListItem> wishListItems) async {
    final List<WishListItem> resultList = [];
    final List<WishItem> resultWishItemList = [];

    final wishItems = await wishListRepository.getAllWishItems();
    wishListItems.forEach((wishList) {
      resultWishItemList.clear();
      wishItems.forEach((wish) {
        if (wish.listTitle == wishList.listTitle) {
          resultWishItemList.add(wish);
        }
      });
      var total = resultWishItemList.length;
      var fulfilledCount = 0;
      resultWishItemList.forEach((resultWish) {
        if (resultWish.isWishFullfilled) {
          fulfilledCount += 1;
        }
      });

      double progress = fulfilledCount / total;

      resultList.add(wishList.edit(progress: progress));
    });
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

  Future<void> addAWishListItem(WishListItem wishListItem) async {
    try {
      state = Loading();
      await wishListRepository.addAWishListItem(wishListItem);
      await Future.delayed(Duration(milliseconds: 500), () {
        getAllWishListItems();
      });
    } catch (e) {
      state = Error("Some error");
    }
  }
}
