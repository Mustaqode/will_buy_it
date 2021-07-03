import 'package:hive/hive.dart';
import 'package:will_buy_it/config/constants.dart';

part 'wish_item.g.dart';

@HiveType(typeId: 1)
class WishItem extends HiveObject {
  @HiveField(0)
  final String listTitle;
  @HiveField(1)
  final String itemName;
  @HiveField(2)
  final String itemDescription;
  @HiveField(3)
  final double itemCost;
  @HiveField(4)
  final String? itemUrl;
  @HiveField(5)
  final bool isWishFullfilled;
  @HiveField(6)
  final String currency;

  WishItem(
      {required this.listTitle,
      required this.itemName,
      required this.itemDescription,
      required this.itemCost,
      this.itemUrl = '',
      this.isWishFullfilled = false,
      this.currency = Constants.rupee});

  WishItem edit(
      {String? listTitle,
      String? itemName,
      String? itemDescription,
      double? itemCost,
      String? itemUrl,
      bool? isWishFullfilled,
      String? currency}) {
    return WishItem(
        listTitle: listTitle ?? this.listTitle,
        itemName: itemName ?? this.itemName,
        itemDescription: itemDescription ?? this.itemDescription,
        itemCost: itemCost ?? this.itemCost,
        itemUrl: itemUrl ?? this.itemUrl,
        isWishFullfilled: isWishFullfilled ?? this.isWishFullfilled,
        currency: currency ?? this.currency);
  }
}
