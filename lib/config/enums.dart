import 'package:will_buy_it/config/constants.dart';

enum Currency { dollar, rupee }

extension CurrencyExtension on Currency {
  String get getCurrencyString {
    switch (this) {
      case Currency.dollar:
        return Constants.dollar;
      case Currency.rupee:
        return Constants.rupee;
      default:
        return Constants.dollar;
    }
  }
}

  Currency getCurrency(String currencyString) {
    switch (currencyString) {
      case Constants.dollar:
        return Currency.dollar;
      case Constants.rupee:
        return Currency.rupee;
      default:
        return Currency.dollar;
    }
  }

