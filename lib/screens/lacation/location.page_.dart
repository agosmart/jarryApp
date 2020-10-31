import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:jariapp/themes/colors.dart';
import 'package:jariapp/utils/helpers.dart';

class LocationPage extends StatefulWidget {
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  List<dynamic> statesList;
  String _myState;
  //+++++++++++++++
  Future _futureFetchingState;
  //+++++++++++++++++
  @override
  void initState() {
    _futureFetchingState = _getStateListLocal(); // _getStateList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dynamic DropDownList REST API'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(bottom: 100, top: 100),
            child: Text(
              'KDTechs',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
            ),
          ),
          //======================================================== State

          Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 5),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: FutureBuilder(
                    //----------------------------------
                    future: _futureFetchingState,
                    //----------------------------------
                    //_orderProvider.fetchtNotTraitedOrders(idUser: 1),
                    builder: (BuildContext context, AsyncSnapshot snapShot) {
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
                                child: Text("There is not data"),
                              );
                            }

                            statesList = [...snapShot.data];

                            print('statesList:::: $statesList');

                            // return Column(
                            //   children: statesList
                            //       .map(
                            //         (e) => Text(e?.stateName),
                            //       )
                            //       .toList(),
                            // );

                            //----Build DropdownMenu
                            return DropdownButtonHideUnderline(
                              child: ButtonTheme(
                                alignedDropdown: true,
                                child: DropdownButton<String>(
                                  value: _myState,
                                  iconSize: 30,
                                  icon: (null),
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 16,
                                  ),
                                  hint: Text('Séléctionner la willaya'),
                                  onChanged: (String newValue) {
                                    print('newValue $newValue');
                                    setState(() {
                                      _myState = newValue;
                                      // _getCitiesList();
                                      print(_myState);
                                    });
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

                                  items: statesList?.map((item) {
                                        return DropdownMenuItem(
                                          //  child: Text(item['name']),
                                          child: Text(item['wilayaName']),
                                          value: item['id'].toString(),
                                        );
                                      })?.toList() ??
                                      [],
                                ),
                              ),
                            );

                            //++++++++++ End DROPDOWn MENU
                          }
                        //---
                      }
                      return error('Data messing occured!');
                    },
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),

          //======================================================== City
          /*
           Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 5),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton<String>(
                        value: _myCity,
                        iconSize: 30,
                        icon: (null),
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                        ),
                        hint: Text('Séléctioner votre Daîra'),
                        onChanged: (String newValue) {
                          setState(() {
                            _myCity = newValue;
                            print(_myCity);
                          });
                        },
                        /*
                        items: [
                          {"id": 1, "wilayaName": "Adrar"},
                          {"id": 2, "wilayaName": "Chlef "},
                          {"id": 3, "wilayaName": "Laghouat"}
                        ].map(
                          (item) {
                            return DropdownMenuItem(
                              child: Text(item['name']),
                              value: item['id'].toString(),
                            );
                          },
                        ),*/

                        items: citiesList?.map(
                              (item) {
                                return new DropdownMenuItem(
                                  child: new Text(item['name']),
                                  value: item['id'].toString(),
                                );
                              },
                            )?.toList() ??
                            [],
                        //++++++++++++++++
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

         */
        ],
      ),
    );
  }

  //=============================================================================== Api Calling here

//CALLING STATE API HERE
// Get State information by API

  //++++++++++++++++++
  Future<List<dynamic>> _getStateListOnline() async {
    String stateInfoUrl = 'http://cleanions.bestweb.my/api/location/get_state';
    await http.post(stateInfoUrl, headers: {
      'Content-Type': 'application/x-www-form-urlencoded'
    }, body: {
      "api_key": '25d55ad283aa400af464c76d713c07ad',
    }).then((response) {
      var responseJson = json.decode(response.body);
      print('responseJson ::::$responseJson ');
      setState(() {
        statesList = responseJson['state'];
      });
      print('statesList ::::$statesList ');
      // state = [{id:1, name:'Adrar'},{id:1, name:'Chelef'},...]
    });
    return Future.value(statesList);
  }

//+++++++++++++ GET WILLYAS +++++++

  Future<List<dynamic>> _getStateListLocal() async {
    //++++++++++++++
    await rootBundle.loadString('assets/jsons/willayas.json').then((response) {
      var responseJson = jsonDecode(response);
      print('responseJson ::::$responseJson ');

      setState(() {
        statesList = responseJson['data'];
      });
      /* "data" =  [  { "id": 1,"wilayaName": "Adrar"  },{ "id": 2, "wilayaName": "Chlef "},...  ] */
      //  print('statesList ::::$statesList ');
    });
    return Future.value(statesList);
  }
//++++++++++++++++++++

  // Get State information by API
  List citiesList;
  String _myCity;

  String cityInfoUrl =
      'http://cleanions.bestweb.my/api/location/get_city_by_state_id';
  Future<String> _getCitiesList() async {
    await http.post(cityInfoUrl, headers: {
      'Content-Type': 'application/x-www-form-urlencoded'
    }, body: {
      "api_key": '25d55ad283aa400af464c76d713c07ad',
      "state_id": _myState,
    }).then((response) {
      var data = json.decode(response.body);

      setState(() {
        citiesList = data['cities'];
      });
    });
  }
}
