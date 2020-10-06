import 'package:flutter/material.dart';
import 'package:jariapp/models/product..dart';
import 'package:jariapp/services/products.dart';
import 'package:jariapp/utils/colors.dart';
import 'package:jariapp/widgets/animations/action.icon.dart';
import 'package:provider/provider.dart';

class ProductDetailsPage extends StatefulWidget {
  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  //............
  int numOfItems = 1;
  double w;
  double h;
  ProductsProvider _productsProvider;
  //............

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //.......... INIT Products Provider ...............
    _productsProvider = Provider.of<ProductsProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    //............
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    //............

    Product _currentProd = _productsProvider.currentProduct;

    return Scaffold(
        // backgroundColor: Colors.grey[100],

        backgroundColor: AppColors.canvaColor,

        //+++++

        appBar: AppBar(
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          // leading: null,
          automaticallyImplyLeading: true,
          elevation: 1,
          centerTitle: true,
          iconTheme: IconThemeData(color: AppColors.icongray),
          title: AppBarCustom.logoHeader(),
          actions: AppBarCustom.actionIcon(),
        ),

        //-----------------
        body: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //........ IMAGE .......
            Container(
                width: w,
                height: h * 1 / 2,
                decoration: BoxDecoration(
                    color: AppColors.white,
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
                    )),
                child: Stack(
                  children: [
                    //::::::::::::: PRODUCT IMAGE :::::::::::::::::
                    Container(
                      width: w,
                      padding: const EdgeInsets.all(16.0),
                      child: FadeInImage(
                        fadeInCurve: Curves.decelerate,
                        fadeInDuration: const Duration(milliseconds: 1200),
                        placeholder: AssetImage('assets/images/logo-jari1.png'),
                        image: AssetImage(
                            'assets/images/products/${_currentProd.image}'),
                        fit: BoxFit.contain,
                      ),
                    ),

                    //::::::::::::::::::::::::::::::
                    Positioned(
                      bottom: 30.0,
                      right: 30.0,
                      child: Container(
                        //padding: const EdgeInsets.all(16.0),
                        width: 120.0,
                        height: 120.0,
                        child: Center(
                          // child: Text(
                          //   '300.00',
                          //   style: TextStyle(
                          //       color: AppColors.white,
                          //       fontSize: 24.0,
                          //       fontWeight: FontWeight.w600),
                          // ),
                          //++++++++++++++++

                          child: RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text:
                                      '${_currentProd.unitPrice.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 21.0,
                                    fontWeight: FontWeight.w600,
                                  )),
                              TextSpan(
                                text: ' DA',
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ]),
                          ),
                          //-------

                          //+++++++++++++++++++++
                        ),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                'assets/images/bubble1.webp',
                              ),
                              fit: BoxFit.cover),
                        ),
                      ),
                    )

                    //::::::::::::::::::::::::::::::
                  ],
                )

                // child: Image.asset(
                //   'assets/images/products/${_currentProd.image}',
                //   fit: BoxFit.contain,
                // ),
                ),

            Padding(
              padding: const EdgeInsets.only(top: 36.0),
              child: Text(
                '${_currentProd.productName}',
                style: TextStyle(fontSize: 21.0, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            //........ CART COUNTER ......
            _buildCartCounter(),
            //..........
          ],
        )));
  }
//++++++++++++++++++++++

  Widget _buildCartCounter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        buildOutlineButton(
          icon: Icons.remove,
          press: () {
            if (numOfItems > 1) {
              setState(() {
                numOfItems--;
              });
            }
          },
        ),
        Container(
          width: w / 5,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            // if our item is less  then 10 then  it shows 01 02 like that
            numOfItems.toString().padLeft(2, "0"),
            style: Theme.of(context).textTheme.headline5,
            textAlign: TextAlign.center,
          ),
        ),
        buildOutlineButton(
            icon: Icons.add,
            press: () {
              setState(() {
                numOfItems++;
              });
            }),
      ],
    );
  }

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
