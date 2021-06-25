import 'package:hive/hive.dart';

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

  WishItem(
      {required this.listTitle,
      required this.itemName,
      required this.itemDescription,
      required this.itemCost,
      this.itemUrl = '',
      this.isWishFullfilled = false});
}
