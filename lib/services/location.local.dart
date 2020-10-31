import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jariapp/models/category.dart';
import 'package:http/http.dart' as http;
import 'package:jariapp/models/location.dart';
import 'package:jariapp/utils/constantes.dart';
import 'package:jariapp/utils/helpers.dart';

import 'exeptions/exeptions.dart';

class LocationProvider extends ChangeNotifier {
  //++++++++++++++++++++++++++++
  // CategoryProvider();

  // CategoryProvider() {
  //   init();
  // }

  // init() {
  //   print(
  //       '##### NAME CATEGORy FROM PROVIDER====INIT #### :::: $_currentCategory');

  //   this.currentCategory;
  // }

  List<StateArea> _statesList = [];
  List<CityArea> _citiesList = [];
  List<LocalityArea> _localitiesList = [];
  // List<StateArea> _citiesList = [];
  String _currentStateName;
  String _currentStateID;
  //....
  String _currentCityArea;
  String _currentCityID;
  //....
  String _currentLocalityName;
  String _currentLocalityID;
  //......

  //......
  String get getcurrentStateID => _currentStateID;
  String get getcurrentStateName => _currentStateName;
  String get getcurrentCityID => _currentCityID;
  String get getcurrentCityArea => _currentCityArea;
  String get getcurrentLocalityID => _currentLocalityID;
  String get getcurrentLocalityName => _currentLocalityName;

  setCurrentStateName(String id) {
    print('====== Current State Name ========= $id');
    _currentStateName = _statesList
        .firstWhere((StateArea e) => e.id.toString() == id)
        .stateName;
    notifyListeners();
  }

  setCurrentStateID(String id) {
    print('====== Current State ID ========= $id');
    _currentStateID = id;
    notifyListeners();
  }
//.....

  setCurrentCityName(String id) {
    print('====== Current City Name ========= $id');
    _currentCityArea =
        _citiesList.firstWhere((CityArea e) => e.id.toString() == id).cityName;
    notifyListeners();
  }

  setCurrentCityID(String id) {
    print('====== Current State ID ========= $id');
    _currentCityID = id;
    notifyListeners();
  }

//.....

  setCurrentLocalityName(String value) {
    print('====== Current State Name ========= $value');
    _currentLocalityName = value;
    notifyListeners();
  }

  setCurrentLocalityID(String id) {
    print('====== Current State ID ========= $id');
    _currentLocalityID = _localitiesList
        .firstWhere((LocalityArea e) => e.id.toString() == id)
        .localityName;
    notifyListeners();
  }

  //+++++++++++++++++++++++ GET STATES FrOM LOCAL +++++++++++++++++++++

  Future<List<StateArea>> fetchStatesAreaLocal() async {
    await Future.delayed(Duration(milliseconds: 700));
    //---
    print("++++++++ ENTER LIST STATES ++++++++++ ");
    //----------------------------------------------------------------
    // if (ctx == null) ctx = ctx.dependOnInheritedWidgetOfExactType();

    //.......
    _statesList.clear();
    //........
    try {
      var response = await rootBundle.loadString('assets/jsons/willayas.json');
      var jsonObject = jsonDecode(response);

      //........
      switch (jsonObject['code']) {
        case 200:
          //...
          if (jsonObject['data'].length == 0) {
            throw ResourceNotFound('willayas');
            //...
          } else {
            for (var item in jsonObject['data']) {
              _statesList.add(StateArea.fromJson(item));
            }

            notifyListeners();

            print('_statesList ==== ${jsonEncode(_statesList)}');
            // _usersOfGroup =  List.from(jsonObject['data']).map((e) => e.UserGroupData.fromJson());
            // print('ITEM !!!!!! ${_statesList.length}');
            print("+++++++  DISPLAY CARD INFO CATEGORIES  +++++++++++ ");

            return Future.value(_statesList);
          }
          //..
          break;
        case 404:
          throw ResourceNotFound('Willaya');
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
          print('List of users group is null :::::: ${jsonObject['data']}');
          return null;

          break;
        //..
      }
    } catch (e) {
      throw Exception(': Erreur de connexion, merci de réessayer');
      //return Future.error('Erreur de connexion au serveur. veuillez réessayer');
      // StateArea result = StateArea(stateName: e.toString(), id: 0);
      // return Future.value([result]);
    }
  }

  //+++++++++++++++++++ GET CITIES FROM LOCAL +++++++++++++++++++++++++++

  Future<List<CityArea>> fetchCitiesAreaLocal() async {
    //.....
    await Future.delayed(Duration(milliseconds: 700));
    //---
    print("++++++++ ENTER LIST CITIES  ++++++++++ ");
    //----------------------------------------------------------------
    // if (ctx == null) ctx = ctx.dependOnInheritedWidgetOfExactType();

    //.......
    _citiesList.clear();
    //........
    try {
      var response = await rootBundle.loadString('assets/jsons/cities.json');
      var jsonObject = jsonDecode(response);

      //........
      switch (jsonObject['code']) {
        case 200:
          //...
          if (jsonObject['data'].length == 0) {
            throw ResourceNotFound('Dairas');
            //...
          } else {
            for (var item in jsonObject['data']) {
              _citiesList.add(CityArea.fromJson(item));
            }

            notifyListeners();

            print('_statesList ==== ${jsonEncode(_citiesList)}');
            // _usersOfGroup =  List.from(jsonObject['data']).map((e) => e.UserGroupData.fromJson());
            // print('ITEM !!!!!! ${_statesList.length}');
            print("+++++++  DISPLAY CARD INFO CATEGORIES  +++++++++++ ");

            return Future.value(_citiesList);
          }
          //..
          break;
        case 404:
          throw ResourceNotFound('Willaya');
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
          print('List of users group is null :::::: ${jsonObject['data']}');
          return null;

          break;
        //..
      }
    } catch (e) {
      throw Exception(': Erreur de connexion, merci de réessayer');
      //return Future.error('Erreur de connexion au serveur. veuillez réessayer');
      // CityArea result = CityArea(cityName: e.toString(), id: 0);
      // return Future.value([result]);
    }
  }

  // String cityInfoUrl = 'http://danone.cooffa.shop/api/v1/clients/dairas/16';
  // Future<String> _getCitiesListApi() async {
  //   await http.get(cityInfoUrl, headers: {
  //     'Content-Type': 'application/x-www-form-urlencoded'
  //   }).then((response) {
  //     var data = json.decode(response.body);

  //     _citiesList = (data['data']);
  //   });
  //   return Future.value(_citiesList);
  // }
  /*
  String stateInfoUrl = 'http://cleanions.bestweb.my/api/location/get_state';
  Future<String> getStateList() async {
    await http.post(stateInfoUrl, headers: {
      'Content-Type': 'application/x-www-form-urlencoded'
    }, body: {
      "api_key": '25d55ad283aa400af464c76d713c07ad',
    }).then((response) {
      var data = json.decode(response.body);

      _statesList = data['state'];

     print(data);
      setState(() {
        _statesList = data['state'];
      });
    });
  }
  */

  //+++++++++++++++++++++++++++++
}
