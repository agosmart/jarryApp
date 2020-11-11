import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:jariapp/models/location.dart';
import 'package:jariapp/providers/map.dart';
import 'package:jariapp/screens/map/map.page.dart';
import 'package:jariapp/providers/exeptions/exeptions.dart';

import 'package:jariapp/themes/colors.dart';
import 'package:jariapp/utils/helpers.dart';
import 'package:jariapp/utils/jari_icons_v2.dart';
import 'package:jariapp/widgets/animations/custom.fade.translate.animation.dart';
import 'package:jariapp/widgets/custom.appbar.dart';
import 'package:jariapp/widgets/title.text.dart';
//-----
import 'package:provider/provider.dart';
//import 'package:jariapp/providers/location.local.dart';
import 'package:jariapp/providers/location.api.dart';

import 'package:geolocator/geolocator.dart';

class LocationPage extends StatefulWidget {
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  //++++++++++++++++++++++++++
  double h, w;
  List<StateArea> statesList;
  String _myStateId;
  List<CityArea> citiesList;
  String _myCityId;
  List<LocalityArea> localitiesList;
  String _myLocalityId;

  //+++++++++++++++++++++++++++++

  Future<List<StateArea>> _futureFetchingStates;
  Future<List<CityArea>> _futureFetchingCities;
  Future<List<LocalityArea>> _futureFetchingLocalities;

  LocationProvider _locationProvider;
  MapProvider _mapProvider;

  bool _dropdownButtonState = false;

  //++++++++++++++++++
  // For storing the current position
  Position _currentPosition;

  //++++++++++++++++++

  @override
  void initState() {
    super.initState();
    statesList = [];
    citiesList = [];
    localitiesList = [];
    //============================================
    _locationProvider = Provider.of<LocationProvider>(context, listen: false);
    _mapProvider = Provider.of<MapProvider>(context, listen: false);
    //============================================
    /*++++++---- GET LIST of STATE from API +++++++*/
    // _futureFetchingStates = _locationProvider.fetchStatesAreaAPI();
    //...............................................
    /*++++++---- GET LIST of STATE from LOCAL JSON  +++++++*/
    //  _futureFetchingStates = _locationProvider.fetchStatesAreaLocal();
    //+++++++++++++++ GET POSITION ++++++++++++++

    _getCurrentLocationClient();
    _futureFetchingStates = _locationProvider.fetchStatesAreaLocal();
  }

  // getPosition() async {
  //   return position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);
  // }

  // Method for retrieving the current location
  _getCurrentLocationClient() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      // print('CURRENT POS: $_currentPosition');
      if (mounted) {
        _currentPosition = position;
      }
      print('CURRENT POS: $_currentPosition');

      final _lat = _mapProvider?.latitudeClient;
      final _lon = _mapProvider?.longitudeClient;

      await _isLocationEnabled();

