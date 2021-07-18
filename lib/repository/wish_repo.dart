import 'package:will_buy_it/data/models/wish_item.dart';
import 'package:will_buy_it/data/models/wish_list_item.dart';
import 'package:will_buy_it/db/db_manager.dart';
import 'package:will_buy_it/db/pref_manager.dart';

abstract class WishRepository {
  Future<void> addAWishListItem(WishListItem wishListItem, String? key);

  Future<List<WishListItem>> getAllWishListItem();

  Future<List<WishItem>> getAllWishItems();

  Future<void> deleteAWishListItem(String key);

  Future<void> deleteAllWishLists();

  Future<void> deleteAllItemsOfTheList(String key);

  Future<List<WishItem>> getAllWishItemOfTheList(String key);

  Future<void> changeIsWishFullFillState(WishItem wishItem);

  Future<void> addAWishItem(WishItem wishItem, String? key);

  Future<void> deleteAWishItem(WishItem key);

  Future<String> getAllWishesCost(List<WishListItem> wishList);

  Future<String> getCostOfAllItemsOfAWishList(List<WishItem> wishList);

  Future<String> getCurrentCurrency();

  void changeCurrency(String currency);
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
  Future<String> getAllWishesCost(List<WishListItem> wishList) async {
    String currency = await preferenceManager.getCurrentCurrency();
    var totalCost = 0.0;
    wishList.forEach((element) {
      totalCost = totalCost + element.totalListItemCost;
    });
    return "${totalCost.toStringAsFixed(2)} $currency";
  }

  @override
  Future<String> getCostOfAllItemsOfAWishList(
      List<WishItem> wishItemList) async {
    String currency = await preferenceManager.getCurrentCurrency();
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
  Future<String> getCurrentCurrency() async {
    return preferenceManager.getCurrentCurrency();
  }

  // Add a wish item and update total cost of the parent list card.
  @override
  Future<void> addAWishItem(WishItem wishItem, String? key) async {
    await _updateTotalCostOfTheWishListItem(wishItem, key);
    return dbManager.addOrUpdateAWish(wishItem, key);
  }

  Future<void> _updateTotalCostOfTheWishListItem(
      WishItem wishItem, String? key) async {
    var existingItemCost;
    double? updatedTotalCost;
    WishListItem item = await dbManager.getTheWishListItem(wishItem.listTitle);
    await dbManager
        .getAllWishItemsFromAWishList(wishItem.listTitle)
        .then((value) => value.forEach((element) {
              if (element.itemName == key) {
                existingItemCost = element.itemCost;
              }
            }));

    if (key == null) {
      updatedTotalCost = item.totalListItemCost + wishItem.itemCost;
    } else if (existingItemCost != wishItem.itemCost) {
      if (existingItemCost > wishItem.itemCost) {
        updatedTotalCost =
            item.totalListItemCost - (existingItemCost - wishItem.itemCost);
      } else {
        updatedTotalCost =
            item.totalListItemCost + (wishItem.itemCost - existingItemCost);
      }
    }

    final updatedWishListItem = item.edit(totalListItemCost: updatedTotalCost);
    dbManager.addOrUpdateAWishListItem(updatedWishListItem, key);
  }

  @override
  Future<void> addAWishListItem(WishListItem wishListItem, String? key) async {
    WishListItem updateWishListItem = wishListItem;
    if (key != null) {
      /// Copy Existing Wish List Card's info to the new updated card
      WishListItem existingWishListItem =
          await dbManager.getTheWishListItem(key);
      updateWishListItem = updateWishListItem.edit(
          totalListItemCost: existingWishListItem.totalListItemCost,
          progress: existingWishListItem.progress,
          isWishFullfilled: existingWishListItem.isWishFullfilled);

      /// Making sure all the corresponding wishItems are updated with the new wish title
      List<WishItem> updatedWishItems = [];

      List<WishItem> wishItemsOfTheList =
          await dbManager.getAllWishItemsFromAWishList(key);
      wishItemsOfTheList.forEach((element) {
        updatedWishItems.add(element.edit(listTitle: wishListItem.listTitle));
      });
      await dbManager.replaceAllItemsOfAWishList(updatedWishItems, key);
    }
    return dbManager.addOrUpdateAWishListItem(updateWishListItem, key);
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
    await dbManager.addOrUpdateAWishListItem(updatedItem, null);
    return dbManager.deleteAWish(wishItem.itemName);
  }

  @override
  Future<void> changeIsWishFullFillState(WishItem wishItem) {
    final _wishItem =
        wishItem.edit(isWishFullfilled: !wishItem.isWishFullfilled);
    return dbManager.addOrUpdateAWish(_wishItem, null);
  }

  @override
  void changeCurrency(String currency) {
    preferenceManager.storePreferredCurrency(currency);
  }
}
