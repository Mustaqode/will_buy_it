import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:metadata_fetch/metadata_fetch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:will_buy_it/config/constants.dart';
import 'package:will_buy_it/config/palette.dart';
import 'package:will_buy_it/config/screen_args_models.dart';
import 'package:will_buy_it/config/strings.dart';
import 'package:will_buy_it/data/models/wish_item.dart';
import 'package:will_buy_it/providers/provider_manager.dart';
import 'package:will_buy_it/widgets/widgets.dart';

class AddWishItemScreen extends StatefulWidget {
  static const routeName = Constants.routeAddWishItem;

  @override
  _AddWishItemScreenState createState() => _AddWishItemScreenState();
}

class _AddWishItemScreenState extends State<AddWishItemScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var _itemName = "";

  var _description = "";

  var _cost = 0.0;

  var _url = "";

  @override
  Widget build(BuildContext context) {
    var args =
        ModalRoute.of(context)?.settings.arguments as AddWishItemScreenArgs;
    final String listTitle = args.listTitle;
    final WishItem? wishItem = args.wishItem;
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
                            listTitle,
                            style: TextStyle(
                                color: Palette.colorPrimary, fontSize: 26.0),
                          ),
                          SizedBox(
                            height: 28.0,
                          ),
                          CustomTextField(
                              initialValue:
                                  wishItem != null ? wishItem.itemName : null,
                              hint: Strings.hintProductName,
                              prefixIcon: Icons.add_shopping_cart,
                              onSaved: (value) {
                                _itemName = value;
                              }),
                          CustomTextField(
                              initialValue: wishItem != null
                                  ? wishItem.itemDescription
                                  : null,
                              hint: Strings.hintItemDescription,
                              prefixIcon: Icons.short_text,
                              onSaved: (value) {
                                _description = value;
                              }),
                          CustomTextField(
                            initialValue:
                                wishItem != null ? wishItem.itemCost : null,
                            hint: Strings.hintCost,
                            prefixIcon: Icons.attach_money,
                            onSaved: (value) {
                              _cost = double.parse(value);
                            },
                            isAmountField: true,
                          ),
                          CustomTextField(
                            initialValue:
                                wishItem != null ? wishItem.itemUrl : null,
                            hint: Strings.hintAddAProductLink,
                            prefixIcon: Icons.link,
                            onSaved: (value) {
                              _url = value;
                            },
                            isUrlField: true,
                          ),
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
                        child: wishItem?.itemUrl?.isNotEmpty ?? false
                            ? FutureBuilder(
                                future: buildImage(wishItem!.itemUrl!),
                                builder: (BuildContext context,
                                    AsyncSnapshot<Image> snapshot) {
                                  switch (snapshot.connectionState) {
                                    case ConnectionState.none:
                                      return Icon(Icons.image);
                                    default:
                                      if (snapshot.hasData) {
                                        return snapshot.data!;
                                      } else
                                        return Icon(Icons.image);
                                  }
                                },
                              )
                            : Text(""), // Displaying none
                      ),
                    ),
                  ]),
                )),
          ),
          Positioned(
              bottom: 60.0,
              child: ButtonWidget(
                  wishItem != null
                      ? Strings.btnTextUpdateProduct
                      : Strings.btnTextAddTheProduct, () {
                final isValid = _formKey.currentState?.validate();
                if (isValid ?? false) {
                  try {
                    _formKey.currentState?.save();
                    final _wishItem = WishItem(
                        listTitle: listTitle,
                        itemName: _itemName,
                        itemDescription: _description,
                        itemCost: _cost,
                        itemUrl: _url);
                    var _keyForUpdateOperation =
                        wishItem != null ? wishItem.itemName : null;
                    ProviderManager.addAWishItem(
                        context: context,
                        wishItem: _wishItem,
                        key: _keyForUpdateOperation);

                    Future.delayed(Duration.zero, () {
                      ProviderManager.getAllWishListItems(context);
                      ProviderManager.getTotalCostOfAllWishLists(context, null);
                    });

                    Navigator.of(context).pop();
                  } catch (e) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(getSnackBar(true, Strings.errorUnknown));
                  }
                }
              })),
        ]));
  }

  Future<Image> buildImage(String url) async {
    final imageData =
        await MetadataFetch.extract(url); // Doesn't work for amazon
    final imageUrl = imageData?.image;
    return Image.network(
      imageUrl!,
      width: double.infinity,
      height: 200.0,
      fit: BoxFit.cover,
    );
  }
}
