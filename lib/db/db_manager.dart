import 'package:hive/hive.dart';
import 'package:will_buy_it/config/constants.dart';
import 'package:will_buy_it/data/models/wish_item.dart';
import 'package:will_buy_it/data/models/wish_list_item.dart';

abstract class DbManager {
  Future<void> addAll(List<WishListItem> wishListItems);
  Future<List<WishListItem>> getAllWishListItems();
  Future<void> addANewWishListItem(WishListItem wishListItem);
  Future<void> deleteAWishListItem(String key);
  Future<void> deleteAllWishListItems();
  Future<void> updateAWishListItem(WishListItem wishListItem);

  //Wish Items Db Operation
  Future<List<WishItem>> getAllWishes();
  Future<List<WishItem>> getAllWishItemsFromAWishList(String key);
  Future<void> addANewWish(WishItem wishItem);
  Future<void> deleteAWish(String key);
  Future<void> updateAWish(WishItem wishItem);
}

class DbManagerImpl extends DbManager {
  @override
  Future<void> addAll(List<WishListItem> wishListItems) {
    var box = Hive.box<WishListItem>(Constants.wishListBox);
    return box.addAll(wishListItems);
  }

  @override
  Future<List<WishListItem>> getAllWishListItems() async {
    var box = Hive.box<WishListItem>(Constants.wishListBox);
    return box.values.toList().cast<WishListItem>();
  }

  @override
  Future<List<WishItem>> getAllWishes() async {
    var box = await Hive.openBox(Constants.wishItemBox);
    return box.values.toList().cast<WishItem>();
  }

  @override
  Future<List<WishItem>> getAllWishItemsFromAWishList(String key) async {
    var box = Hive.box<WishItem>(Constants.wishItemBox);
    return box.values
        .where((e) => e.listTitle == key)
        .toList()
        .cast<WishItem>();
  }

  @override
  Future<void> addANewWish(WishItem wishItem) async {
    var box = await Hive.openBox(Constants.wishItemBox);
    box.put(wishItem.itemName, wishItem);
  }

  @override
  Future<void> addANewWishListItem(WishListItem wishListItem) async {
    var box = await Hive.openBox(Constants.wishListBox);
    box.put(wishListItem.listTitle, wishListItem);
  }

  @override
  Future<void> deleteAWish(String key) async {
    var box = await Hive.openBox(Constants.wishItemBox);
    box.delete(key);
  }

  @override
  Future<void> deleteAWishListItem(String key) async {
    var box = await Hive.openBox(Constants.wishListBox);
    box.delete(key);
  }

  @override
  Future<void> deleteAllWishListItems() async {
    var box = Hive.box<WishListItem>(Constants.wishListBox);
    box.clear();
  }

  @override
  Future<void> updateAWish(WishItem wishItem) async {
    var box = await Hive.openBox(Constants.wishItemBox);
    box.put(wishItem.itemName, wishItem);
  }

  @override
  Future<void> updateAWishListItem(WishListItem wishListItem) async {
    var box = await Hive.openBox(Constants.wishListBox);
    box.put(wishListItem.listTitle, wishListItem);
  }
}
