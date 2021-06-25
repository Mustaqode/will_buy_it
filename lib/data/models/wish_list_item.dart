import 'package:hive/hive.dart';

part 'wish_list_item.g.dart';

@HiveType(typeId: 0)
class WishListItem extends HiveObject {
  @HiveField(0)
  final String listTitle;
  @HiveField(1)
  final String listDescription;
  @HiveField(2)
  final double totalListItemCost;
  @HiveField(3)
  final double progress;
  @HiveField(4)
  final bool isWishFullfilled;

  WishListItem({
    required this.listTitle,
    required this.listDescription,
    this.totalListItemCost = 0.0,
    this.progress = 0,
    this.isWishFullfilled = false,
  });
}
