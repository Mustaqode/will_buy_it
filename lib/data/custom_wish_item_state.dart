import 'package:will_buy_it/data/models/wish_item.dart';

abstract class WishItemState {
  const WishItemState();
}

class Loading extends WishItemState {
  const Loading();
}

class Success extends WishItemState {
  final List<WishItem> wishItems;
  const Success(this.wishItems);
}

class Error extends WishItemState {
  final String reason;
  const Error(this.reason);
}
