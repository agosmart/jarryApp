import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:jariapp/models/cart.item.dart';

import 'package:jariapp/models/deliver.dart';
import 'package:jariapp/providers/location.api.dart';

import 'package:jariapp/providers/map.dart';
import 'package:jariapp/providers/order.dart';
import 'package:jariapp/providers/products.dart';
import 'package:jariapp/themes/colors.dart';

import 'package:jariapp/utils/jari_icons_v2.dart';
import 'package:jariapp/utils/helpers.dart';
import 'package:jariapp/widgets/custom.appbar.dart';
import 'package:jariapp/widgets/title.text.dart';
import 'package:provider/provider.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapPage extends StatefulWidget {
  MapPage({Key key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  //+++++
  double h, w;
  List<Deliver> deliversList;
  List<CartItem> _cartItems;
  String _localityID;
  String _phoneNumber = '';

  TextEditingController _phoneNumberController;
  //++++++++++++++++++
  // For storing the current position
  //Position _currentPosition;

  //++++++++++++++++++

  GoogleMapController mapController;
  //++++

  Future<List<Deliver>> _futureFetchingDelivers;
  //------- PROVIDERS ---------
  MapProvider _mapProvider;
  ProductsProvider _productsProvider;
  LocationProvider _localityProvider;
  OrderProvider _orderProvider;

  // initMarker(client) {
  //   mapController.clearMarkers().then((val) {
  //     mapController.addMarker(MarkerOptions(
  //         position:
  //             LatLng(client['location'].latitude, client['location'].longitude),
  //         draggable: false,
  //         infoWindowText: InfoWindowText(client['clientName'], 'Nice')));
  //   });
  // }

  // void onMapCreated(controller) {
  //   setState(() {
  //     mapController = controller;
  //   });
  // }
  List<Marker> allMarkers = [];
  LatLng positionInit;
  GoogleMapController _controller;

  Map<String, dynamic> _orderDetails;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //......

    _phoneNumberController = TextEditingController();
    deliversList = [];

    //.............GET PROVIDER PRODUCTS   .................................
    _productsProvider = Provider.of<ProductsProvider>(context, listen: false);
    //.............GET PROVIDER LOCATION   .................................
    _localityProvider = Provider.of<LocationProvider>(context, listen: false);
    //.............GET PROVIDER MAP   .................................
    _mapProvider = Provider.of<MapProvider>(context, listen: false);
    //.............GET PROVIDER OREDER   .................................
    _orderProvider = Provider.of<OrderProvider>(context, listen: false);

    //.............GET CURRENT LOCALITY ID .................................

    _localityID = _localityProvider.getcurrentLocalityID;
    _cartItems = _productsProvider.getCartItems;
    //......................................................................
    /*print('MAP => _localityID ::: $_localityID');
    print('ORDER => _productsProvider ::: $_cartItems');

    _futureFetchingDelivers = _mapProvider.fetchDeliversDatasAPI(
        localityId: _localityID, cartItems: _cartItems);*/

    //+++++++++++++++++ orderDetails ==  body +++++++++++++++++++++++

    _orderDetails = {
      'latitude': _mapProvider?.latitudeClient.toString(),
      'longitude': _mapProvider?.longitudeClient.toString(),
      'order': _cartItems.map((CartItem item) {
        return {
          "productId": item.productId.toString(),
          "quantity": item.qty.toString(),
          "unitPrice": item.priceUnit.toString()
        };
      }).toList()
    };

    //+++++++++++++++++ display Delivers +++++++++++++++++++++++
    _futureFetchingDelivers = _mapProvider.fetchDeliversDatasAPI(
        localityId: _localityID, orderDetails: _orderDetails);
    //+++++++++++++++++++++++++++++++++++++++++
    //+++++++++++++++++++++
    //_getCurrentLocation();
    //+++++++++++++++++++++
    /*
    _futureFetchingDelivers = _mapProvider.fetchDeliversDatasLocal();
 */
    //......
    // allMarkers.add(
    //   Marker(
    //     markerId: MarkerId('myMarker'),
    //     draggable: true,
    //     onTap: () {
    //       print('Marker Tapped');
    //     },
    //     position: LatLng(40.7128, -74.0060),
    //   ),
    // );
  }

  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }

  // getPhoneValues() {
  //   print(_phoneNumberController.text);
  // }
  //...........................................
  // Method for retrieving the current location
