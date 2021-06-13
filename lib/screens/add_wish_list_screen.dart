import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:will_buy_it/config/palette.dart';
import 'package:will_buy_it/config/strings.dart';
import 'package:will_buy_it/model/models.dart';
import 'package:will_buy_it/widgets/widgets.dart';

class AddWishListScreen extends StatelessWidget {
  late final WishListItem wishListItem;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                borderRadius: BorderRadius.circular(40.0)),
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
                              onSaved: (value) {}),
                          CustomTextField(
                              hint: Strings.hintProductName,
                              prefixIcon: Icons.add_shopping_cart,
                              onSaved: (value) {}),
                          CustomTextField(
                              hint: Strings.hintItemDescription,
                              prefixIcon: Icons.short_text,
                              onSaved: (value) {}),
                          CustomTextField(
                            hint: Strings.hintCost,
                            prefixIcon: Icons.attach_money,
                            onSaved: (value) {},
                            isAmountField: true,
                          ),
                          CustomTextField(
                            hint: Strings.hintAddAProductLink,
                            prefixIcon: Icons.link,
                            onSaved: (value) {},
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
              child: ButtonWidget(Strings.btnTextStartAWishList, () {})),
        ]));
  }
}
