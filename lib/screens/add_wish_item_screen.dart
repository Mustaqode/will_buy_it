import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:will_buy_it/config/palette.dart';
import 'package:will_buy_it/config/strings.dart';
import 'package:will_buy_it/data/models/wish_item.dart';
import 'package:will_buy_it/providers/provider_manager.dart';
import 'package:will_buy_it/screens/home_screen.dart';
import 'package:will_buy_it/widgets/widgets.dart';

class AddWishItemScreen extends StatefulWidget {
  final String listTitle;

  AddWishItemScreen(this.listTitle);

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
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Palette.colorPrimary,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => HomeScreen()),
                  (route) => false);
            },
          ),
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
                            widget.listTitle,
                            style: TextStyle(
                                color: Palette.colorPrimary, fontSize: 26.0),
                          ),
                          SizedBox(
                            height: 28.0,
                          ),
                          CustomTextField(
                              hint: Strings.hintProductName,
                              prefixIcon: Icons.add_shopping_cart,
                              onSaved: (value) {
                                _itemName = value;
                              }),
                          CustomTextField(
                              hint: Strings.hintItemDescription,
                              prefixIcon: Icons.short_text,
                              onSaved: (value) {
                                _description = value;
                              }),
                          CustomTextField(
                            hint: Strings.hintCost,
                            prefixIcon: Icons.attach_money,
                            onSaved: (value) {
                              _cost = double.parse(value);
                            },
                            isAmountField: true,
                          ),
                          CustomTextField(
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
              child: ButtonWidget(Strings.btnTextAddTheProduct, () {
                final isValid = _formKey.currentState?.validate();
                if (isValid ?? false) {
                  try {
                    _formKey.currentState?.save();
                    final _wishItem = WishItem(
                        listTitle: widget.listTitle,
                        itemName: _itemName,
                        itemDescription: _description,
                        itemCost: _cost,
                        itemUrl: _url);

                    ProviderManager.addAWishItem(context, _wishItem);

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
}
