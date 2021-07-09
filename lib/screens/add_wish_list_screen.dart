import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:will_buy_it/config/constants.dart';
import 'package:will_buy_it/config/palette.dart';
import 'package:will_buy_it/config/screen_args_models.dart';
import 'package:will_buy_it/config/strings.dart';
import 'package:will_buy_it/data/models/wish_list_item.dart';
import 'package:will_buy_it/providers/provider_manager.dart';
import 'package:will_buy_it/screens/add_wish_item_screen.dart';
import 'package:will_buy_it/screens/wish_items_screen.dart';
import 'package:will_buy_it/widgets/widgets.dart';

class AddWishListScreen extends StatefulWidget {
  static const routeName = Constants.routeAddWishList;

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
    final args =
        ModalRoute.of(context)?.settings.arguments as AddWishListScreenArgs;
    String? listTitle = args.listTitle;
    String? listDescription = args.listDescription;
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
                              initialValue: listTitle,
                              hint: Strings.hintListTitle,
                              prefixIcon: Icons.group_work,
                              onSaved: (value) {
                                _listTitle = value;
                              }),
                          CustomTextField(
                              initialValue: listDescription,
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
                  ]),
                )),
          ),
          Positioned(
              bottom: 60.0,
              child: ButtonWidget(
                  listTitle == null
                      ? Strings.btnTextStartAWishList
                      : Strings.btnTextUpdateTheWishListInfo, () {
                final isValid = _formKey.currentState?.validate();
                if (isValid ?? false) {
                  try {
                    _formKey.currentState?.save();
                    final _wishListItem = WishListItem(
                        listTitle: _listTitle,
                        listDescription: _listDescription);
                    ProviderManager.addAWishListItem(
                        context, _wishListItem, listTitle);
                    if (listTitle == null) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        AddWishItemScreen.routeName,
                        (Route route) =>
                            route.settings.name == Constants.routeHome,
                        arguments: AddWishItemScreenArgs(listTitle: _listTitle),
                      );
                    } else {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          WishItemsScreen.routeName,
                          (route) => route.settings.name == Constants.routeHome,
                          arguments: WishItemsScreenArgs(
                              _listTitle, _listDescription));
                      ProviderManager.getAllWishItemsOfTheList(
                          context, _listTitle);
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(getSnackBar(true, Strings.errorUnknown));
                  }
                }
              })),
        ]));
  }
}
