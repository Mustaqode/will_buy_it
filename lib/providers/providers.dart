import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:will_buy_it/db/db_manager.dart';
import 'package:will_buy_it/db/pref_manager.dart';
import 'package:will_buy_it/notifiers/total_cost_notifier.dart';
import 'package:will_buy_it/notifiers/wish_list_items_notifier.dart';
import 'package:will_buy_it/repository/wish_repo.dart';

final dbManagerProvider = Provider<DbManager>((ref) => DbManagerImpl());

final sharedPreferenceProvider = FutureProvider<SharedPreferences>((_) async {
  final preferences = await SharedPreferences.getInstance();
  return preferences;
});

final preferenceManagerProvider = Provider<PreferenceManager>((ref) {
  var sharedPref = ref.watch(sharedPreferenceProvider).data?.value;
  return PreferenceManagerImpl(sharedPref);
});

final wishListRepositoryProvider = Provider<WishRepository>((ref) =>
    WishRepositoryImpl(
        ref.read(dbManagerProvider), ref.read(preferenceManagerProvider)));

final wishListItemsNotifierProvider = StateNotifierProvider(
    (ref) => WishListItemNotifier(ref.watch(wishListRepositoryProvider)));

final totalCostNotifierProvider = StateNotifierProvider(
    (ref) => TotalCostNotifier(ref.watch(wishListRepositoryProvider)));
