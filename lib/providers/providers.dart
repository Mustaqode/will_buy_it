import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:will_buy_it/db/db_manager.dart';
import 'package:will_buy_it/notifiers/wish_list_items_notofier.dart';
import 'package:will_buy_it/repository/wish_list_repo.dart';

final dbManagerProvider = Provider<DbManager>((ref) => DbManagerImpl());

final wishListRepositoryProvider = Provider<WishListRepository>(
    (ref) => WishListRepositoryImpl(ref.watch(dbManagerProvider)));

final wishListItemsNotifierProvider = StateNotifierProvider(
    (ref) => WishListItemNotifier(ref.watch(wishListRepositoryProvider)));
