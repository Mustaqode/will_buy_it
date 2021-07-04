import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:will_buy_it/config/constants.dart';
import 'package:will_buy_it/config/palette.dart';
import 'package:will_buy_it/data/models/wish_item.dart';
import 'package:will_buy_it/data/models/wish_list_item.dart';
import 'package:will_buy_it/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(WishListItemAdapter());
  Hive.registerAdapter(WishItemAdapter());

  await Hive.openBox<WishListItem>(Constants.wishListBox);
  await Hive.openBox<WishItem>(Constants.wishItemBox);
  runApp(WillBuyIt());
}

class WillBuyIt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Will Buy It',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            appBarTheme:
                const AppBarTheme(backgroundColor: Palette.colorPrimary),
            scaffoldBackgroundColor: Palette.colorPrimary,
            primaryColor: Palette.colorPrimary,
            iconTheme: const IconThemeData(color: Colors.white),
            fontFamily: GoogleFonts.portLligatSans().fontFamily,
            textTheme: GoogleFonts.portLligatSansTextTheme()),
        home: HomeScreen(),
      ),
    );
  }
}
