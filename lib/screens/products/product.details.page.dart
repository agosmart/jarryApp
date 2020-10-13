import 'package:flutter/material.dart';

import 'package:jariapp/models/cart.item.dart';
import 'package:jariapp/models/product..dart';
import 'package:jariapp/services/category.dart';
import 'package:jariapp/services/products.dart';
import 'package:jariapp/utils/colors.dart';
import 'package:jariapp/widgets/animations/custom.fade.translate.animation.dart';
//import 'package:jariapp/widgets/animations/action.icon.dart';
import 'package:provider/provider.dart';
import 'package:page_transition/page_transition.dart';

class ProductDetailsPage extends StatefulWidget {
//   //-------
//   var colorCat;
//   var iconCat;
// //-----
//   ProductDetailsPage(
//     this.iconCat,
//     this.colorCat,
//   );
  ProductDetailsPage();

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  //............
  int numOfItems;
  int numOfItemsMin;
  double w;
  double h;
  Color _catColor;
  Product _currentProd;
  CartItem _cart;
  int _productId;
  //---------
  ProductsProvider _productsProvider;
  CategoryProvider _categoryProvider;
  //............

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    //.......... INIT Products / category Provider ...............
    _categoryProvider = Provider.of<CategoryProvider>(context, listen: false);
    _productsProvider = Provider.of<ProductsProvider>(context, listen: false);
    _currentProd = _productsProvider.currentProduct;
    _productId = _currentProd.productId;
    // numOfItems = _currentProd.minimumOrder;
    if (_productsProvider.getNumOfItems(_productId) == null) {
      numOfItems = _currentProd.minimumOrder;
    } else {
      numOfItems = _productsProvider.getNumOfItems(_productId);
    }