/*
  _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      // print('CURRENT POS: $_currentPosition');
      setState(() {
        _currentPosition = position;
        // Store the position in the variable
      });
    });

    //print('moh:::${_currentPosition.altitude}');
  }*/
  //...........................................

  @override
  Widget build(BuildContext context) {
    //++++
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;

    //+++++
    return Scaffold(
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
        //  actions: <Widget>[CustomAppBar.builsActionIconsClear()],
        // toolbarHeight: 80.0,
      ),
      body:
          //.....

          FutureBuilder(
        //----------------------------------
        future: _futureFetchingDelivers,
        //----------------------------------
        //_orderProvider.fetchtNotTraitedOrders(idUser: 1),
        builder: (BuildContext context, AsyncSnapshot<List<Deliver>> snapShot) {
          switch (snapShot.connectionState) {
            case ConnectionState.none:
              // return Text('nothing happend !!!');
              return error('No connexion made!');
              break;
            case ConnectionState.waiting:
            case ConnectionState.active:
              //return Center();
              return loading(AppColors.akablueLight);
              break;
            case ConnectionState.done:
              //-----
              if (snapShot.hasError) {
                return error(snapShot.error.toString());
              } else {
                if (!snapShot.hasData) {
                  //----Build Erreur

                  return Center(
                    child: Text("hasn't data"),
                  );
                }

                deliversList = [...snapShot.data];

                if (deliversList.length > 0) {
                  //...... POSITION CAMERA INITIAL ....
                  positionInit = LatLng(
                    deliversList[0].latitude,
                    deliversList[0].longitude,
                  );
                  //...........

                  deliversList.map((deliver) {
                    int id = deliver.deliverId;
                    String lastName = deliver.lastName;
                    String firstName = deliver.firstName;
                    String fullName = '$lastName $firstName';
                    double lat = deliver.latitude;
                    double lnt = deliver.longitude;
                    String phone_1 = deliver?.phone1 ?? '';
                    String phone_2 = deliver?.phone2 ?? '';

                    allMarkers.add(
                      Marker(
                        markerId: MarkerId('myMarker-$id'),
                        draggable: true,
                        // infoWindow:
                        //     InfoWindow(title: 'tInformation livreur $id '),
                        //............
                        onTap: () {
                          //++++++++++++++++++++++++
                          print('Marker Tapped');

                          showDeliverInfoOrder(
                              id: id,
                              fullName: fullName,
                              phone_1: phone_1,
                              phone_2: phone_2);

                          //++++++++++++++++++++++++
                        },
                        position: LatLng(lat, lnt),
                      ),
                    );
                  }).toList();

                  /* allMarkers.add(
                    Marker(
                      markerId: MarkerId('myMarker'),
                      draggable: true,
                      onTap: () {
                        print('Marker Tapped');
                      },
                      position: LatLng(40.7128, -74.0060),
                    ),
                  );*/
                }

                // deliversList = [];

                //+++++
                return deliversList.length <= 0
                    ? Container(
                        //......................................
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
                            Padding(
                              padding: const EdgeInsets.all(24),
                              child: TitleText(
                                color: AppColors.darkgrey,
                                fontSize: 24.0,
                                uppercase: false,
                                fontWeight: FontWeight.w400,
                                textAlign: TextAlign.center,
                                text:
                                    'Désolé! Aucun livreur n\'active dans votre région.',
                              ),
                            ),
                            //++++++++ EMPTY SPACE ++++
                            SizedBox(
                              height: h / 4,
                            )
                          ],
                        ),
                      )
                    : Stack(
                        //......................................
                        children: <Widget>[
                          //......
                          Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: GoogleMap(
                              initialCameraPosition: CameraPosition(
                                  target:
                                      positionInit, // LatLng(40.7128, -74.0060),
                                  zoom: 14.0),
                              markers: Set.from(allMarkers),
                              //+++++++++++++++++++++++++++++
                              onMapCreated: mapCreated,
                              //+++++++++++++++++++++++++++++
                            ),
                          ),

                          Positioned(
                            bottom: 20,
                            left: 20,
                            // alignment: Alignment.bottomRight,
                            child: InkWell(
                              onTap: movetoNewYork,
                              splashColor: AppColors.akablueLight,
                              child: Container(
                                height: 48.0,
                                width: 48.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24.0),
                                    color: AppColors.darkblue4),
                                child: Icon(Icons.refresh, color: Colors.white),
                              ),
                            ),
                          ),
                          //..........................................

                          //......

                          Positioned(
                            top: 20,
                            left: 0,
                            child: Container(
                              width: w,
                              height: 42.0,
                              color: AppColors.white,
                              alignment: Alignment.center,
                              child: Text(
                                'POSITIONS :::: ${_mapProvider?.latitudeClient} / ${_mapProvider?.longitudeClient} ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                //+++++
              }
          }
          return error('Data messing occured!');
        },
      ),
    );
  }

  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }

  movetoNewYork() {
    _controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: positionInit, zoom: 12.0),
    ));
  }

  showDeliverInfoOrder(
      {int id, String fullName, String phone_1, String phone_2}) {
    final _deliverID = id;
    //. . . . .
    print('SHOW DIALOGUE INFOS');
    //. . . . .

    final _formKey = GlobalKey<FormState>();

    Widget infoDeliverForm = Container(
      color: Colors.white,
      // height: h / 2,
      //- - - - - - - - - - - - - - - -  START FORM - - - - - - - - - - - -
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              color: AppColors.darkblue4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //. . . . .
                  Icon(
                    JariIcons.user_check,
                    color: AppColors.gold,
                  ),
                  //. . . . .
                  SizedBox(width: 18.0),
                  //. . . . .
                  TitleText(
                    color: AppColors.white,
                    fontSize: 18.0,
                    uppercase: true,
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.center,
                    text: 'Informations livreur ',
                  ),
                  //. . . . .
                  SizedBox(width: 16.0),
                  //. . . . .
                  Container(
                    child: CircleAvatar(
                      backgroundColor: AppColors.white.withOpacity(0.15),
                      child: TitleText(
                        color: AppColors.white,
                        fontSize: 16.0,
                        uppercase: false,
                        fontWeight: FontWeight.w400,
                        textAlign: TextAlign.center,
                        text: '$id',
                      ),
                    ),
                  ),
                  //. . . . .
                ],
              ),
            ),
            //. . . . . . . . . . . . .
            SizedBox(height: 21.0),
            //. . . . . . . . . . . . . .  . .
            TextFormField(
              controller: _phoneNumberController,
              autocorrect: false,
              autofocus: true,
              keyboardType: TextInputType.phone,
              //+++++++++++++++++++++++++++
              onChanged: (String value) {
                // if (value.isEmpty) return " Champ vide";
                // if (value.length > 10 || value.length < 10)
                //   return "Numéro de téléphone invalide";

                _phoneNumber = value;
              },

              validator: (value) {
                if (value.isEmpty || value.length > 10 || value.length < 9) {
                  return 'Veuillez entrer un numéro de téléphone valide';
                }
                return null;
              },
              //+++++++++++++++++++++++++++
              inputFormatters: [
                // FilteringTextInputFormatter.deny(RegExp(r'[0-6]')),
                // FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                // FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                //FilteringTextInputFormatter.deny(RegExp('[abFeG]')),
                FilteringTextInputFormatter.digitsOnly,
              ],
              style: TextStyle(color: AppColors.darkblue4, fontSize: 32.0),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    color: AppColors.icongray,
                  ),
                ),
                hintText: 'Saisissez votre numéro de Téléphone',
                hintStyle: TextStyle(fontSize: 18, color: AppColors.icongray),
                errorStyle: TextStyle(color: AppColors.pinck, fontSize: 18),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.pinck, width: 2.0)),
                labelText: 'Votre numéro de téléphone',
                labelStyle: TextStyle(color: AppColors.darkblue3, fontSize: 18),
              ),
            ),

            //. . . . . . . . . . . . .
            SizedBox(height: 21.0),
            //. . . . . . . . . . . . . .
            infoList(fullName, phone_1, phone_2),
            //. . . . . . . . . . . . . . .
          ],
        ),
        //- - - - - - - - - - - - - - - -  END FORM - - - - - - - - - - - - - -
      ),
    );

    //. . . . .

    return showDialog(
      barrierColor: AppColors.darkblue4.withOpacity(0.35),
      context: context,
      useSafeArea: false,
      builder: (context) => AlertDialog(
        insetPadding: EdgeInsets.all(8),
        //-------------------------------------
        title: infoDeliverForm, //Text('Êtes-vous sûr de vouloir quitter ?'),
        //-----------------------------------
        actions: <Widget>[
          Container(
            alignment: Alignment.center,
            width: (w / 2) - 20,
            // color: AppColors.black,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: AppColors.pinck,
                  onPrimary: Colors.white,
                  onSurface: Colors.white,
                ),
                child: Text(
                  'Annuler',
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  _formKey.currentState.reset();
                  //_phoneNumberController.text = '';
                  Navigator.of(context).pop();
                  // Navigator.of(context).popUntil(ModalRoute.withName('/home'));
                  //.....................................
                }),
          ),
          //........

          Container(
            alignment: Alignment.center,
            width: (w / 2) - 20,
            //-----------
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: AppColors.darkblue4,
                onPrimary: Colors.white,
                onSurface: Colors.white,
              ),
              child: Text(
                'Envoyer',
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () async {
                //----------------------------------
                // final latClient = _currentPosition?.latitude;
                // final lntClient = _currentPosition?.longitude;

                if (_formKey.currentState.validate()) {
                  print('phoneNumber === $_phoneNumber');

                  //..... Store Order details .........

                  /*
                  _orderDetails = {
                    'latitude': _mapProvider?.latitudeClient.toString(),
                    'longitude': _mapProvider?.longitudeClient.toString(),
                    'order': _cartItems.map((CartItem item) {
                      return {
                        "productId": item.productId.toString(),
                        "quantity": item.qty.toString(),
                        "unitPrice": item.priceUnit.toString()
                      };
                    }).toList()
                  };

                   //--- data to join -------
                  "clientMobile" : "0560222222",
                  "livreurId" : "1",
                  "stateOrder" : "2",
                  "communeId" : "558",
                  
                  */

                  //Map<String, dynamic> orderDetailsEnd;

                  _orderDetails.remove('latitude');
                  _orderDetails.remove('longitude');

                  _orderDetails["clientMobile"] = _phoneNumber;
                  _orderDetails["livreurId"] = _deliverID.toString();
                  _orderDetails["stateOrder"] = "2";
                  _orderDetails["communeId"] = _localityID;

                  //++++++++++++++++++++++++

                  await _orderProvider.setOrderDetailsEnd(_orderDetails);

                  //++++++++++++++++++++++++

                  _formKey.currentState.reset();

                  Navigator.pushReplacementNamed(context, '/orderPage');

                  //  Navigator.pushReplacementNamed(context, '/orderPage',arguments: {'clientPhoneNumber': phoneNumber});
                }
                //.....................................

                // getPhoneValues();

                //--------------------------------------
                // print( 'CURRENT POS MAP: $latClient / $lntClient / phoneNum $phoneNum');

                /*
                if (!phoneNum.isEmpty && phoneNum.length > 0) {
                  _phoneNumberController.clear();
                  //Navigator.pushReplacementNamed(context, '/orderPage');
                } else {
                  _phoneNumberController.clear();
                  print('Le numéro de téléphone est requis');
                }*/
              },
            ),
          ),
        ],
      ),
    );

    //. . . . .
  }

  infoList(fullName, phone_1, phone_2) {
    return Container(
      // width: w,
      //height: 150,
      //height: double.minPositive,

      //+++++
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                //....
                Icon(JariIcons.user),
                //....
                TitleText(
                  color: AppColors.lightblue3,
                  fontSize: 18.0,
                  uppercase: false,
                  fontWeight: FontWeight.w400,
                  text: '  $fullName',
                )
                //....
              ]),
            ),

            //. . . . .

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  phone_1 == '' || phone_1 == null
                      ? Center()
                      : Icon(JariIcons.phone),
                  TitleText(
                    color: AppColors.lightblue3,
                    fontSize: 18.0,
                    uppercase: false,
                    fontWeight: FontWeight.w400,
                    text: '  $phone_1',
                  ),
                  phone_2 == '' || phone_2 == null
                      ? Center()
                      : TitleText(
                          color: AppColors.lightblue3,
                          fontSize: 18.0,
                          uppercase: false,
                          fontWeight: FontWeight.w400,
                          text: '  |  $phone_2',
                        ),
                ],
              ),
            ),

            //. . . . .

            // SizedBox(width: 20.0),
          ],
        ),
      ),
      //+++++
      //+++++
    );
  }

  //.....
  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  // }

  //.....
}
