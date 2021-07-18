import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:will_buy_it/db/db_manager.dart';
import 'package:will_buy_it/db/pref_manager.dart';
import 'package:will_buy_it/notifiers/total_cost_notifier.dart';
import 'package:will_buy_it/notifiers/total_cost_notifier_wish_item.dart';
import 'package:will_buy_it/notifiers/wish_item_notifier.dart';
import 'package:will_buy_it/notifiers/wish_list_items_notifier.dart';
import 'package:will_buy_it/repository/wish_repo.dart';

final dbManagerProvider = Provider<DbManager>((ref) => DbManagerImpl());

final sharedPreferenceProvider = FutureProvider<SharedPreferences>((ref) async {
  return await SharedPreferences.getInstance();
});

final preferenceManagerProvider = Provider<PreferenceManager>((ref) {
  final sharedPref = ref.watch(sharedPreferenceProvider.future);
  return PreferenceManagerImpl(sharedPref);
});

final wishListRepositoryProvider = Provider<WishRepository>((ref) {
  final dbManager = ref.watch(dbManagerProvider);
  final preferenceManager = ref.watch(preferenceManagerProvider);
  return WishRepositoryImpl(dbManager, preferenceManager);
});

final wishListItemsNotifierProvider = StateNotifierProvider(
    (ref) => WishListItemNotifier(ref.watch(wishListRepositoryProvider)));

final wishItemsNotifierProvider = StateNotifierProvider(
    (ref) => WishItemsNotifier(ref.watch(wishListRepositoryProvider)));

final totalCostNotifierProvider = StateNotifierProvider(
    (ref) => TotalCostNotifier(ref.watch(wishListRepositoryProvider)));

final totalCostWishItemsNotifierProvider = StateNotifierProvider(
    (ref) => TotalCostNotifierWishItem(ref.watch(wishListRepositoryProvider)));
