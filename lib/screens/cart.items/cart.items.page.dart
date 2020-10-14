import 'package:flutter/material.dart';
import 'package:jariapp/models/cart.item.dart';
import 'package:jariapp/services/products.dart';
import 'package:jariapp/utils/jari_icons_v2.dart';
import 'package:jariapp/themes/colors.dart';
import 'package:jariapp/widgets/animations/custom.fade.translate.animation.dart';
import 'package:jariapp/widgets/custom.appbar.dart';
import 'package:jariapp/widgets/title.text.dart';
import 'package:provider/provider.dart';

class CartItemsPage extends StatelessWidget {
  //....
  CartItemsPage({Key key}) : super(key: key);
  //....
  List<CartItem> _cartlist = [];
  double h, w;
  //+++++++++++++++++++++++++++++++++++++++++
  // Widget _cartItems() {
  //   return Column(
  //     children: _cartlist.map((item) => _item(item)).toList(),
  //   );
  // }

  Widget _item____(CartItem item) {
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
    //++++
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;

    final _productsProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    _cartlist = [..._productsProvider.getCartItems];

    //++++

    return Scaffold(
      // backgroundColor: Colors.grey[100],

      // backgroundColor: AppColors.canvaColor,

      //+++++ APP BAR ++++++++++++++++++++++++++++
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
        // actions: <Widget>[CustomAppBar.builsActionIcons()],
        actions: <Widget>[CustomAppBar.builsActionIconsClear()],
        // toolbarHeight: 80.0,
      ),

      //+++++ APP BAR ++++++++++++++++++++++++++++

      body: SafeArea(
        /*
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
      */

        //

        child: _cartlist.length <= 0
            ? Container(
                color: AppColors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FadeInImage(
                      placeholder: AssetImage(
                        'assets/images/sopping-box-empty.jpg',
                      ),
                      fit: BoxFit.cover,
                      // placeholder: null,
                      image: AssetImage(
                        'assets/images/sopping-box-empty.jpg',
                      ),
                    ),
                    //++++++++ MESSAGE ++++
                    TitleText(
                      color: AppColors.darkgrey,
                      fontSize: 24.0,
                      uppercase: false,
                      fontWeight: FontWeight.w400,
                      text: 'Votre panier est vide !',
                    ),
                    //++++++++ EMPTY SPACE ++++
                    SizedBox(
                      height: h / 4,
                    )
                  ],
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //............
                  Expanded(
                    child: ListView.builder(
                        itemCount: _cartlist.length,
                        itemBuilder: (context, index) {
                          //=========
                          final item = _cartlist[index];
                          //=========
                          return _buildItemTile(index, item);
                        }),
                  ),
                  //...........
                  Divider(
                      thickness: 6,
                      height: 6,
                      color: AppColors.icongray.withOpacity(0.25)),
                  //...........
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 16.0),
                    child: _price(),
                  ),

                  //   _submitButton(context),
                  _submitButtonOrder(context),
                  // SizedBox(height: 30),
                ],
              ),

        //++++++++++++++++++++++++++++
      ),

      // padding: const EdgeInsets
    );
  }

  //++++++++++++++++++++++++++++++++++++

  Widget _buildItemTile(int index, CartItem item) {
    //...
    return Column(
      children: [
        ListTile(
          //dense: true,
          onTap: () {},
          //........................
          isThreeLine: false,
          //........................
          title: Text(
            '${item.productName}',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
            ),
          ),
          //........................
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              //-------------
              children: [
                RichText(
                  text: TextSpan(children: [
                    // TextSpan(
                    //     text: 'Montant : ',
                    //     style: TextStyle(
                    //       color: AppColors.darkgray,
                    //       fontSize: 16.0,
                    //       fontWeight: FontWeight.w400,
                    //     )),
                    TextSpan(
                        text: '${item.priceTotal.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: AppColors.darkgray,
                          fontSize: 21.0,
                          fontWeight: FontWeight.w600,
                        )),
                    TextSpan(
                        text: ' DA',
                        style: TextStyle(
                          color: AppColors.darkblue,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w300,
                        )),
                  ]),
                ),
                //-------
              ],
            ),
          ),
          //..............................
          trailing: Container(
            width: 35,
            height: 35,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.orange,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TitleText(
              text: 'x${item.qty}',
              fontSize: 12,
              color: AppColors.white,
            ),
          ),
          //........................
          contentPadding: const EdgeInsets.only(
              left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),

          //......................................
          leading: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 8,
                      spreadRadius: 5,
                      color: AppColors.black.withOpacity(0.2))
                ]),

            //=================
            child: CircleAvatar(
              backgroundColor: AppColors.white,
              //backgroundImage:
              child: item.image != '1.png'
                  ? Image.asset('assets/images/products/${item.image}')
                  : Image.asset('assets/images/products/3.png'),
            ),
            //=================
          ),

          //...
        ),

        //++...............+++++++++++

        //...........
        Divider(
          thickness: 1,
          height: 2,
          color: AppColors.icongray.withOpacity(0.3),
        ),
        //...........
      ],
    );
  }

//++++++++++++++++++++++++++++++++++++++++
  Widget _price() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TitleText(
          text: _cartlist.length > 1
              ? '${_cartlist.length} Produits'
              : '${_cartlist.length} Produit',
          color: AppColors.grey,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        TitleText(
          text: '${getPrice().toStringAsFixed(2)} DA',
          // text: 'LE PRIX',
          fontSize: 20,
        ),
      ],
    );
  }

  //..........................
  double getPrice() {
    double price = 0;
    _cartlist.forEach((x) {
      price += (x.priceTotal).toDouble();
    });
    return price;
  }

//++++++++++++++++++++++++++++++++++++++++

  Widget _submitButtonOrder(BuildContext context) {
//::::::::: BUTTON CONFIRME/ CANCEL:::::::::::::::::
    return CustomFadeTranslateAnimation(
      begin: 100,
      delay: 300,
      duration: 900,
      widthContent: w,
      heightContent: h * 1 / 7,
      childContent: Container(
        //color: Colors.red,
        child: Align(
          alignment: Alignment.center,
          child: Container(
            width: w - (w / 10),
            height: 60,
            child: RaisedButton(
              //*+++++++++++++++...................++++++++++++++
              onPressed: () {
                //..
                //..
              },
              //*+++++++++++++++...................++++++++++++++
              color: AppColors.darkblue4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0)),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check,
                    color: AppColors.white,
                  ),
                  SizedBox(
                    width: 16.0,
                  ),
                  TitleText(
                    text: 'Lancez la commande',
                    color: AppColors.gold,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    letterSpacing: 2.0,
                  ),
                  // Text(
                  //   'Lancez la commande',
                  //   style: TextStyle(
                  //     fontSize: 18,
                  //     fontFamily: 'Poppins',
                  //     letterSpacing: 2,
                  //     color: AppColors.gold,
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

/*
Widget _submitButton(BuildContext context) {
    return FlatButton(
      
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
*/
  //++++++++++++++++++++++++++
}
