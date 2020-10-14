import 'package:flutter/material.dart';
import 'package:jariapp/models/cart.item.dart';
import 'package:jariapp/services/products.dart';
import 'package:jariapp/themes/theme.dart';
import 'package:jariapp/utils/jari_icons_v2.dart';
import 'package:jariapp/themes/colors.dart';
import 'package:jariapp/widgets/custom.appbar.dart';
import 'package:jariapp/widgets/title.text.dart';
import 'package:provider/provider.dart';

class CartItemsPage extends StatelessWidget {
  //....
  CartItemsPage({Key key}) : super(key: key);
  //....
  List<CartItem> _cartlist = [];
  //+++++++++++++++++++++++++++++++++++++++++
  Widget _cartItems() {
    return Column(
      children: _cartlist.map((item) => _item(item)).toList(),
    );
  }

  Widget _item(CartItem item) {
    return Container(
      height: 80,
      child: Row(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1.2,
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    height: 70,
                    width: 70,
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                /*
                Positioned(
                  left: -20,
                  bottom: -20,
                  child: Image.asset(model.image),
                )*/
              ],
            ),
          ),
          Expanded(
              child: ListTile(
                  title: TitleText(
                    text: item.productName,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                  subtitle: Row(
                    children: <Widget>[
                      TitleText(
                        text: '\$ ',
                        color: AppColors.darkblue3,
                        fontSize: 12,
                      ),
                      TitleText(
                        text: item.priceTotal.toString(),
                        fontSize: 14,
                      ),
                    ],
                  ),
                  trailing: Container(
                    width: 35,
                    height: 35,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: AppColors.lightGrey.withAlpha(150),
                        borderRadius: BorderRadius.circular(10)),
                    child: TitleText(
                      text: 'x${item.qty}',
                      fontSize: 12,
                    ),
                  )))
        ],
      ),
    );
  }

  //++++++++++++++++++++++++++++++++++++++++

  @override
  Widget build(BuildContext context) {
    final _productsProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    _cartlist = [..._productsProvider.getCartItems];

    //++++
    // final w = MediaQuery.of(context).size.width;
    // final h = MediaQuery.of(context).size.height;

    return Scaffold(
      // backgroundColor: Colors.grey[100],

      // backgroundColor: AppColors.canvaColor,

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
          padding: AppTheme.padding,
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
        width: AppTheme.fullWidth(context) * .7,
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
