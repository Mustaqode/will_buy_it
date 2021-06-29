import 'package:will_buy_it/config/enums.dart';
import 'package:will_buy_it/data/models/wish_item.dart';
import 'package:will_buy_it/data/models/wish_list_item.dart';
import 'package:will_buy_it/db/db_manager.dart';
import 'package:will_buy_it/db/pref_manager.dart';
import 'package:will_buy_it/helper/pair.dart';

abstract class WishRepository {
  Future<List<WishListItem>> getAllWishListItem();

  Future<void> deleteAllWishLists();

  Future<List<WishItem>> getAllWishItemOfTheList(String key);

  String getAllWishesCost(List<WishListItem> wishList);

  Pair<Currency, String> getCostOfAllItemsOfAWishList(List<WishItem> wishList);
}

class WishRepositoryImpl extends WishRepository {
  DbManager dbManager;
  PreferenceManager preferenceManager;

  WishRepositoryImpl(this.dbManager, this.preferenceManager);

  @override
  Future<List<WishListItem>> getAllWishListItem() {
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
    return "$totalCost $currency";
  }

  @override
  Pair<Currency, String> getCostOfAllItemsOfAWishList(
      List<WishItem> wishItemList) {
    String currency = preferenceManager.getCurrentCurrency();
    var isDollar = currency;
    var totalCost = 0.0;
    wishItemList.forEach((element) {
      totalCost = totalCost + element.itemCost;
    });

    return Pair(Currency.dollar, "$totalCost $currency");
  }

  @override
  Future<void> deleteAllWishLists() {
    return dbManager.deleteAllWishListItems();
  }
}
