import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:will_buy_it/config/palette.dart';
import 'package:will_buy_it/screens/home_screen.dart';

void main() {
  runApp(WillBuyIt());
}

class WillBuyIt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Will Buy It',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: const AppBarTheme(backgroundColor: Palette.colorPrimary),
          scaffoldBackgroundColor: Palette.colorPrimary,
          primaryColor: Palette.colorPrimary,
          iconTheme: const IconThemeData(color: Colors.white),
          fontFamily: GoogleFonts.portLligatSans().fontFamily,
          textTheme: GoogleFonts.portLligatSansTextTheme()),
      home: HomeScreen(),
    );
  }
}
