import 'package:shared_preferences/shared_preferences.dart';
import 'package:will_buy_it/config/constants.dart';

abstract class PreferenceManager {
  Future<String> getCurrentCurrency();

  void storePreferredCurrency(String currency);
}

class PreferenceManagerImpl extends PreferenceManager {
  Future<SharedPreferences>? preferences;

  PreferenceManagerImpl(this.preferences);

  @override
  Future<String> getCurrentCurrency() async {
    var prefs = await preferences;
    return prefs?.getString(Constants.key_currency) ?? Constants.rupee;
  }

  @override
  void storePreferredCurrency(String currency) async {
    var prefs = await preferences;
    prefs?.setString(Constants.key_currency, currency);
  }
}
