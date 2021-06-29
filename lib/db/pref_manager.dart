import 'package:shared_preferences/shared_preferences.dart';
import 'package:will_buy_it/config/constants.dart';
import 'package:will_buy_it/config/enums.dart';

abstract class PreferenceManager {
  String getCurrentCurrency();

  Future<bool>? storePreferredCurrency(String currency);
}

class PreferenceManagerImpl extends PreferenceManager {
  SharedPreferences? preferences;

  PreferenceManagerImpl(this.preferences);

  @override
  String getCurrentCurrency() {
    return preferences?.getString(Constants.key_currency) ?? Constants.dollar;
  }

  @override
  Future<bool>? storePreferredCurrency(String currency) {
    return preferences?.setString(Constants.key_currency, currency);
  }
}
