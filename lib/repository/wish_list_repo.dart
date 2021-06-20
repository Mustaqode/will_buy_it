import 'package:will_buy_it/data/models.dart';
import 'package:will_buy_it/db/db_manager.dart';

abstract class WishListRepository {
  Future<List<WishListItem>> getAllWishList();
}

class WishListRepositoryImpl extends WishListRepository {
  DbManager dbManager;

  WishListRepositoryImpl(this.dbManager);

  @override
  Future<List<WishListItem>> getAllWishList() {
    return dbManager.getAllWishListItems();
  }
}
