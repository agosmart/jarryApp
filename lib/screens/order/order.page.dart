import 'package:flutter/material.dart';
import 'package:jariapp/providers/order.dart';
import 'package:jariapp/themes/colors.dart';
import 'package:jariapp/utils/helpers.dart';
import 'package:jariapp/widgets/custom.appbar.dart';
import 'package:jariapp/widgets/title.text.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  // const OrderPage({Key key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  //----------------
  OrderProvider _orderProvider;
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

    //.......... INIT Products / category Provider ...............

    _orderProvider = Provider.of<OrderProvider>(context, listen: false);

    //.......... INIT FutureBuilder ...............
    _futureFetching = _orderProvider.fetchOrderAPI();
    //-------------
  }

  //+++++
  // @override
  // void dispose() {
  //   super.dispose();
  // }

  //+++++
  @override
  Widget build(BuildContext context) {
    //+++++++++++++++++ EXTRACT PARSSED PARAMETERS FROM MAP PAGE +++++++++++++++++
    // routes = ModalRoute.of(context).settings.arguments;

    //+++++++++++++++++++++++++++++++
    return Scaffold(
      //+++++
      backgroundColor: AppColors.canvaColor,
      //+++++
      appBar: AppBar(
        brightness: Brightness.light,

        // leading: null,
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
      body: SafeArea(
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

                    resultOrder = snapShot.data;
                    // final clientPhoneNumber = routes[ 'clientPhoneNumber']; // From Map page :  arguments: {'clientPhoneNumber': phoneNumber});
                    return (resultOrder == '422')
                        ? error2('Le numéro de téléphone saisi est invalide',
                            () {
                            print('goto home');
                            //Navigator.pushReplacementNamed(context, '/mapPage');
                            Navigator.of(context).pop();
                          })
                        : Center(
                            child: Column(
                            children: [
                              Text(' $resultOrder'),
                              Divider(
                                color: AppColors.icongray,
                                height: 4,
                              ),
                              Container(
                                padding: EdgeInsets.all(16),
                                child: BodyText(
                                  text:
                                      "Votre commande a été enregistrée. Vous receverez un appel du Livreur pour confirmer votre commande, merci de patienter.",
                                  color: AppColors.darkblue4,
                                  fontSize: 20,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ));
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
    );
  }
}