    numOfItemsMin = numOfItems;
  }

  @override
  Widget build(BuildContext context) {
    //............
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    _catColor = _categoryProvider.currentCatColor;
    //............

    // numOfItems = _currentProd?.minimumOrder;

    //+++++++++++++++++++++++++++++++++++++++++++++++++

    return Scaffold(
      // backgroundColor: Colors.grey[100],

      backgroundColor: AppColors.canvaColor,

      //+++++

      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        toolbarHeight: 80.0,
        // leading: null,
        automaticallyImplyLeading: true,
        elevation: 1,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.icongray),
        // title: AppBarCustom.logoHeader(),
        /*
          title: Text(
            'ACTIVIA BRASSE MUESLI-MIEL 105 G PRODUIT DANONE',
            style: TextStyle(
              color: AppColors.darkblue2,
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
            ),
            softWrap: true,
            overflow: TextOverflow.visible,
          ),
          */

        //........ TITRE .......
        title: Container(
          padding: const EdgeInsets.only(right: 20),
          // width: double.infinity,
          child: Text(
            //  'ACTIVIA BRASSE MUESLI-MIEL 105 G PRODUIT DANONE',
            '${_currentProd.productName}',
            style: TextStyle(
              color: AppColors.darkblue2,
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              // color: _catColor,
            ),
            softWrap: true,
            overflow: TextOverflow.visible,
            textAlign: TextAlign.left,
          ),
        ),

        //-----------------------------------
        //  actions: AppBarCustom.actionIcon(),
      ),

      //-----------------
      body: SafeArea(
        child: Container(
          height: h,
          // color: Colors.red,
          child: Stack(overflow: Overflow.visible,
              //fit: StackFit.loose,
              children: [
                //::::::::::::: incriment/decriment Bloc ::::::::::::

                //--------ANIMATION -01 --------

                Stack(
                    //-....
                    children: [
                      CustomFadeTranslateAnimation(
                        begin: -100,
                        delay: 1,
                        duration: 1,
                        widthContent: w,
                        heightContent: (h * 5 / 7),
                        childContent: Container(
                          padding: const EdgeInsets.all(0),
                          margin: const EdgeInsets.only(bottom: 30.0),
                          width: w,
                          height: (h * 1 / 2) + 110.0,
                          child: Container(
                            width: w,
                            // height: (h * 1 / 4),
                            decoration: BoxDecoration(
                              //color: AppColors.lightblue,
                              gradient: LinearGradient(
                                colors: [
                                  // Color(0xFF0090DF),
                                  // Color(0xFF0090DF).withOpacity(0.4),
                                  //...........................
                                  _catColor,
                                  _catColor.withOpacity(0.5),
                                  //...........................
                                ],
                                begin: Alignment(0.5, 0.8),
                                end: Alignment(0, 0),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 20,
                                  spreadRadius: 8,
                                  color: AppColors.darkblue.withOpacity(0.2),
                                )
                              ],
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(40),
                                bottomRight: Radius.circular(40),
                              ),
                            ),
                            //-----
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: CustomFadeTranslateAnimation(
                                begin: -50,
                                delay: 2,
                                duration: 2,
                                widthContent: w,
                                heightContent: h / 6,
                                childContent: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0, vertical: 20.0),
                                  child: _buildCartCounter(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      //-....
                    ]),

                //....... STACK -02 ..........

                Stack(
                  children: [
                    //-----
                    Container(
                      width: w,
                      height: (h * 1 / 2),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 12,
                            spreadRadius: 8,
                            color: AppColors.darkblue.withOpacity(0.5),
                          )
                        ],
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        ),
                      ),

                      //::::::::::::: PRODUCT IMAGE :::::::::::::::::
                      child: Container(
                        width: w,
                        padding: const EdgeInsets.all(16.0),
                        child: FadeInImage(
                          fadeInCurve: Curves.decelerate,
                          fadeInDuration: const Duration(milliseconds: 700),
                          placeholder:
                              AssetImage('assets/images/logo-jari1.webp'),
                          image: AssetImage(
                              'assets/images/products/${_currentProd.image}'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    //+++++
                    //::::::::::::: PRODUCT PRICE :::::::::::::::::
                    Positioned(
                      bottom: 30,
                      right: 30.0,
                      child: Container(
                        width: 110.0,
                        height: 110.0,
                        child: Center(
                          //++++++++++++++++
                          child: RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text:
                                      '${_currentProd.unitPrice.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w600,
                                  )),
                              TextSpan(
                                text: ' DA',
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ]),
                          ),
                          //+++++++++++++++++++++
                        ),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                // Color(0xFF0090DF),
                                // Color(0xFF0090DF).withOpacity(0.4),
                                //...........................
                                _catColor,
                                _catColor.withOpacity(0.6),
                                //...........................
                              ],
                            ),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.white,
                              width: 6.0,
                            ),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 6.0,
                                spreadRadius: 3.0,
                                color: _catColor.withOpacity(0.2),
                              ),
                            ]
                            // image: DecorationImage(
                            //   image: AssetImage(
                            //     'assets/images/bubble1.webp',
                            //   ),
                            //   fit: BoxFit.cover,
                            // ),
                            ),
                      ),
                    ),

                    //++++
                  ],
                ),

                //....... /.  Stack 1 ............

                //::::::::: BUTTON CONFIRME/ CANCEL:::::::::::::::::
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Container(
                    // color: Colors.yellow.withOpacity(0.5),
                    child: CustomFadeTranslateAnimation(
                      begin: 100,
                      delay: 3,
                      duration: 1,
                      widthContent: w,
                      heightContent: (h * 1 / 7),
                      childContent: Center(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            width: w - (w / 10),
                            height: 60,
                            child: RaisedButton(
                              //+++++++++++++++++
                              onPressed: () {
                                // TODO: is product exist
                                // 1 - non : add product
                                // 2 -oui : update product
                                //...
                                //Map<String, dynamic> _cartItem = {};

                                final productId = _currentProd.productId;
                                final qty =
                                    _productsProvider.getNumOfItems(productId);
                                final productName = _currentProd.productName;
                                final total = qty * _currentProd.unitPrice;

                                bool _isProductExist =
                                    _productsProvider.isProductExist(productId);

                                if (_isProductExist) {
                                  _productsProvider.updateProductCart(
                                      productId, qty, total);
                                } else {
                                  // _cart.idProduct = productId;
                                  // _cart.productName = _currentProd.productName;
                                  // _cart.total =
                                  //     _cart.qty * _currentProd.unitPrice;

                                  // _cartItem['idProduct'] = productId;
                                  // _cartItem['productName'] =
                                  //     _currentProd.productName;
                                  // _cartItem['total'] =
                                  //     qty * _currentProd.unitPrice;

                                  _cart = CartItem(
                                      productId, productName, qty, total);
                                }

                                //..

                                _productsProvider.addProductToCart(_cart);
                              },
                              //+++++++++++++++++
                              color: AppColors.darkblue2,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24.0)),

                              child: Text(
                                'CONFIRMER',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Poppins',
                                  letterSpacing: 2,
                                  color: AppColors.akablueLight,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                //:::::::::::: IMAGE BLOC ::::::::::::::::::
              ]),
        ),
      ),
    );
  }
