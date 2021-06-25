import 'package:shared_preferences/shared_preferences.dart';
import 'package:will_buy_it/config/constants.dart';
import 'package:will_buy_it/config/enums.dart';

abstract class PreferenceManager {
  Currency getCurrentCurrency();

  Future<bool>? storePreferredCurrency(Currency currency);
}

class PreferenceManagerImpl extends PreferenceManager {
  SharedPreferences? preferences;

  PreferenceManagerImpl(this.preferences);

  @override
  Currency getCurrentCurrency() {
    var currency = preferences?.getString(Constants.key_currency) ?? "";
    return currency.isEmpty ? Currency.dollar : getCurrency(currency);
  }

  @override
  Future<bool>? storePreferredCurrency(Currency currency) {
    return preferences?.setString(
        Constants.key_currency, currency.getCurrencyString);
  }
}
