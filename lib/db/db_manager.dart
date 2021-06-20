import 'package:will_buy_it/data/models.dart';

abstract class DbManager {
  Future<List<WishListItem>> getAllWishListItems();
}

class DbManagerImpl extends DbManager {
  @override
  Future<List<WishListItem>> getAllWishListItems() {
    return Future.delayed(Duration(seconds: 3), () {
      return wishListItems;
    });
  }
}
