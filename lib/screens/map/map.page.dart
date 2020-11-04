import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jariapp/models/deliver.dart';
import 'package:jariapp/providers/location.api.dart';

import 'package:jariapp/providers/map.dart';
import 'package:jariapp/themes/colors.dart';

import 'package:jariapp/utils/jari_icons_v2.dart';
import 'package:jariapp/utils/helpers.dart';
import 'package:jariapp/widgets/custom.appbar.dart';
import 'package:jariapp/widgets/title.text.dart';
import 'package:provider/provider.dart';

class MapPage extends StatefulWidget {
  MapPage({Key key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  //+++++
  double h, w;
  List<Deliver> deliversList;
  String _localityID;
  //............

  GoogleMapController mapController;
  //++++

  Future<List<Deliver>> _futureFetchingDelivers;
  MapProvider _mapProvider;
  LocationProvider _localityProvider;

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //......

    deliversList = [];

    _mapProvider = Provider.of<MapProvider>(context, listen: false);

    //.............GET PROVIDER LOCATION   .................................
    _localityProvider = Provider.of<LocationProvider>(context, listen: false);
    //......................................................................
    //.............GET CURRENT LOCALITY ID .................................

    _localityID = _localityProvider.getcurrentLocalityID;
    print('MAP => _localityID ::: $_localityID');
    _futureFetchingDelivers =
        _mapProvider.fetchDeliversDatasAPI(localityId: _localityID);

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

  //............
  @override
  Widget build(BuildContext context) {
    //++++
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    //+++++
    return SafeArea(
      maintainBottomViewPadding: true,
      child: Scaffold(
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
          builder:
              (BuildContext context, AsyncSnapshot<List<Deliver>> snapShot) {
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
                          infoWindow:
                              InfoWindow(title: 'tInformation livreur $id '),
                          //............
                          onTap: () {
                            //++++++++++++++++++++++++
                            print('Marker Tapped');

                            return showModalBottomSheet(
                              backgroundColor: AppColors.transparent,
                              elevation: 0.0,
                              // isDismissible: true,
                              // enableDrag: true,
                              // clipBehavior: Clip.hardEdge,
                              context: (context),
                              builder: ((builder) {
                                return Container(
                                  // height: h,
                                  width: w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(40),
                                        topRight: Radius.circular(40)),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      //.....
                                      Container(
                                        height: 80,
                                        width: w,
                                        decoration: BoxDecoration(
                                          color: AppColors.darkblue4,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(42),
                                            topRight: Radius.circular(42),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            //. . . . .
                                            Icon(
                                              JariIcons.user_check,
                                              color: AppColors.gold,
                                            ),
                                            //. . . . .
                                            SizedBox(width: 16.0),
                                            //. . . . .
                                            TitleText(
                                              color: AppColors.white,
                                              fontSize: 21.0,
                                              uppercase: false,
                                              fontWeight: FontWeight.w400,
                                              textAlign: TextAlign.center,
                                              text: 'Informations livreur ',
                                            ),
                                            //. . . . .
                                            SizedBox(width: 16.0),
                                            //. . . . .
                                            Container(
                                              child: CircleAvatar(
                                                backgroundColor: AppColors.black
                                                    .withOpacity(0.5),
                                                child: TitleText(
                                                  color: AppColors.white,
                                                  fontSize: 18.0,
                                                  uppercase: false,
                                                  fontWeight: FontWeight.w400,
                                                  textAlign: TextAlign.center,
                                                  text: '$id',
                                                ),
                                              ),
                                            )
                                            //. . . . .
                                          ],
                                        ),
                                      ),
                                      //. . . . .

                                      Container(
                                        color: AppColors.white,
                                        padding: const EdgeInsets.all(20),
                                        //. . . . .

                                        child: Column(
                                          children: [
                                            //. . . . .
                                            TitleText(
                                              color: AppColors.black,
                                              fontSize: 16.0,
                                              uppercase: true,
                                              textAlign: TextAlign.center,
                                              fontWeight: FontWeight.w600,
                                              text:
                                                  ' Saisissez votre numéro de Téléphone',
                                            ),
                                            //. . . . .
                                            SizedBox(
                                              height: 16.0,
                                            ),
                                            //. . . . .

                                            TextField(
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16.0),
                                                  borderSide: BorderSide(
                                                    color: AppColors.darkblue4,
                                                  ),
                                                ),
                                                fillColor: AppColors.lightGrey,
                                                //   border: InputBorder.none,
                                                hintText: 'Votre numéro',
                                                filled: true,
                                                labelText:
                                                    'Votre numéro de téléphone',
                                                labelStyle: TextStyle(
                                                  color: AppColors.darkblue3,
                                                ),
                                                hintStyle: TextStyle(
                                                  fontSize: 24,
                                                ),
                                              ),
                                              keyboardType: TextInputType.phone,
                                            ),

                                            //. . . . .
                                          ],
                                        ),
                                      ),
                                      //. . . . .
                                      Expanded(
                                        child: Container(
                                          // width: w,
                                          color: AppColors.white,

                                          //+++++
                                          //+++++
                                          child: ListView(
                                            children: [
                                              ListTile(
                                                leading: Icon(Icons
                                                    .supervised_user_circle),
                                                title: TitleText(
                                                  color: AppColors.lightblue3,
                                                  fontSize: 18.0,
                                                  uppercase: false,
                                                  fontWeight: FontWeight.w400,
                                                  text: '$fullName',
                                                ),
                                              ),

                                              //. . . . .
                                              phone_1 == ''
                                                  ? Center()
                                                  : ListTile(
                                                      leading: Icon(Icons.call),
                                                      title: TitleText(
                                                        color: AppColors
                                                            .lightblue3,
                                                        fontSize: 18.0,
                                                        uppercase: false,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        text: '$phone_1',
                                                      ),
                                                    ),

                                              //. . . . .
                                              phone_2 == ''
                                                  ? Center()
                                                  : ListTile(
                                                      leading: Icon(Icons.call),
                                                      title: TitleText(
                                                        color: AppColors
                                                            .lightblue3,
                                                        fontSize: 18.0,
                                                        uppercase: false,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        text: '$phone_2',
                                                      ),
                                                    ),

                                              //. . . . .

                                              SizedBox(width: 20.0),
                                            ],
                                          ),
                                          //+++++
                                          //+++++
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            );

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
                                  child:
                                      Icon(Icons.refresh, color: Colors.white),
                                ),
                              ),
                            )
                            //..........................................
                          ],
                        );
                  //+++++
                }
            }
            return error('Data messing occured!');
          },
        ),
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
  //.....
  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  // }

  //.....
}
