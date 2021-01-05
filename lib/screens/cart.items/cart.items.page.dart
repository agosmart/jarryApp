import 'package:flutter/material.dart';
import 'package:jarryApp/models/cart.item.dart';
import 'package:jarryApp/models/product.dart';

import 'package:jarryApp/responsive/responsive_safe_area.dart';

import 'package:jarryApp/themes/colors.dart';
import 'package:jarryApp/utils/constantes.dart';
import 'package:jarryApp/providers/products.dart';
import 'package:jarryApp/utils/jari_icons_v2.dart';

import 'package:jarryApp/widgets/animations/custom.fade.translate.animation.dart';
import 'package:jarryApp/widgets/custom.appbar.dart';
import 'package:jarryApp/widgets/show.dialogue.dart';
import 'package:jarryApp/widgets/title.text.dart';
import 'package:provider/provider.dart';

import 'package:tuple/tuple.dart';

class CartItemsPage extends StatefulWidget {
  //....
  CartItemsPage({Key key}) : super(key: key);

  @override
  _CartItemsPageState createState() => _CartItemsPageState();
}

class _CartItemsPageState extends State<CartItemsPage> {
  //+++++++++++++++++++++++++
  List<CartItem> _cartlist;
  double _width, _height;
  ProductsProvider _productsProvider;
  // OrderProvider _providerOrder;
  bool checkBoxValue;
  bool isItemsOrdred;
  //++++++++++++++++++++++++++