      if (_dropdownButtonState) {
        if (_lat == null || _lon == null) {
          _mapProvider.setLatitudeClient(_currentPosition.latitude);
          _mapProvider.setLongitudeClient(_currentPosition.longitude);
        }
      }
      //++++++++++++++++++++++++++++++
    });
  }

  _isLocationEnabled() {
    print('CURRENT POS + _hideDropdownButton : $_currentPosition');
    //------------------------CHeck position ----------------------------
    _dropdownButtonState = (_currentPosition?.latitude != null ||
            _currentPosition?.longitude != null)
        ? true
        : false;
  }

  Function refreshData() {
    //_futureFetchingCat = _categoryProvider.fetchCategoriesAPI();

    Navigator.popAndPushNamed(context, '/locationPage');
  }

  //===================================

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
        //++++++++++++++++++++++++++++++
        child: SingleChildScrollView(
          //++++++++
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Icon(
                    JariIcons.map_pin,
                    color: AppColors.icongray,
                    size: 32,
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.topCenter,
                      margin: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      child: Text(
                        'Informations relatives à votre adresse de livraison',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 21,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              /*
              Container(
                alignment: Alignment.topCenter,
                margin:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Text(
                  'POSITIONS :::: ${_currentPosition?.latitude} / ${_currentPosition?.longitude} ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 24,
                  ),
                ),
              ),
              */

              //++++++++++++++++++++++++++++++++++++++++++++++++++++++

              //................. STATE................................

              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                color: AppColors.darkblue4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: FutureBuilder(
                        //----------------------------------
                        future: _futureFetchingStates,
                        //----------------------------------
                        //_orderProvider.fetchtNotTraitedOrders(idUser: 1),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<StateArea>> snapShot) {
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

                                statesList = [...snapShot.data];
                                //++++++++++++++++++++++++++++++++++++++

                                // _getCurrentLocationClient();
                                // Container(
                                //     padding: const EdgeInsets.all(8.0),
                                //     // color: AppColors.red,
                                //     child: TitleText(
                                //       text:
                                //           "Veuillez activer la localisation de l'appareil pour continuer",
                                //       color: AppColors.white,
                                //       fontSize: 16,
                                //       textAlign: TextAlign.center,
                                //     ),
                                //   )
                                return !_dropdownButtonState
                                    ? error2(
                                        "Veuillez activer la localisation de l'appareil pour continuer",
                                        refreshData,
                                      )
                                    //+++++++++++++++++++++++++++++++++++++++
                                    // print('statesList:::: $statesList');
                                    //----Build DropdownMenu
                                    : DropdownButtonHideUnderline(
                                        child: ButtonTheme(
                                          alignedDropdown: true,
                                          child: DropdownButton<String>(
                                            //................
                                            value: _myStateId ?? null,

                                            // ??  _locationProvider.getcurrentStateID,
                                            // value: _locationProvider.getcurrentStateArea,
                                            //.................

                                            iconSize: 30,
                                            dropdownColor: AppColors.darkblue4,
                                            iconEnabledColor: AppColors.white,
                                            icon: (null),
                                            //isDense: true,
                                            style: TextStyle(
                                              color: AppColors.white,
                                              fontSize: 18,
                                            ),
                                            hint: Text(
                                                'Séléctionner votre Wilaya',
                                                style: TextStyle(
                                                    color: AppColors.white)),
                                            onChanged: (String id) {
                                              print('NEW STATE NAME ===  $id');

                                              //......SET STATE ID ..........
                                              _locationProvider
                                                  .setCurrentStateID(id);
                                              //......SET STATE NAME ..........
                                              _locationProvider
                                                  .setCurrentStateName(id);
                                              //......................*/
                                              setState(() {
                                                _myStateId = id;
                                                _myCityId = null;

                                                citiesList = [];
                                                _myLocalityId = null;

                                                //++++ HIDE BTN SUBMIT +++++
                                                localitiesList = [];

                                                // _getCitiesList();
                                                print(
                                                    '_myStateId : $_myStateId');
                                              });
                                              //......... GET LIST of CITIES from API ..........

                                              _futureFetchingCities =
                                                  _locationProvider
                                                      .fetchCitiesAreaAPI();
                                              //..................................
                                            },
                                            /*
                                      items: [
                                            {"id": 1, "wilayaName": "Adrar"},
                                            {"id": 2, "wilayaName": "Chlef "},
                                            {"id": 3, "wilayaName": "Laghouat"}
                                          ].map(
                                            (item) {
                                              return DropdownMenuItem(
                                                child:
                                                    Text(item['wilayaName'] ?? ''),
                                                value: item['id'].toString() ?? '',
                                              );
                                            },
                                          ).toList() ??
                                          [],
                                        */

                                            items: statesList
                                                    ?.map((StateArea item) {
                                                  return DropdownMenuItem(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        //......
                                                        CircleAvatar(
                                                          backgroundColor:
                                                              AppColors.black
                                                                  .withAlpha(
                                                                      50),
                                                          child: Text(
                                                            item.id
                                                                .toString()
                                                                .padRight(
                                                                    2, '0'),
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .white,
                                                                fontSize: 18),
                                                          ),
                                                        ),
                                                        //......
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10.0),
                                                          child: Text(
                                                              item.stateName ??
                                                                  'Wilaya'),
                                                        ),
                                                      ],
                                                    ),

                                                    //
                                                    value: item.id.toString(),
                                                  );
                                                })?.toList() ??
                                                [],
                                          ),
                                        ),
                                      );
                                //++++++++++ End DROPDOWn MENU
                              }
                          }
                          return error('Data messing occured!');
                        },
                      ),

                      //.........................................
                    ),

                    //.......................
                  ],
                ),
              ),
              //++++++++++++++++++++++++++++++++++++++++++++++++++++++++
              SizedBox(
                height: 30,
              ),
              //++++++++++++++++++++++++++++++++++++++++++++++++++++++++
              //..................  CITY ................................
              statesList.length <= 0
                  ? Center()
                  : Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      color: AppColors.pinck,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: FutureBuilder(
                              //----------------------------------
                              future: _futureFetchingCities,
                              //----------------------------------
                              //_orderProvider.fetchtNotTraitedOrders(idUser: 1),
                              builder: (BuildContext context,
                                  AsyncSnapshot<List<CityArea>> snapShot) {
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
                                      citiesList = [...snapShot.data];
                                      // print('statesList:::: $statesList');

                                      //----Build DropdownMenu
                                      return DropdownButtonHideUnderline(
                                        child: ButtonTheme(
                                          alignedDropdown: true,
                                          child: DropdownButton<String>(
                                            //................
                                            value: _myCityId ?? null,
                                            //  ?? _locationProvider.getcurrentCityID,
                                            // value: _locationProvider.getcurrentStateArea,
                                            //.................

                                            iconSize: 30,
                                            dropdownColor: AppColors.pinck,
                                            iconEnabledColor: AppColors.white,
                                            icon: (null),
                                            //  isDense: true,
                                            style: TextStyle(
                                              color: AppColors.white,
                                              fontSize: 16,
                                            ),

                                            hint: Text(
                                              'Séléctionner votre Daîra',
                                              style: TextStyle(
                                                  color: AppColors.white),
                                            ),
                                            onChanged: (String id) {
                                              print('NEW CITY NAME ===  $id');

                                              //......SET STATE ID ..........
                                              _locationProvider
                                                  .setCurrentCityID(id);
                                              //......SET STATE NAME ..........
                                              _locationProvider
                                                  .setCurrentCityName(id);
                                              //......................*/
                                              setState(() {
                                                _myCityId = id;
                                                _myLocalityId = null;

                                                //++++ HIDE BTN SUBMIT +++++
                                                localitiesList = [];
                                                // _myStateId = null;
                                                print('_myCityId : $_myCityId');
                                              });

                                              //........... GET LIST of LOCALITIES from API .....

                                              _futureFetchingLocalities =
                                                  _locationProvider
                                                      .fetchLocalitiesAreaAPI();
                                              //..................................
                                            },

                                            items: citiesList
                                                    ?.map((CityArea item) {
                                                  return DropdownMenuItem(
                                                    child: Text(item.cityName ??
                                                        'Empty Daira Name'),
                                                    value: item.id.toString(),
                                                  );
                                                })?.toList() ??
                                                [],
                                          ),
                                        ),
                                      );

                                      //++++++++++ End DROPDOWn MENU
                                    }
                                }
                                return error('Data messing occured!');
                              },
                            ),
                          )
                        ],
                      ),
                    ),

              //++++++++++++++++++++++++++++++++++++++++++++++++++++++
              SizedBox(
                height: 30,
              ),
              //++++++++++++++++++++++++++++++++++++++++++++++++++++++
              //................ LOCALITY ............................
              citiesList.length <= 0
                  ? Center()
                  : Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      color: AppColors.lightGrey,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: FutureBuilder(
                              //----------------------------------
                              future: _futureFetchingLocalities,
                              //----------------------------------
                              //_orderProvider.fetchtNotTraitedOrders(idUser: 1),
                              builder: (BuildContext context,
                                  AsyncSnapshot<List<LocalityArea>> snapShot) {
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
                                      localitiesList = [...snapShot.data];
                                      // print('statesList:::: $statesList');

                                      //----Build DropdownMenu
                                      return DropdownButtonHideUnderline(
                                        child: ButtonTheme(
                                          alignedDropdown: true,
                                          child: DropdownButton<String>(
                                            //................
                                            value: _myLocalityId ?? null,
                                            // ??  _locationProvider.getcurrentLocalityID,
                                            // value: _locationProvider.getcurrentStateArea,
                                            //.................
                                            // iconSize: 30,
                                            // icon: (null),
                                            // style: TextStyle(
                                            //   color: Colors.black54,
                                            //   fontSize: 16,
                                            // ),

                                            iconSize: 30,
                                            dropdownColor: AppColors.lightGrey,
                                            iconEnabledColor:
                                                AppColors.icongray,
                                            icon: (null),
                                            //   isDense: true,

                                            style: TextStyle(
                                              color: AppColors.black,
                                              fontSize: 16,
                                            ),
                                            hint: Text(
                                              'Séléctionner votre Commune',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: AppColors.black,
                                                fontSize: 16,
                                              ),
                                            ),
                                            onChanged: (String id) {
                                              print(
                                                  'NEW LOCALITY NAME ===  $id');

                                              //......SET STATE ID ..........
                                              _locationProvider
                                                  .setCurrentLocalityID(id);
                                              //......SET STATE NAME ..........
                                              _locationProvider
                                                  .setCurrentLocalityName(id);
                                              //......................*/
                                              setState(() {
                                                _myLocalityId = id;
                                                // _myCityId = null;
                                                // _myStateId = null;
                                                print(
                                                    '_myLocalityId : $_myLocalityId');
                                              });
                                            },

                                            items: localitiesList
                                                    ?.map((LocalityArea item) {
                                                  return DropdownMenuItem(
                                                    child: Text(item
                                                            .localityName ??
                                                        'Empty Commune Name'),
                                                    value: item.id.toString(),
                                                  );
                                                })?.toList() ??
                                                [],
                                          ),
                                        ),
                                      );

                                      //++++++++++ End DROPDOWn MENU
                                    }
                                }
                                return error('Data messing occured!');
                              },
                            ),
                          )
                        ],
                      ),
                    ),
              //+++++++++++++++++++++++++++++++++++++++++++++++++++++++

              //........... MESSAGE ERROR LOCALISATION ..............

              localitiesList.length <= 0
                  ? Center()
                  : _locationProvider.getcurrentLocalityName != null
                      ? _submitButtonGetDelivers(context)
                      : Center(child: Text('choisir une commune')),

              //++++++++++++++++ END ++++++++++++++++
            ],
          ),
        ),
      ),
    );
  }

  //+++++++++++++++++ SUBMIT BUTTON +++++++++++++++++++++++

  Widget _submitButtonGetDelivers(BuildContext context) {
//"Veuillez activer la localisation de l'appareil pour continuer"
    //_getCurrentLocationClient();
    print('MOHAMED:::::::::::: $_currentPosition');

//::::::::: BUTTON CONFIRME/ CANCEL:::::::::::::::::
    return CustomFadeTranslateAnimation(
      begin: 100,
      delay: 300,
      duration: 900,
      widthContent: w,
      heightContent: h * 1 / 5,
      childContent: Container(
        //color: Colors.red,
        child: Align(
          alignment: Alignment.center,
          child: Container(
            width: w - (w / 10),
            height: 60,
            child: RaisedButton(
              //........
              onPressed: () {
                //*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

                final localityName = _locationProvider.getcurrentLocalityName;
                // final localityID = _locationProvider.getcurrentLocalityID;

                //*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                print('localityName >>>>>> $localityName');
                //..
                //-------------------------------------------------

                Navigator.pushNamed(context, '/mapPage');

                //-------------------------------------------------
                /*
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    //-------------------------------------------------
                    builder: (BuildContext context) {
                      return MapPage();
                    },
                    //  fullscreenDialog: true,

                    //--------------------------------------------------
                  ),
                );
                */
                //..
              },
              //*+++++++++++++++...................++++++++++++++
              color: AppColors.darkblue4,
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
                    text: 'Confirmer la commande',
                    color: AppColors.gold,
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
