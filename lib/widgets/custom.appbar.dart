import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jariapp/providers/products.dart';
import 'package:jariapp/screens/cart.items/cart.items.page.dart';

import 'package:jariapp/themes/colors.dart';

import 'package:jariapp/utils/jari_icons_v2.dart';

import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class CustomAppBar {
  //+++++++++++++++++++++.

  static const toolbarHeight = 72.0;
  static const double elevation = 6.0;
  static const backgroundColor = Colors.white;
  static const bool centerTitle = true;
  ProductsProvider _productsProvider;

  //++++++++++++ BUTTON LOGO APP +++++++++++++
  static Widget logoHeader() {
    /* return Image.asset(
      'assets/images/logo-jari-only.png',
      //fit: BoxFit.scaleDown,
      height: 58.0,
    );
 */
    return SizedBox(
      height: toolbarHeight,
      child: Image.asset('assets/images/logo-jari-only.png'),
    );
  }

  //++++++++++++ BUTTON DELETE CART ITEMS ++++++++++++++++
  static Widget builsActionIconsClear() {
    return Selector<ProductsProvider, int>(
        selector: (context, _productsProvider) =>
            _productsProvider.getItemCount,
        builder: (context, getItemCount, child) {
          print('TOTAL PRICE ::::$getItemCount');

          //_productsProvider =

          //.............
          return getItemCount <= 0
              ? Center()
              : Center(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 8, left: 8, right: 16.0),
                    child: IconButton(
                        alignment: Alignment.center,
                        icon: Icon(
                          JariIcons.trash_2,
                          size: 30.0,
                          color: AppColors.icongray,
                        ),
                        onPressed: () async {
                          //++++++

                          await Provider.of<ProductsProvider>(context,
                                  listen: false)
                              .clearCartItems();

                          //  Navigator.of(context).pop();
                          //-------

                          /*
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              //-------------------------------------------------
                              builder: (BuildContext context) => HomePage(),
                              //--------------------------------------------------
                            ),
                            //+++++
                          );
                          */
                        }
                        //------------------
                        // Icons.shopping_basket,
                        ),
                  ),
                );

          //..............
        });

    /* 
    return Builder(builder: (context) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 8, left: 8, right: 16.0),
          child: IconButton(
              alignment: Alignment.center,
              icon: Icon(
                JariIcons.trash_2,
                size: 32.0,
                color: AppColors.icongray,
              ),
              onPressed: () {           
                //++++++
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    //-------------------------------------------------
                    builder: (BuildContext context) => HomePage(),
                    //--------------------------------------------------
                  ),

                  //+++++
                );
              }
              //------------------
              // Icons.shopping_basket,
              ),
        ),
      );
    });
  */
  }

  //+++++++++++++++++++
  static Widget builsActionIcons() {
    // final list = Padding(
    //   padding: const EdgeInsets.only(right: 16.0),
    //   child: IconButton(
    //     icon: Icon(
    //       JariIcons.shopping_cart,
    //       size: 30.0,
    //       color: AppColors.icongray,
    //     ),
    //     onPressed: () {},

    //     // Icons.shopping_basket,
    //   ),
    // );

    // return [list];

    /*
    return Selector<ProductsProvider, int>(
        selector: (context, _productsProvider) =>
            _productsProvider.getItemCount,
        builder: (context, getItemCount, child) {
          print('TOTAL PRICE ::::$getItemCount');
    */
    return Selector<ProductsProvider, Tuple2<int, bool>>(
        selector: (context, ProductsProvider productsProvider) => Tuple2(
            productsProvider.getItemCount, productsProvider.isCartItemsOrdred),
        builder: (context, data, __) {
          //+++++++++++++++++++++++++++++++++
          //*-1 - Get number of items in CartItems
          int getItemCount = data.item1;
          //*-2- Cart Items is ready Ordred or No
          bool isCartItemsOrdred = data.item2;
          //+++++++++++++++++++++++++++++++++++
          print('TOTAL PRICE ::::$getItemCount');
          print(' CartItems Ordred  ::::$isCartItemsOrdred ');

          //----------
          return Stack(
            children: [
              //+++++++++++++++++++

              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    alignment: Alignment.center,
                    icon: Icon(
                      JariIcons.shopping_cart_r,
                      size: 32.0,
                      color: AppColors.icongray,
                    ),
                    onPressed: () {
                      //-------------------

                      /*  Navigator.pushReplacementNamed(context, '/cartItemsPage');*/

                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            //-------------------------------------------------
                            builder: (BuildContext context) => CartItemsPage(),
                            //--------------------------------------------------
                          ),
                          ModalRoute.withName('/homePage'));
                      //------------------
                    },
                    // Icons.shopping_basket,
                  ),
                ),
              ),

              //+++++++ BADGE Cart ++++++++++++++++
              getItemCount > 0
                  ? Positioned(
                      left: 4.0,
                      top: 10.0,
                      child: Container(
                        alignment: Alignment.center,
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                            //++++++++++++++++++++++++++++++++

                            color: isCartItemsOrdred
                                ? AppColors.goldDark
                                : AppColors.pinck,

                            //++++++++++++++++++++++++++++++
                            borderRadius: BorderRadius.circular(24)),
                        child: Text(
                          '$getItemCount',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    )
                  : Center()
              //----------

              //+++++++++++++++++++++
            ],
          );
        });
  }
}