//++++++++++++++++++++++

  Widget _buildCartCounter() {
    // _productsProvider?.setNumOfItems(numOfItems);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Flexible(
          flex: 2,
          child: buildOutlineButton(
              icon: Icons.remove,
              press: () {
                if (numOfItems > numOfItemsMin) {
                  print('DECRIMENT');
                  numOfItems--;
                  _productsProvider.setNumOfItems(numOfItems);
                } else {
                  print('NON-----DECRIMENT');
                }
              }),
        ),
        Flexible(
          flex: 3,
          child: Container(
            //width: w / 4,
            // alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            //+++++++++++++++++
            child: Selector<ProductsProvider, int>(
                selector: (context, _productsProvider) =>
                    _productsProvider.getNumOfItems(_productId),
                builder: (_, getNumOfItems, child) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //++++++
                      Text(
                        numOfItems.toString().padLeft(2, "0"),
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 28.0,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      //+++++++
                      // SizedBox(height: 4.0),
                      //++++++

                      Container(
                        //height: numOfItems <= numOfItemsMin ? 20.0 : 40.0,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: numOfItems <= numOfItemsMin
                              ? AppColors.darkblue.withOpacity(0.5)
                              : AppColors.white.withOpacity(0.7),
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                        ),
                        child: Text(
                          '${numOfItems <= numOfItemsMin ? "Minimum" : "Articles"}',
                          style: TextStyle(
                            color: numOfItems <= numOfItemsMin
                                ? AppColors.white
                                : AppColors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                          softWrap: false,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  );
                }),
            //+++++++++++++++++++
          ),
        ),
        Flexible(
          flex: 2,
          child: buildOutlineButton(
            icon: Icons.add,
            press: () {
              numOfItems++;
              print('_numOfItems ::: $numOfItems');
              _productsProvider.setNumOfItems(numOfItems);
              // setState(() {
              //   numOfItems++;
              // });
            },
          ),
        ),

        //------------------------

        Flexible(
          flex: 4,
          child: Container(
              width: w * 2 / 5,
              height: 56.0,
              padding: const EdgeInsets.only(
                  top: 16.0, bottom: 16.0, left: 8.0, right: 8.0),
              margin: const EdgeInsets.only(left: 16.0),
              decoration: BoxDecoration(
                color: AppColors.white.withOpacity(0.2),
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),

              //++++++++++++++++

              child: Selector<ProductsProvider, int>(
                  selector: (context, _productsProvider) =>
                      _productsProvider.getNumOfItems(_productId),
                  builder: (_, getNumOfItems, child) {
                    print('TOTAL PRICE ::::$getNumOfItems');
                    return RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                          // text: '$getTotalePrice',
                          text:
                              '${(numOfItems * _currentProd.unitPrice).toStringAsFixed(2)}',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 24.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: ' DA',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ]),
                    );
                  })

              //+++++++++++++++++++++

              //--------

              // child: Text(
              //   '5000',
              //   style: TextStyle(
              //     color: AppColors.white,
              //     fontSize: 24.0,
              //     fontWeight: FontWeight.w600,
              //   ),
              // ),

              //--------
              ),
        )
      ],
    );
  }

//+++++++++++++++++++++++++++++++

  // Widget _buildCartCounter1() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: <Widget>[
  //       buildOutlineButton(
  //         icon: Icons.remove,
  //         press: () {
  //           if (numOfItems > 1) {
  //             setState(() {
  //               numOfItems--;
  //             });
  //           }
  //         },
  //       ),
  //       Container(
  //         width: w / 5,
  //         alignment: Alignment.center,
  //         padding: const EdgeInsets.symmetric(horizontal: 20),
  //         child: Text(
  //           // if our item is less  then 10 then  it shows 01 02 like that
  //           numOfItems.toString().padLeft(2, "0"),
  //           style: Theme.of(context).textTheme.headline5,
  //           textAlign: TextAlign.center,
  //         ),
  //       ),
  //       buildOutlineButton(
  //           icon: Icons.add,
  //           press: () {
  //             setState(() {
  //               numOfItems++;
  //             });
  //           }),
  //     ],
  //   );
  // }

//++++++++++++++++++++++
  Container buildOutlineButton({IconData icon, Function press}) {
    return Container(
      // margin: const EdgeInsets.all(16.0),
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 12,
            spreadRadius: 5,
            color: AppColors.darkblue.withOpacity(0.2),
          ),
        ],
      ),

      child: OutlineButton(
        // borderSide: BorderSide(
        //   color: AppColors.darkgray.withOpacity(0.3),
        //   width: 2.0,
        // ),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
        onPressed: press,
        child: Icon(
          icon,
          size: 24.0,
        ),
      ),
    );
  }
}