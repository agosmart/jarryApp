import 'package:flutter/material.dart';
import 'package:jarryApp/models/cart.item.dart';
import 'package:jarryApp/providers/products.dart';

import 'package:jarryApp/utils/jari_icons_v2.dart';
import 'package:jarryApp/themes/colors.dart';
import 'package:jarryApp/widgets/custom.appbar.dart';
import 'package:jarryApp/widgets/title.text.dart';
import 'package:provider/provider.dart';

class CartItemsPage extends StatelessWidget {
  //....
  //CartItemsPage({Key key}) : super(key: key);
  //....
  List<CartItem> _cartlist = [];
  double h, w;
  //+++++++++++++++++++++++++++++++++++++++++
  Widget _cartItems() {
    return Column(
      children: _cartlist.map((item) => _item(item)).toList(),
    );
  }

  Widget _item(CartItem item) {
    return Column(
      children: [
        Container(
          height: 80,
          child: Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(4.0),
                height: 56,
                width: 56,
                child: Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5.0,
                              spreadRadius: 2.0,
                              color: AppColors.darkgray.withOpacity(0.3),
                            )
                          ]),
                      child: Center(
                        child: Icon(
                          JariIcons.danone_any,
                          color: AppColors.darkgrey,
                          size: 40.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                //++++
                child: ListTile(
                  title: TitleText(
                    text: item.productName,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                  subtitle: Row(
                    children: <Widget>[
                      TitleText(
                        text: item.priceTotal.toString(),
                        fontSize: 16,
                        color: AppColors.darkgrey,
                      ),
                      TitleText(
                        text: ' DA ',
                        color: AppColors.orange,
                        fontSize: 12,
                      ),
                    ],
                  ),
                  trailing: Container(
                    width: 35,
                    height: 35,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: AppColors.orange,
                        borderRadius: BorderRadius.circular(10)),
                    child: TitleText(
                      text: 'x${item.qty}',
                      fontSize: 12,
                      color: AppColors.white,
                    ),
                  ),
                ),
                //+++
              )
            ],
          ),
        ),
      ],
    );
  }

  //++++++++++++++++++++++++++++++++++++++++

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;

    final _productsProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    _cartlist = [..._productsProvider.getCartItems];

    //++++
    // final w = MediaQuery.of(context).size.width;
    // final h = MediaQuery.of(context).size.height;

    return Scaffold(
      // backgroundColor: Colors.grey[100],

      backgroundColor: AppColors.canvaColor,

      //+++++

      appBar: AppBar(
        brightness: Brightness.light,

        // leading: null,
        iconTheme: IconThemeData(color: AppColors.icongray),
        backgroundColor: CustomAppBar.backgroundColor,
        automaticallyImplyLeading: true,
        centerTitle: CustomAppBar.centerTitle,

        elevation: CustomAppBar.elevation,
        toolbarHeight: CustomAppBar.toolbarHeight,
        title: CustomAppBar.logoHeader(),
        actions: <Widget>[CustomAppBar.builsActionIcons()],
        // toolbarHeight: 80.0,
      ),

      //-----------------
      body: SafeArea(
        //++++++++++++++++++++++++++++
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _cartItems(),
                Divider(
                  thickness: 1,
                  height: 70,
                ),
                _price(),
                SizedBox(height: 30),
                _submitButton(context),
              ],
            ),
          ),
        ),
        //++++++++++++++++++++++++++++
      ),

      //++++++++++++++++++++++++++++

      // padding: const EdgeInsets
    );
  }

//++++++++++++++++++++++++++++++++++++++++
  Widget _price() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TitleText(
          text: '${_cartlist.length} Items',
          color: AppColors.grey,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        TitleText(
          text: '${getPrice()} DA',
          // text: 'LE PRIX',
          fontSize: 18,
        ),
      ],
    );
  }

  //..........................
  double getPrice() {
    double price = 0;
    _cartlist.forEach((x) {
      price += x.priceTotal * x.qty;
    });
    return price;
  }

//++++++++++++++++++++++++++++++++++++++++
  Widget _submitButton(BuildContext context) {
    return FlatButton(
      //***************************
      onPressed: () {},
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: AppColors.orange,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 12),
        width: w,
        child: TitleText(
          text: 'commander',
          color: AppColors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  //++++++++++++++++++++++++++
}
