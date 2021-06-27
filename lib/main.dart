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

  var box = Hive.box<WishListItem>(Constants.wishListBox);
  var box2 = Hive.box<WishItem>(Constants.wishItemBox);
  box.clear();
  List<WishListItem> wishListItems = [
    WishListItem(
        listTitle: 'My Home Office Setup 2',
        listDescription: 'Build a home office for productivity',
        totalListItemCost: 15000.0,
        progress: 0.2,
        isWishFullfilled: false),
    WishListItem(
        listTitle: 'My Home Office Setup which is quite expensive',
        listDescription: 'Build a home office for productivity',
        totalListItemCost: 15000.0,
        progress: 0.6,
        isWishFullfilled: false),
    WishListItem(
        listTitle: 'My Home Office Setup',
        listDescription: 'Build a home office for productivity',
        totalListItemCost: 15000.0,
        progress: 0.2,
        isWishFullfilled: true),
  ];
  List<WishItem> wishItems = [
    WishItem(
        listTitle: 'My Home Office Setup',
        itemName: 'Study Desk',
        itemDescription: 'Made of teak wood',
        itemCost: 12000,
        itemUrl:
            'https://www.flipkart.com/zebronics-sound-feast-50-14-w-bluetooth-speaker/p/itm454869849215f?pid=ACCFXCHH3TUPQYMP&lid=LSTACCFXCHH3TUPQYMPKFN8HD&marketplace=FLIPKART&store=0pm%2F0o7&srno=b_1_1&otracker=hp_omu_Deals%2Bof%2Bthe%2BDay_2_3.dealCard.OMU_W8C7MXYDCKQQ_3&otracker1=hp_omu_SECTIONED_manualRanking_neo%2Fmerchandising_Deals%2Bof%2Bthe%2BDay_NA_dealCard_cc_2_NA_view-all_3&fm=neo%2Fmerchandising&iid=59ba6951-b65e-4b08-a855-4a0db6a91ace.ACCFXCHH3TUPQYMP.SEARCH&ppt=browse&ppn=browse',
        isWishFullfilled: true),
    WishItem(
        listTitle: 'My Home Office Setup which is quite expensive',
        itemName: 'Study Desk',
        itemDescription: 'Made of teak wood',
        itemCost: 12000,
        itemUrl:
            'https://www.flipkart.com/zebronics-sound-feast-50-14-w-bluetooth-speaker/p/itm454869849215f?pid=ACCFXCHH3TUPQYMP&lid=LSTACCFXCHH3TUPQYMPKFN8HD&marketplace=FLIPKART&store=0pm%2F0o7&srno=b_1_1&otracker=hp_omu_Deals%2Bof%2Bthe%2BDay_2_3.dealCard.OMU_W8C7MXYDCKQQ_3&otracker1=hp_omu_SECTIONED_manualRanking_neo%2Fmerchandising_Deals%2Bof%2Bthe%2BDay_NA_dealCard_cc_2_NA_view-all_3&fm=neo%2Fmerchandising&iid=59ba6951-b65e-4b08-a855-4a0db6a91ace.ACCFXCHH3TUPQYMP.SEARCH&ppt=browse&ppn=browse',
        isWishFullfilled: true),
    WishItem(
        listTitle: 'My Home Office Setup 2',
        itemName: 'Study Desk',
        itemDescription: 'Made of teak wood',
        itemCost: 12000,
        itemUrl:
            'https://www.flipkart.com/zebronics-sound-feast-50-14-w-bluetooth-speaker/p/itm454869849215f?pid=ACCFXCHH3TUPQYMP&lid=LSTACCFXCHH3TUPQYMPKFN8HD&marketplace=FLIPKART&store=0pm%2F0o7&srno=b_1_1&otracker=hp_omu_Deals%2Bof%2Bthe%2BDay_2_3.dealCard.OMU_W8C7MXYDCKQQ_3&otracker1=hp_omu_SECTIONED_manualRanking_neo%2Fmerchandising_Deals%2Bof%2Bthe%2BDay_NA_dealCard_cc_2_NA_view-all_3&fm=neo%2Fmerchandising&iid=59ba6951-b65e-4b08-a855-4a0db6a91ace.ACCFXCHH3TUPQYMP.SEARCH&ppt=browse&ppn=browse',
        isWishFullfilled: false),
    WishItem(
        listTitle: 'My Home Office Setup which is quite expensive',
        itemName: 'Study Desk',
        itemDescription: 'Made of teak wood',
        itemCost: 12000,
        itemUrl:
            'https://www.flipkart.com/zebronics-sound-feast-50-14-w-bluetooth-speaker/p/itm454869849215f?pid=ACCFXCHH3TUPQYMP&lid=LSTACCFXCHH3TUPQYMPKFN8HD&marketplace=FLIPKART&store=0pm%2F0o7&srno=b_1_1&otracker=hp_omu_Deals%2Bof%2Bthe%2BDay_2_3.dealCard.OMU_W8C7MXYDCKQQ_3&otracker1=hp_omu_SECTIONED_manualRanking_neo%2Fmerchandising_Deals%2Bof%2Bthe%2BDay_NA_dealCard_cc_2_NA_view-all_3&fm=neo%2Fmerchandising&iid=59ba6951-b65e-4b08-a855-4a0db6a91ace.ACCFXCHH3TUPQYMP.SEARCH&ppt=browse&ppn=browse',
        isWishFullfilled: false),
    WishItem(
        listTitle: 'My Home Office Setup',
        itemName: 'Study Desk',
        itemDescription: 'Made of teak wood',
        itemCost: 12000,
        itemUrl:
            'https://www.flipkart.com/zebronics-sound-feast-50-14-w-bluetooth-speaker/p/itm454869849215f?pid=ACCFXCHH3TUPQYMP&lid=LSTACCFXCHH3TUPQYMPKFN8HD&marketplace=FLIPKART&store=0pm%2F0o7&srno=b_1_1&otracker=hp_omu_Deals%2Bof%2Bthe%2BDay_2_3.dealCard.OMU_W8C7MXYDCKQQ_3&otracker1=hp_omu_SECTIONED_manualRanking_neo%2Fmerchandising_Deals%2Bof%2Bthe%2BDay_NA_dealCard_cc_2_NA_view-all_3&fm=neo%2Fmerchandising&iid=59ba6951-b65e-4b08-a855-4a0db6a91ace.ACCFXCHH3TUPQYMP.SEARCH&ppt=browse&ppn=browse',
        isWishFullfilled: true),
  ];
  box2.addAll(wishItems);
  box.addAll(wishListItems);

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
