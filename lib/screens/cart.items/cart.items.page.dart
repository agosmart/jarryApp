import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jariapp/models/cart.item.dart';
import 'package:jariapp/screens/terms.condistions/cgv.dart';
import 'package:jariapp/themes/colors.dart';
import 'package:jariapp/utils/constantes.dart';
import 'package:jariapp/providers/products.dart';
import 'package:jariapp/utils/jari_icons_v2.dart';
import 'package:jariapp/themes/colors.dart';
import 'package:jariapp/widgets/animations/custom.fade.translate.animation.dart';
import 'package:jariapp/widgets/custom.appbar.dart';
import 'package:jariapp/widgets/show.dialogue.dart';
import 'package:jariapp/widgets/title.text.dart';
import 'package:provider/provider.dart';
import 'package:jariapp/screens/location/location.page.dart';

class CartItemsPage extends StatefulWidget {
  //....
  CartItemsPage({Key key}) : super(key: key);

  @override
  _CartItemsPageState createState() => _CartItemsPageState();
}

class _CartItemsPageState extends State<CartItemsPage> {
  //+++++++++++++++++++++++++
  List<CartItem> _cartlist;
  double h, w;
  ProductsProvider _productsProvider;
  bool checkBoxValue;
  //++++++++++++++++++++++++++

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cartlist = [];
    checkBoxValue = false;
    //++++
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _openConditionsPage(context) {
    print('READ MORE....');

    Navigator.push(
      context,
      MaterialPageRoute(
        //-------------------------------------------------
        builder: (BuildContext context) {
          return CGVPage();
        },
        fullscreenDialog: true,

        //--------------------------------------------------
      ),
    );
  }

  ///

  @override
  Widget build(BuildContext context) {
    //++++

    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;

    _productsProvider = Provider.of<ProductsProvider>(context, listen: true);
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

        //     child: Selector<ProductsProvider, List<CartItem>>(
        //         //............
        //         selector: (context, _productsProvider) =>
        //             _productsProvider.getCartItems,
        //         builder: (_, currentCartItems, child) {
        //           print('TOTAL ITEMS IN CART ::::$currentCartItems');

        //           //final List<CartItem> _carruentCartItem = getCartItems;
        //  }),
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
                          return _buildItemTile(context, index, item);
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

                  Row(
                    children: <Widget>[
                      Checkbox(
                          value: checkBoxValue,
                          onChanged: (bool newValue) {
                            setState(() {
                              checkBoxValue = newValue;
                            });
                          }),
                      Expanded(
                        child: Text(
                          "j'accepte les conditions générales de vente.",
                          softWrap: true,
                          style: TextStyle(
                            color: AppColors.darkblue4,
                            fontSize: 18,
                          ),
                        ),
                      ),

                      //++++++++

                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: OutlineButton(
                          onPressed: () {
                            //+++++++++++++++++++++++++

                            _openConditionsPage(context);

                            //+++++++++++++++++++++++++
                          },
                          child: Text(
                            "Lire Plus",
                            style: TextStyle(
                                color: AppColors.darkblue4,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      )
                    ],
                  ),

                  //+++++++++++++++++++++++++++++++++++

                  //   _submitButton(context),
                  _submitButtonOrder(context),
                  // SizedBox(height: 30),
                ],
              ),

        //..........

        //++++++++++++++++++++++++++++
      ),

      // padding: const EdgeInsets
    );
  }

  Widget _buildItemTile(BuildContext context, int index, CartItem item) {
    //...
    int prodId = item.productId;
    //...

    //... START  Dismissible ..........
    return Dismissible(
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
      direction: DismissDirection.endToStart,
      //++++++++++++++++++++
      background: Container(
          color: AppColors.orange,
          child: Container(
            padding: EdgeInsets.only(right: 20),
            alignment: Alignment.centerRight,
            child: Icon(JariIcons.x_circle, color: Colors.white),
          )),
      //++++++++++++++++++++

      child: Column(
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
      ),

      //... END  Dismissible ..........
    );
  }

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
              onPressed: checkBoxValue
                  ? () {
                      //..
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          //-------------------------------------------------
                          builder: (BuildContext context) {
                            return LocationPage();
                          },
                          //  fullscreenDialog: true,
                          //--------------------------------------------------
                        ),
                      );
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
}