  @override
  void initState() {
    super.initState();
    _cartlist = [];

    // _providerOrder = Provider.of(context, listen: true);
    //++++
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _openConditionsPage(context) {
    print('READ MORE....');

    //-------------------------------------------------
    Navigator.pushNamed(context, '/cgvPage');
    //-------------------------------------------------

    /*Navigator.push(
      context,
      MaterialPageRoute(
        //-------------------------------------------------
        builder: (BuildContext context) {
          return CGVPage();
        },
        fullscreenDialog: true,

        //--------------------------------------------------
      ),
    );*/
  }

  ///

  @override
  Widget build(BuildContext context) {
    //++++

    // w = MediaQuery.of(context).size.width;
    // h = MediaQuery.of(context).size.height;

    _productsProvider = Provider.of<ProductsProvider>(context, listen: true);

    checkBoxValue = _productsProvider.isChecked ?? false;
    _cartlist = [..._productsProvider.getCartItems];
    //++++++++++++++++++++++++++++++++++++++++++++++

    return ResponsiveSafeArea(
      //------
      builder: (context, size) {
        //++++++
        _width = size.width;
        _height = size.height;
        //++++++

        //++++

        return Scaffold(
          // backgroundColor: Colors.grey[100],

          // backgroundColor: AppColors.canvaColor,

          //+++++ APP BAR ++++++++++++++++++++++++++++
          appBar: AppBar(
            brightness: Brightness.light,

            iconTheme: IconThemeData(color: AppColors.icongray),
            backgroundColor: CustomAppBar.backgroundColor,
            /*
        leading: IconButton(
            icon: Icon(
              Icons.list_alt_outlined,
              color: AppColors.icongray,
              size: 32,
            ),
            onPressed: () {
              //++++++++++++++++++++++++++
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => ProductsPage()),
                ModalRoute.withName('/productsPage'),
              );

              //++++++++++++++++++++++++++
            }),
        automaticallyImplyLeading: true,
        */

            leading: null,
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

          body: _cartlist.length <= 0
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
                        height: _height / 4,
                      )
                    ],
                  ),
                )
              : Selector<ProductsProvider, Tuple3<bool, bool, String>>(
                  selector: (context, ProductsProvider productsProvider) =>
                      Tuple3(
                        productsProvider.isChecked,
                        productsProvider.isCartItemsOrdred,
                        productsProvider.transactionNumber,
                      ),
                  builder: (_, data, __) {
                    //+++++++++++++++++++++++++++++++++
                    //*-1 - Check Box is Ttchecked Or No
                    bool isChecked = data.item1;
                    //*-2- Cart Items is ready Ordred or No
                    bool isCartItemsOrdred = data.item2;
                    //*-3- Get Transaction Number
                    String transactionNumber = data.item3;
                    //+++++++++++++++++++++++++++++++++++
                    print(
                        'isChecked >>>>>>  $isChecked / isCartItemsOrdred >>>>>  $isCartItemsOrdred');
                    //+++++++++++++++++++++++++++++
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //...........
                        isCartItemsOrdred
                            ? Center(
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  width: _width,
                                  decoration: BoxDecoration(
                                    color: AppColors.pinck,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      //......
                                      TitleText(
                                        text: 'Commande en cours',
                                        color: AppColors.white,
                                        fontSize: 16,
                                        letterSpacing: 0.8,
                                      ),
                                      //.....

                                      TitleText(
                                        //0000012526
                                        text: 'N°: $transactionNumber',
                                        color: AppColors.white,
                                        fontSize: 21,
                                      ),

                                      BodyText(
                                        text:
                                            'Vider votre panier pour créer une nouvelle commande',
                                        color: AppColors.white,
                                        fontSize: 12,
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Center(),
                        //............
                        Expanded(
                          child: ListView.builder(
                              itemCount: _cartlist.length,
                              itemBuilder: (context, index) {
                                //=========
                                final item = _cartlist[index];
                                //=========
                                return _buildItemTile(
                                    context, index, item, isCartItemsOrdred);
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
                        //+++++++++++++++++++++++++++++++++

                        // GestureDetector(
                        //   onTap: () {
                        //     print('read');
                        //   },
                        //   child: TitleText(
                        //     color: AppColors.icongray,
                        //     fontSize: 16.0,
                        //     uppercase: false,
                        //     fontWeight: FontWeight.w400,
                        //     textAlign: TextAlign.left,
                        //     text:
                        //         'Je reconnais avoir pris connaissance des conditions générales de vente et les accepte. ',
                        //   ),
                        // ),

                        //...........
                        Divider(
                            thickness: 2,
                            height: 2,
                            color: AppColors.icongray.withOpacity(0.25)),
                        //...........
                        SizedBox(
                          height: 16.0,
                        ),

                        //*+++++++++ SELECTOR 2 VARS +++++++++++++++
                        isCartItemsOrdred
                            //++++++++++++++++++++++++++
                            ? Center()
                            : Column(
                                children: [
                                  Row(
                                    children: <Widget>[
                                      //...........................
                                      // Selector<ProductsProvider, bool>(
                                      //     //............
                                      //     selector: (context, _productsProvider) =>
                                      //         _productsProvider.isChecked,
                                      //     builder: (_, isChecked, child) {
                                      //       //......
                                      //       print('CHECKBOX STATE::::$isChecked');
                                      //       return Checkbox(
                                      //           value: isChecked,
                                      //           onChanged: (bool newValue) {
                                      //             _productsProvider.setIsChecked(newValue);
                                      //           });
                                      //     }),
                                      //.............................
                                      Checkbox(
                                          value: isChecked, //isChecked,
                                          onChanged: (bool newValue) {
                                            _productsProvider
                                                .setIsChecked(newValue);
                                          }),

                                      //...........................
                                      Expanded(
                                          child: BodyText(
                                        text:
                                            "J'accepte les conditions générales de vente.",
                                        color: AppColors.darkblue4,
                                        fontSize: 12,
                                      )),

                                      //++++++++

                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16, right: 16),
                                        child: OutlineButton(
                                            onPressed: () {
                                              //+++++++++++++++++++++++++
                                              _openConditionsPage(context);
                                              //+++++++++++++++++++++++++
                                            },
                                            child: TitleText(
                                              text: "Lire plus",
                                              color: AppColors.pinck,
                                              fontSize: 14,
                                              letterSpacing: 0.5,
                                              uppercase: true,
                                            )),
                                      )
                                    ],
                                  ),
                                  //+++++++++++++++++++++++++++++++++++

                                  _submitButtonOrder(context),

                                  //+++++++++++++++++++++++++++++++++++
                                ],
                              ),
                        //+++++++++++++++++++++++++
                      ],
                    );

                    //..........
                  }),

          // padding: const EdgeInsets
        );

        //++++
      },
    );
  }

//............ liSt TILE .....................

  Widget _buildItemTile(
      BuildContext context, int index, CartItem item, bool isCartItemsOrdred) {
    //...
    int prodId = item.productId;
    //...
    final Product _currentProdById = _productsProvider.getProductById(prodId);

    //....

    Widget _background = Container(
      color: AppColors.orange,
      child: Container(
        padding: EdgeInsets.only(right: 20),
        alignment: Alignment.centerRight,
        child: Icon(JariIcons.x_circle, color: Colors.white),
      ),
    );

    //+++++++++++++++++++++++++++++
    Widget _listTileProducts = ListTile(
      onTap: isCartItemsOrdred
          ? () {}
          : () {
              print('_currentProdById ::::: $_currentProdById');
              //+.+.+.+.+.+ SET CURRENT PRODUCT .+.+.+.+.+.+.+
              _productsProvider.setCurrentProduct(_currentProdById);
              //+.+.+.+.+.+.+.+.+.+.++.+.+.+.+.+.+.+.+.+.+.+.+

              Navigator.pushNamed(context, '/productDetailsPage');
            },
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
        width: 36,
        height: 36,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.orange,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TitleText(
          text: 'x${item.qty}',
          fontSize: 14,
          color: AppColors.white,
        ),
      ),
      //........................
      contentPadding:
          const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),

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

