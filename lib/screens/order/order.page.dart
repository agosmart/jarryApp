import 'package:flutter/material.dart';
import 'package:jariapp/providers/order.dart';
import 'package:jariapp/providers/products.dart';
import 'package:jariapp/screens/home/home.page.dart';
import 'package:jariapp/themes/colors.dart';
import 'package:jariapp/utils/helpers.dart';
import 'package:jariapp/utils/jari_icons_v2.dart';
import 'package:jariapp/widgets/custom.appbar.dart';
import 'package:jariapp/widgets/title.text.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  //..................
  final String clientPhone;
  //.................
  const OrderPage({Key key, this.clientPhone}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  //----------------
  OrderProvider _orderProvider;
  ProductsProvider _productsProvider;

  Future<dynamic> _futureFetching;
  String resultOrder;
  Map<String, String> routes;
  //+++++
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    resultOrder = '';

    //.......... INIT Order Provider ...............

    _orderProvider = Provider.of<OrderProvider>(context, listen: false);

    //.......... INIT Products Provider ...............

    _productsProvider = Provider.of<ProductsProvider>(context, listen: false);

    //.......... INIT FutureBuilder ...............
    _futureFetching = _orderProvider.fetchOrderAPI();
    //-------------
  }

  //+++++
  @override
  void dispose() {
    super.dispose();
  }

  //+++++
  @override
  Widget build(BuildContext context) {
    //+++++++++++++++++ EXTRACT PARSSED PARAMETERS FROM MAP PAGE +++++++++++++++++
    // routes = ModalRoute.of(context).settings.arguments;

    print(widget.clientPhone);

    //+++++++++++++++++++++++++++++++
    return Scaffold(
      //+++++
      backgroundColor: AppColors.canvaColor,
      //+++++
      appBar: AppBar(
        brightness: Brightness.light,

        // leading: null,
        leading: IconButton(
          icon: Icon(
            Icons.home_outlined,
            size: 32,
          ),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (BuildContext context) => HomePage()),
              ModalRoute.withName('/homePage'),
            );
          },
        ),
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: AppColors.icongray),
        backgroundColor: CustomAppBar.backgroundColor,
        // automaticallyImplyLeading: true,
        centerTitle: CustomAppBar.centerTitle,

        elevation: CustomAppBar.elevation,
        toolbarHeight: CustomAppBar.toolbarHeight,
        title: CustomAppBar.logoHeader(),
        // actions: <Widget>[CustomAppBar.builsActionIcons()],
        //  actions: <Widget>[CustomAppBar.builsActionIconsClear()],
        // toolbarHeight: 80.0,
      ),

      //--------------------------
      body: WillPopScope(
        //---------------------
        onWillPop: () async => false,
        //------------------
        child: SafeArea(
          //======
          child: FutureBuilder(
              future: _futureFetching,
              builder: (BuildContext context, AsyncSnapshot snapShot) {
                //++++++
                switch (snapShot.connectionState) {
                  case ConnectionState.none:
                    // return Text('nothing happend !!!');
                    return error('No connexion made!');
                    break;
                  case ConnectionState.waiting:
                  case ConnectionState.active:
                    //  return Center();
                    return loading(AppColors.akablueLight);
                    break;
                  case ConnectionState.done:
                    if (snapShot.hasError) {
                      return error(snapShot.error.toString());
                    } else {
                      if (!snapShot.hasData) {
                        return error('Data messing!');
                      }
                      //++++++++\\\\++++++++

                      final String transactionID =
                          snapShot?.data['id'].toString();
                      final String statusCode =
                          snapShot?.data['code'].toString();

                      //*---------- Update Cartitems Order  to True -----
                      if (statusCode == "201")
                        _productsProvider.setIsCartItemsOrdred(true);
                      //*+++++++++++++++++++++++++++++++++++++++++++++++++

                      /*
                      final clientPhoneNumber = routes['clientPhoneNumber'] ??
                          'salim'; // From Map page :  arguments: {'clientPhoneNumber': phoneNumber});
                      print('clientPhoneNumber ::: $clientPhoneNumber');
                      */

                      //.........

                      return (statusCode == "422")
                          ? error2('Le numéro de téléphone saisi est invalide',
                              () {
                              print('goto home');
                              //Navigator.pushReplacementNamed(context, '/mapPage');
                              Navigator.of(context).pop();
                            })
                          : SingleChildScrollView(
                              child: Container(
                                  margin: const EdgeInsets.all(20),
                                  child: Column(
                                    children: [
                                      //.....
                                      Icon(
                                        JariIcons.check_circle,
                                        size: 48,
                                        color: AppColors.greenLight,
                                      ),

                                      //.....
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12),
                                        child: Text(
                                            'Commande envoyée avec success.'),
                                      ),
                                      Divider(
                                        color: AppColors.icongray,
                                        height: 4,
                                      ),
                                      Container(
                                        child: BodyText(
                                          text:
                                              "Votre commande a été enregistrée sous le numéro de transaction ",
                                          color: AppColors.darkblue4,
                                          fontSize: 16,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 20),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 8.0),
                                        decoration: BoxDecoration(
                                            color: AppColors.grey.withAlpha(50),
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        child: BodyText(
                                          text:
                                              "$transactionID".padLeft(10, '0'),
                                          color: AppColors.darkblue4,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w500,
                                          textAlign: TextAlign.center,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 20),
                                        decoration: BoxDecoration(
                                            color: AppColors.white,
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            boxShadow: [
                                              BoxShadow(
                                                color: AppColors.darkblue4
                                                    .withAlpha(20),
                                                blurRadius: 8,
                                                spreadRadius: 6,
                                              )
                                            ]),
                                        child: Column(
                                          children: [
                                            //.....
                                            Icon(
                                              JariIcons.info,
                                              size: 28,
                                              color: AppColors.lightblue4,
                                            ),

                                            //.....
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 16),
                                              child: Center(
                                                child: BodyText(
                                                  text:
                                                      "Vous receverez un appel du Livreur pour confirmer votre commande, merci de patienter.",
                                                  color: AppColors.darkblue4,
                                                  fontSize: 16,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                            Center(
                                              child: BodyText(
                                                text:
                                                    "Votre numéro de téléphone",
                                                color: AppColors.icongray,
                                                fontSize: 14,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Container(
                                              // padding: const EdgeInsets.symmetric(
                                              //     vertical: 16),
                                              child: Row(
                                                //...
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    JariIcons.phone,
                                                    color: AppColors.icongray,
                                                  ),
                                                  //...
                                                  SizedBox(
                                                    width: 20.0,
                                                  ),
                                                  //...
                                                  BodyText(
                                                    text:
                                                        "${widget.clientPhone}",
                                                    color: AppColors.pinck,
                                                    fontSize: 20,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                            );
                      //++++++++/////++++++

                    }
                }
                //++++++++++++
                return Container(
                  child: Center(child: Text('ERROR FETCHING PRODUCTS!')),
                );
                //+++++++++++++
              }),
        ),
      ),
    );
  }
}
