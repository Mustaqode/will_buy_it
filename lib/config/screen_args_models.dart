import 'package:will_buy_it/data/models/wish_item.dart';

class WishItemsScreenArgs {
  final String listTitle;
  final String listDescription;

  WishItemsScreenArgs(this.listTitle, this.listDescription);
}

class AddWishItemScreenArgs {
  final String listTitle;
  final WishItem? wishItem;

  AddWishItemScreenArgs({required this.listTitle, this.wishItem});
}

class AddWishListScreenArgs {
  final String? listTitle;
  final String? listDescription;

  AddWishListScreenArgs(this.listTitle, this.listDescription);
}
