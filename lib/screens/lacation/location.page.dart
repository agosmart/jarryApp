import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jariapp/models/location.dart';
import 'package:jariapp/services/exeptions/exeptions.dart';
import 'package:jariapp/themes/colors.dart';
import 'package:jariapp/utils/helpers.dart';

class LocationPage extends StatefulWidget {
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  //+++++++++++++++
  List<StateArea> statesList = [];
  String _myState = "";

  List<AdministrativeArea> citiesList = [];
  String _myCity = "";

  Future<List<StateArea>> _futureFetchingState;
  //++++++++++++++++++
  @override
  void initState() {
    _futureFetchingState = _getStatesList();
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
              'JARI',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
            ),
          ),

          //========= Wilayas

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
                              return Center();
                            }
                            statesList = [...snapShot.data];
                            //----Build DropdownMenu
                            return DropdownButtonHideUnderline(
                              child: ButtonTheme(
                                alignedDropdown: true,
                                child: DropdownButton<String>(
                                  value: _myState,
                                  iconSize: 30,
                                  icon: (null),
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 16),
                                  hint: Text('Séléctionnez votre wilaya'),
                                  //+++++
                                  onChanged: (String newValue) {
                                    setState(() {
                                      _myState = newValue;
                                      //  _getCitiesList();
                                      print(_myState);
                                    });
                                  },
                                  //++++++
                                  items: statesList?.map((item) {
                                        //  print('  WILYATES :::  ${item["wilayaName"]}');

                                        return DropdownMenuItem(
                                          child: Text(item?.stateName ?? 'moh'),
                                          value: item.id.toString(),
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
                      return error('Data messing!');
                    },
                  ),

                  //.........................................
                  /*  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton<String>(
                        value: _myState,
                        iconSize: 30,
                        icon: (null),
                        style: TextStyle(color: Colors.black54, fontSize: 16),
                        hint: Text('Séléctionnez votre wilaya'),
                        //+++++
                        onChanged: (String newValue) {
                          setState(() {
                            _myState = newValue;
                            //  _getCitiesList();
                            print(_myState);
                          });
                        },
                        //++++++
                        items: statesList?.map((item) {
                              //  print('  WILYATES :::  ${item["wilayaName"]}');

                              return DropdownMenuItem(
                                child: Text(item.stateName),
                                value: item.id.toString(),
                              );
                            })?.toList() ??
                            [],
                      ),
                    ),
                  ),*/
                ),

                //.......................
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),

          //===== Daira

          // Container(
          //   padding: EdgeInsets.only(left: 15, right: 15, top: 5),
          //   color: Colors.white,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: <Widget>[
          //       Expanded(
          //         child: DropdownButtonHideUnderline(
          //           child: ButtonTheme(
          //             alignedDropdown: true,
          //             child: DropdownButton<String>(
          //               value: _myCity,
          //               iconSize: 30,
          //               icon: (null),
          //               style: TextStyle(
          //                 color: Colors.black54,
          //                 fontSize: 16,
          //               ),
          //               hint: Text('Séléctionnez votre daîra'),
          //               onChanged: (String newValue) {
          //                 setState(() {
          //                   _myCity = newValue;
          //                   // print(_myCity);
          //                 });
          //               },
          //               items: citiesList?.map((item) {
          //                     return new DropdownMenuItem(
          //                       child: Text(item['dairaName'] ?? 'moha'),
          //                       value: item['id'].toString(),
          //                     );
          //                   })?.toList() ??
          //                   [],
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  //=============================================================================== Api Calling here

//CALLING STATE API HERE
// Get State information by API
  // List statesList;
  // String _myState;
/*
  String stateInfoUrl = 'http://danone.cooffa.shop/api/v1/clients/wilayas';
  Future<String> _getStateList() async {
    await http.get(stateInfoUrl, headers: {
      'Content-Type': 'application/x-www-form-urlencoded'
    }).then((response) {
      var data = json.decode(response.body);

      print('WILYAS :::  $data');
      setState(() {
        statesList = data['data'];
      });
    });
  }*/

  Future<List<StateArea>> _getStatesList() async {
    final headers = {
      // 'Content-Type': 'application/json; charset=UTF-8',

      'Content-Type': 'application/json',
      'Accept': 'application/json',
      //'Authorization': 'Bearer $tokenValue',
    };
    //+++++++++++++++++++++++++++++++++++++++++++++
    String apiURL = 'http://danone.cooffa.shop/api/v1/clients/wilayas';
    //+++++++++++++++++++++++++++++++++++++++++++++
    try {
      final http.Response response = await http.get(apiURL, headers: headers);
      Map<String, dynamic> responseJson = jsonDecode(response.body);
      //....
      switch (responseJson['code']) {
        case 200:
          //...
          if (responseJson['data'].length == 0) {
            throw ResourceNotFound('State');
            //...
          } else {
            for (var item in responseJson['data']) {
              statesList.add(StateArea.fromJson(item));
            }
            // print(_usersOfGroup);

            // _usersOfGroup =  List.from(jsonObject['data']).map((e) => e.UserGroupData.fromJson());
            print('statesList !!!!!! ${statesList.length}');

            print("+++++++++++++++++++++++++++++++++++ ");
            return Future.value(statesList);
          }
          //..
          break;
        case 404:
          throw ResourceNotFound('State');
          break;
        case 111:
          throw ConnectionRefused();
          break;
        case 301:
        case 302:
        case 303:
          throw RedirectionFound();
          break;
        default:
          print('List of users state is null :::::: ${responseJson['data']}');
          return null;

          break;
        //..
      }

      //....

    } catch (e) {
      return Future.error('Erreur de connexion au serveur. veuillez réessayer');
    }
  }

  /* String stateInfoUrl = 'http://cleanions.bestweb.my/api/location/get_state';
  Future<String> _getStateList() async {
    await http.post(stateInfoUrl, headers: {
      'Content-Type': 'application/x-www-form-urlencoded'
    }, body: {
      "api_key": '25d55ad283aa400af464c76d713c07ad',
    }).then((response) {
      var data = json.decode(response.body);

//      print(data);
      setState(() {
        statesList = data['state'];
      });
    });
  } */

  // Get State information by API
  // List citiesList;
  // String _myCity;

  String cityInfoUrl = 'http://danone.cooffa.shop/api/v1/clients/dairas/16';
  Future<String> _getCitiesList() async {
    await http.get(cityInfoUrl, headers: {
      'Content-Type': 'application/x-www-form-urlencoded'
    }).then((response) {
      var data = json.decode(response.body);

      setState(() {
        citiesList = (data['data']);
      });
    });
  }

  /*  String cityInfoUrl =
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
  } */

  //++++++++++++++++++++++++++++++++++
}
