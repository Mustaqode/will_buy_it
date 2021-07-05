import 'package:will_buy_it/data/models/wish_item.dart';
import 'package:will_buy_it/data/models/wish_list_item.dart';
import 'package:will_buy_it/db/db_manager.dart';
import 'package:will_buy_it/db/pref_manager.dart';

abstract class WishRepository {
  Future<void> addAWishListItem(WishListItem wishListItem);

  Future<List<WishListItem>> getAllWishListItem();

  Future<List<WishItem>> getAllWishItems();

  Future<void> deleteAWishListItem(String key);

  Future<void> deleteAllWishLists();

  Future<void> deleteAllItemsOfTheList(String key);

  Future<List<WishItem>> getAllWishItemOfTheList(String key);

  Future<void> addAWishItem(WishItem wishItem);

  Future<void> deleteAWishItem(WishItem key);

  String getAllWishesCost(List<WishListItem> wishList);

  String getCostOfAllItemsOfAWishList(List<WishItem> wishList);

  String getCurrentCurrency();
}

class WishRepositoryImpl extends WishRepository {
  DbManager dbManager;
  PreferenceManager preferenceManager;

  WishRepositoryImpl(this.dbManager, this.preferenceManager);

  @override
  Future<List<WishListItem>> getAllWishListItem() async {
    return dbManager.getAllWishListItems();
  }

  @override
  Future<List<WishItem>> getAllWishItemOfTheList(String key) {
    return dbManager.getAllWishItemsFromAWishList(key);
  }

  @override
  String getAllWishesCost(List<WishListItem> wishList) {
    String currency = preferenceManager.getCurrentCurrency();
    var totalCost = 0.0;
    wishList.forEach((element) {
      totalCost = totalCost + element.totalListItemCost;
    });
    return "${totalCost.toStringAsFixed(2)} $currency";
  }

  @override
  String getCostOfAllItemsOfAWishList(List<WishItem> wishItemList) {
    String currency = preferenceManager.getCurrentCurrency();
    var totalCost = 0.0;
    wishItemList.forEach((element) {
      totalCost = totalCost + element.itemCost;
    });

    return "${totalCost.toStringAsFixed(2)} $currency";
  }

  @override
  Future<void> deleteAllWishLists() {
    return dbManager.deleteAllWishListItems();
  }

  @override
  Future<void> deleteAllItemsOfTheList(String key) {
    return dbManager.deleteAllItemsOfTheList(key);
  }

  @override
  Future<void> deleteAWishListItem(String key) {
    return dbManager.deleteAWishListItem(key);
  }

  @override
  String getCurrentCurrency() {
    return preferenceManager.getCurrentCurrency();
  }

  // Add a wish item and update total cost of the parent list card.
  @override
  Future<void> addAWishItem(WishItem wishItem) async {
    late WishListItem wishListOfTheItem;
    var wishListItems = await dbManager.getAllWishListItems();
    wishListItems.forEach((wishListItem) {
      if (wishListItem.listTitle == wishItem.listTitle) {
        wishListOfTheItem = wishListItem;
      }
    });
    final updatedWishListItem = wishListOfTheItem.edit(
        totalListItemCost:
            (wishListOfTheItem.totalListItemCost + wishItem.itemCost));
    dbManager.addOrUpdateAWishListItem(updatedWishListItem);
    return dbManager.addOrUpdateAWish(wishItem);
  }

  @override
  Future<void> addAWishListItem(WishListItem wishListItem) {
    return dbManager.addOrUpdateAWishListItem(wishListItem);
  }

  @override
  Future<List<WishItem>> getAllWishItems() {
    return dbManager.getAllWishes();
  }

  // Update the cost of the corresponding wishlist item while deleting a wish
  @override
  Future<void> deleteAWishItem(WishItem wishItem) async {
    WishListItem item = await dbManager.getTheWishListItem(wishItem.listTitle);
    final updatedItem = item.edit(
        totalListItemCost: item.totalListItemCost - wishItem.itemCost);
    await dbManager.addOrUpdateAWishListItem(updatedItem);
    return dbManager.deleteAWish(wishItem.itemName);
  }
}
