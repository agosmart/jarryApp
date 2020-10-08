import 'package:flutter/material.dart';
import 'package:jariapp/models/product..dart';
import 'package:jariapp/services/category.dart';
import 'package:jariapp/services/products.dart';
import 'package:jariapp/utils/colors.dart';
import 'package:jariapp/widgets/animations/custom.fade.translate.animation.dart';
//import 'package:jariapp/widgets/animations/action.icon.dart';
import 'package:provider/provider.dart';
//import 'package:page_transition/page_transition.dart';

//----
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';

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
  //---------
  ProductsProvider _productsProvider;
  CategoryProvider _categoryProvider;
  //............

  final TransformationController _transformationController =
      TransformationController();

  //--------------------------

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    //.......... INIT Products / category Provider ...............
    _categoryProvider = Provider.of<CategoryProvider>(context, listen: false);
    _productsProvider = Provider.of<ProductsProvider>(context, listen: false);
    _currentProd = _productsProvider.currentProduct;
    numOfItems = _currentProd.minimumOrder;
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
        child: SingleChildScrollView(
          //........ IMAGE .......
          child: Stack(
            fit: StackFit.passthrough,
            overflow: Overflow.visible,
            children: [
              //::::::::::::: incriment/decriment Bloc ::::::::::::::::::::
              //--------ANIMATION -01 -----------------------------
              CustomFadeTranslateAnimation(
                begin: -100,
                delay: 1000,
                duration: 1200,
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
                  ),
                ),
              ),

              //------------------------------------

              Positioned(
                bottom: 50,
                left: 0,
                right: 0,
                //--------ANIMATION -02 -----------------------------
                child: CustomFadeTranslateAnimation(
                  begin: -100.0,
                  delay: 1500,
                  duration: 1500,
                  widthContent: w,
                  heightContent: h / 10,
                  childContent: _buildCartCounter(),
                ),
                //---------------------------------------------------
              ),

              //:::::::::::: IMAGE BLOC ::::::::::::::::::
              CustomFadeTranslateAnimation(
                begin: -100,
                delay: 500,
                duration: 1200,
                widthContent: w,
                heightContent: (h * 5 / 7),
                childContent: Stack(
                  children: [
                    //::::::::::::  ZOOM IMAGE - interactive_viewer ::::::::
                    InteractiveViewer(
                      transformationController: _transformationController,
                      onInteractionEnd: (details) {
                        _transformationController.value = Matrix4.identity();
                      },
                      child: Container(
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
                        child: //::::::::::::: PRODUCT IMAGE :::::::::::::::::
                            Container(
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
                    ),
                    //+++++

                    Positioned(
                      bottom: h * 2 / 4,
                      right: 20.0,
                      child: Container(
                        //padding: const EdgeInsets.all(16.0),
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
              ),

              //::::::::::::::::::::::::::::::
            ],

            //:::::::::: Buttons Confirmation :::::::::::

            //+++++++++++++++++++++++++++++++++++++++++++
          ),

          // //........ TITRE .......
          // Container(
          //   width: double.infinity,
          //   padding: const EdgeInsets.only(
          //       top: 10.0, left: 20, right: 20, bottom: 20),

          //   child: Text(
          //     '${_currentProd.productName}',
          //     style: TextStyle(
          //       fontSize: 18.0,
          //       fontWeight: FontWeight.w600,
          //       // color: _catColor,
          //     ),
          //     textAlign: TextAlign.center,
          //   ),
          // ),
          //........ CART COUNTER ......

          //..........
        ),
      ),
    );
  }
//++++++++++++++++++++++

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
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            //+++++++++++++++++
            child: Selector<ProductsProvider, int>(
                selector: (context, _productsProvider) =>
                    _productsProvider.getNumOfItems,
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
                        width: double.infinity,
                        //height: numOfItems <= numOfItemsMin ? 20.0 : 40.0,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 4),
                        decoration: BoxDecoration(
                          color: numOfItems <= numOfItemsMin
                              ? AppColors.darkblue.withOpacity(0.5)
                              : AppColors.white.withOpacity(0.7),
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                        child: Text(
                          '${numOfItems <= numOfItemsMin ? "Minimum" : "Articles"}',
                          style: TextStyle(
                            color: numOfItems <= numOfItemsMin
                                ? AppColors.white
                                : AppColors.black,
                            fontSize: 12.0,
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
          flex: 5,
          child: Container(
              width: w * 2 / 5,
              padding: const EdgeInsets.only(
                  top: 16.0, bottom: 16.0, left: 8.0, right: 8.0),
              margin: const EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                color: AppColors.white.withOpacity(0.2),
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),

              //++++++++++++++++

              child: Selector<ProductsProvider, int>(
                  selector: (context, _productsProvider) =>
                      _productsProvider.getNumOfItems,
                  builder: (_, getNumOfItems, child) {
                    print('TOTAL PRICE ::::$getNumOfItems');

                    final total = numOfItems * 1 * _currentProd.unitPrice;

                    //------------------
                    return RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                          // text: '$getTotalePrice',

                          text: total > 9999
                              ? '${total.toStringAsFixed(0)}'
                              : '${total.toStringAsFixed(2)}',
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
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.white.withOpacity(0.4),
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
        //  color: AppColors.transparent,
        padding: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: press,
        child: Icon(
          icon,
          size: 24.0,
          color: AppColors.white,
          // color: AppColors.white,
        ),
      ),
    );
  }
}
