import 'dart:ffi';

class WishListItem {
  final String listTitle;
  final String listDescription;
  final double totalListItemCost;
  final double progress;
  final List<WishItem>? wishItems;

  const WishListItem(
    this.listTitle,
    this.listDescription,
    this.totalListItemCost,
    this.progress,
    this.wishItems,
  );
}

class WishItem {
  final String listTitle;
  final String itemName;
  final String itemDescription;
  final Float itemCost;
  final String? itemUrl;
  final bool isWishFullfilled;

  const WishItem(
      {required this.listTitle,
      required this.itemName,
      required this.itemDescription,
      required this.itemCost,
      this.itemUrl = '',
      this.isWishFullfilled = false});
}

const List<WishListItem> wishListItems = [
  WishListItem('My Home Office Setup', 'Build a home office for productivity',
      15000.0, 0.2, null),
  WishListItem('OTT subscription', 'Buy Netflix, Hotstar, and Amazon subs...',
      2000.0, 0.8, null),
  WishListItem('Ruin my friend\'s engagement',
      'Make arrangements to break my friends\' engangement', 1000.0, 0.5, null),
  WishListItem('Trekking Tools', 'Buy tools needed for a trekking trip', 2000.0,
      0.9, null),
];
