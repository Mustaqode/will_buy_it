import 'package:will_buy_it/config/enums.dart';
import 'package:will_buy_it/data/models/wish_item.dart';
import 'package:will_buy_it/data/models/wish_list_item.dart';
import 'package:will_buy_it/db/db_manager.dart';
import 'package:will_buy_it/db/pref_manager.dart';
import 'package:will_buy_it/helper/pair.dart';

abstract class WishRepository {
  Future<List<WishListItem>> getAllWishListItem();

  Future<List<WishItem>> getAllWishItemOfTheList(String key);

  Pair<Currency, String> getAllWishesCost(List<WishListItem> wishList);

  Pair<Currency, String> getCostOfAllItemsOfAWishList(List<WishItem> wishList);

  Pair<Currency, String> changeCurrencyFromWishScreen(List<WishItem> wishItem);

  Pair<Currency, String> changeCurrencyFromHomeScreen(
      List<WishListItem> wishListItem);
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
  Pair<Currency, String> getAllWishesCost(List<WishListItem> wishList) {
    Currency currency = preferenceManager.getCurrentCurrency();
    var isDollar = currency == Currency.dollar;
    var totalCost = 0.0;
    wishList.forEach((element) {
      totalCost = totalCost + element.totalListItemCost;
    });
    if (isDollar)
      return Pair(Currency.dollar, "$totalCost \$");
    else
      return Pair(Currency.rupee, "$totalCost ₹");
  }

  @override
  Pair<Currency, String> getCostOfAllItemsOfAWishList(
      List<WishItem> wishItemList) {
    Currency currency = preferenceManager.getCurrentCurrency();
    var isDollar = currency == Currency.dollar;
    var totalCost = 0.0;
    wishItemList.forEach((element) {
      totalCost = totalCost + element.itemCost;
    });
    if (isDollar)
      return Pair(Currency.dollar, "$totalCost \$");
    else
      return Pair(Currency.rupee, "$totalCost ₹");
  }

  @override
  Pair<Currency, String> changeCurrencyFromWishScreen(
      List<WishItem> wishListItem) {
    var isDollar = preferenceManager.getCurrentCurrency() == Currency.dollar;
    if (isDollar)
      preferenceManager.storePreferredCurrency(Currency.rupee);
    else
      preferenceManager.storePreferredCurrency(Currency.dollar);
    return getCostOfAllItemsOfAWishList(wishListItem);
  }

  @override
  Pair<Currency, String> changeCurrencyFromHomeScreen(
      List<WishListItem> wishListItem) {
    var isDollar = preferenceManager.getCurrentCurrency() == Currency.dollar;
    if (isDollar)
      preferenceManager.storePreferredCurrency(Currency.rupee);
    else
      preferenceManager.storePreferredCurrency(Currency.dollar);
    return getAllWishesCost(wishListItem);
  }
}
