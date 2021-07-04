import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:will_buy_it/config/palette.dart';
import 'package:will_buy_it/config/strings.dart';
import 'package:will_buy_it/data/models/wish_list_item.dart';
import 'package:will_buy_it/providers/providers.dart';
import 'package:will_buy_it/screens/add_wish_item_screen.dart';
import 'package:will_buy_it/widgets/widgets.dart';

class AddWishListScreen extends StatefulWidget {
  @override
  _AddWishListScreenState createState() => _AddWishListScreenState();
}

class _AddWishListScreenState extends State<AddWishListScreen> {
  late final WishListItem wishListItem;

  var _listTitle = "";
  var _listDescription = "";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Palette.colorPrimary,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text(
            Strings.appTitle,
            style: TextStyle(
                fontFamily: GoogleFonts.playball().fontFamily, fontSize: 22.0),
          ),
        ),
        body: Stack(alignment: Alignment.center, children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Palette.colorSecondary,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0))),
            child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 30.0, horizontal: 40.0),
                      child: Column(
                        children: [
                          Text(
                            Strings.titleNewWishList,
                            style: TextStyle(
                                color: Palette.colorPrimary, fontSize: 26.0),
                          ),
                          SizedBox(
                            height: 28.0,
                          ),
                          CustomTextField(
                              hint: Strings.hintListTitle,
                              prefixIcon: Icons.group_work,
                              onSaved: (value) {
                                _listTitle = value;
                              }),
                          CustomTextField(
                              hint: Strings.hintListDescription,
                              prefixIcon: Icons.add_shopping_cart,
                              onSaved: (value) {
                                _listDescription = value;
                              }),
                          SizedBox(
                            height: 40.0,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 40.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0),
                        ),
                        child: Image.network(
                          'https://picsum.photos/200/300',
                          width: double.infinity,
                          height: 200.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ]),
                )),
          ),
          Positioned(
              bottom: 60.0,
              child: ButtonWidget(Strings.btnTextStartAWishList, () {
                final isValid = _formKey.currentState?.validate();
                if (isValid ?? false) {
                  try {
                    _formKey.currentState?.save();
                    final _wishListItem = WishListItem(
                        listTitle: _listTitle,
                        listDescription: _listDescription);
                    context
                        .read(wishListItemsNotifierProvider.notifier)
                        .addAWishListItem(_wishListItem);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => AddWishItemScreen(_listTitle)));
                  } catch (e) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(getSnackBar(true, Strings.errorUnknown));
                  }
                }
              })),
        ]));
  }
}
