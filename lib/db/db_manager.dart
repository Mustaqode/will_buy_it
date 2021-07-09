import 'package:hive/hive.dart';
import 'package:will_buy_it/config/constants.dart';
import 'package:will_buy_it/data/models/wish_item.dart';
import 'package:will_buy_it/data/models/wish_list_item.dart';

abstract class DbManager {
  Future<void> addAll(List<WishListItem> wishListItems);
  Future<List<WishListItem>> getAllWishListItems();
  Future<WishListItem> getTheWishListItem(String key);
  Future<void> addOrUpdateAWishListItem(WishListItem wishListItem, String? key);
  Future<void> deleteAWishListItem(String wishListItemKey);
  Future<void> deleteAllWishListItems();

  //Wish Items Db Operation
  Future<List<WishItem>> getAllWishes();
  Future<List<WishItem>> getAllWishItemsFromAWishList(String key);
  Future<void> replaceAllItemsOfAWishList(List<WishItem> wishItems, String key);
  Future<void> addOrUpdateAWish(WishItem wishItem, String? key);
  Future<void> deleteAWish(String key);
  Future<void> deleteAllItemsOfTheList(String wishItemKey);
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
    var box = Hive.box<WishItem>(Constants.wishItemBox);
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
  Future<void> addOrUpdateAWish(WishItem wishItem, String? key) {
    var box = Hive.box<WishItem>(Constants.wishItemBox);
    if (key != null) {
      var containsKey = box.containsKey(key);
      if (containsKey) {
        box.delete(key); // Kinda Ugly way; use index instead
      }
    }
    return box.put(wishItem.itemName, wishItem);
  }

  @override
  Future<void> addOrUpdateAWishListItem(
      WishListItem wishListItem, String? key) {
    var box = Hive.box<WishListItem>(Constants.wishListBox);
    if (key != null) {
      var containsKey = box.containsKey(key);
      if (containsKey) {
        box.delete(key); // Kinda Ugly way; use index instead
      }
    }
    return box.put(wishListItem.listTitle, wishListItem);
  }

  @override
  Future<void> deleteAWish(String key) {
    var box = Hive.box<WishItem>(Constants.wishItemBox);
    return box.delete(key);
  }

  @override
  Future<void> deleteAWishListItem(String wishListItemKey) {
    var box = Hive.box<WishListItem>(Constants.wishListBox);
    dynamic desiredKey;
    box.toMap().forEach((key, value) {
      if (value.listTitle == wishListItemKey) {
        desiredKey = key;
      }
    });
    return box.delete(desiredKey);
  }

  @override
  Future<void> deleteAllWishListItems() {
    var box = Hive.box<WishListItem>(Constants.wishListBox);
    var box2 = Hive.box<WishItem>(Constants.wishItemBox);
    box.clear();
    return box2.clear();
  }

  @override
  Future<void> deleteAllItemsOfTheList(String wishItemKey) {
    var box = Hive.box<WishItem>(Constants.wishItemBox);
    var boxAsMap = box.toMap();
    List<dynamic> desiredKeys = [];
    boxAsMap.forEach((key, value) {
      if (value.listTitle == wishItemKey) {
        desiredKeys.add(key);
      }
    });
    return box.deleteAll(desiredKeys);
  }

  @override
  Future<WishListItem> getTheWishListItem(String key) async {
    var box = Hive.box<WishListItem>(Constants.wishListBox);
    return box.values.firstWhere((element) => element.listTitle == key);
  }

  @override
  Future<void> replaceAllItemsOfAWishList(
      List<WishItem> wishItems, String key) async {
    var box = Hive.box<WishItem>(Constants.wishItemBox);
    await deleteAllItemsOfTheList(key);
    Map<dynamic, WishItem> wishItemsMap = {};
    wishItems.forEach((element) {
      wishItemsMap.putIfAbsent(element.itemName, () => element);
    });
    box.putAll(wishItemsMap);
  }
}