          child: Image.network(
            '${IMAGEURL + item.image}',
            //'http://danone.cooffa.shop/data_app/storage/app/public/products/images/placehoder.png',

            errorBuilder: (BuildContext context, Object exception,
                StackTrace stackTrace) {
              // Appropriate logging or analytics, e.g.
              // myAnalytics.recordError(
              //   'An error occurred loading "https://example.does.not.exist/image.jpg"',
              //   exception,
              //   stackTrace,
              // );
              return Text(
                '😢',
                style: TextStyle(fontSize: 24),
              );
            },
          ),

          // child: item.image != '1.png'
          //     ? Image.asset('assets/images/products/${item.image}')
          //     : Image.asset('assets/images/products/3.png'),
        ),
        //=================
      ),

      //...
    );

    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    return isCartItemsOrdred
        ? Column(
            children: [
              //...........
              _listTileProducts,
              //...........
              Divider(
                thickness: 1,
                height: 2,
                color: AppColors.icongray.withOpacity(0.3),
              ),
              //...........
            ],
          )

        //... END NOT  Dismissible ..........

        :

        //... START  Dismissible ..........
        Dismissible(
            //++++++++++++++++++++
            key: UniqueKey(),
            //++++++++++++++++++++
            confirmDismiss: (DismissDirection direction) async {
              return await showDialog(
                context: context,
                builder: (_) {
                  return CustomDialigue(
                    //.............
                    title: 'Confirmation',
                    action: 2,
                    textContent:
                        'Êtes-vous sûr de bien vouloir supprimer le produit de votre panier?',
                    submit: () async {
                      //+++++++
                      await _productsProvider.removeProductFromCart(prodId);
                      Navigator.of(context).pop();

                      //+++++++
                    },
                    //.............
                  );
                },
              );
            },
            //++++++++++++++++++++
            /*  onDismissed: (_) {
        _cartlist = [..._productsProvider.getCartItems];
      }, */
            //++++++++++++++++++++
            direction: isCartItemsOrdred ? null : DismissDirection.endToStart,
            //++++++++++++++++++++
            background: _background,
            //++++++++++++++++++++

            child: Column(
              children: [
                //...........
                _listTileProducts,
                //...........
                Divider(
                  thickness: 1,
                  height: 2,
                  color: AppColors.icongray.withOpacity(0.3),
                ),
                //...........
              ],
            ),

            //... END  Dismissible ..........
          );
    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  }

  //.......................

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

  double getPrice() {
    double price = 0;
    _cartlist.forEach((x) {
      price += (x.priceTotal).toDouble();
    });
    return price;
  }

  Widget _submitButtonOrder(BuildContext context) {
//::::::::: BUTTON CONFIRME/ CANCEL:::::::::::::::::

    print('LENGTH == ${_cartlist.length} / _cartlist:::: $_cartlist');

    return CustomFadeTranslateAnimation(
      begin: 100,
      delay: 300,
      duration: 900,
      widthContent: _width,
      heightContent: _height * 1 / 7,
      childContent: Container(
        //color: Colors.red,
        child: Align(
          alignment: Alignment.center,
          child: Container(
            width: _width - (_width / 10),
            height: 60,
            child: RaisedButton(
              //*+++++++++++++++...................++++++++++++++
              onPressed: checkBoxValue
                  ? () {
                      //..........locationPage...............
                      Navigator.pushNamed(context, '/locationPage');
                      //........................
                      /* Navigator.push(
                        context,
                        MaterialPageRoute(
                          //-------------------------------------------------
                          builder: (BuildContext context) {
                            return LocationPage();
                          },
                          //  fullscreenDialog: true,
                          //--------------------------------------------------
                        ),
                      );*/
                      //..
                    }
                  : null,
              //*+++++++++++++++...................++++++++++++++
              color: AppColors.darkblue4,
              disabledColor: AppColors.darkblue4.withOpacity(0.35),
              disabledTextColor: AppColors.white,
              // textColor: AppColors.gold,
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
                    color: checkBoxValue ? AppColors.gold : AppColors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    letterSpacing: 2.0,
                  ),
                  // Text(
                  //   'Lancez la commande',
                  //   style: TextStyle(
                  //     fontSize: 18,
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
}
