import 'package:will_buy_it/data/models/wish_list_item.dart';

abstract class WishListState {
  const WishListState();
}

class Loading extends WishListState {
  const Loading();
}

class Success extends WishListState {
  final List<WishListItem> wishListItems;
  const Success(this.wishListItems);
}

class Error extends WishListState {
  final String reason;
  const Error(this.reason);
}
