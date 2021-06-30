import 'package:hive/hive.dart';
import 'package:will_buy_it/config/constants.dart';

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
  @HiveField(5)
  final String currency;

  WishListItem(
      {required this.listTitle,
      required this.listDescription,
      this.totalListItemCost = 0.0,
      this.progress = 0,
      this.isWishFullfilled = false,
      this.currency = Constants.dollar});

  WishListItem edit(
      {String? listTitle,
      String? listDescription,
      double? totalListItemCost,
      double? progress,
      bool? isWishFullfilled,
      String? currency}) {
    return WishListItem(
        listTitle: listTitle ?? this.listTitle,
        listDescription: listDescription ?? this.listDescription,
        totalListItemCost: totalListItemCost ?? this.totalListItemCost,
        progress: progress ?? this.progress,
        isWishFullfilled: isWishFullfilled ?? this.isWishFullfilled,
        currency: currency ?? this.currency);
  }
}
