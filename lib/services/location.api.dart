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
  String _currentCityName;
  String _currentCityID;
  //....
  String _currentLocalityName;
  String _currentLocalityID;
  //......

  //......
  String get getcurrentStateID => _currentStateID;
  String get getcurrentStateName => _currentStateName;
  String get getcurrentCityID => _currentCityID;
  String get getcurrentCityName => _currentCityName;
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
    _currentCityName =
        _citiesList.firstWhere((CityArea e) => e.id.toString() == id).cityName;
    notifyListeners();
  }

  setCurrentCityID(String id) {
    print('====== Current State ID ========= $id');
    _currentCityID = id;
    notifyListeners();
  }

//.....

  setCurrentLocalityName(String id) {
    _currentLocalityName = _localitiesList
        .firstWhere((LocalityArea e) => e.id.toString() == id)
        .localityName;
    print('====== Current Locality Name ========= $_currentLocalityName');

    notifyListeners();
  }

  setCurrentLocalityID(String id) {
    print('====== Current State ID ========= $id');
    _currentLocalityID = id;

    notifyListeners();
  }

  // resetLocationData() {
  //   _currentCityID = null;
  //   _currentLocalityID = null;
  // }

  //+++++++++++++++++++ GET STATES FROM API +++++++++++++++++++++++++++
  Future<List<StateArea>> fetchStatesAreaAPI() async {
    //String baseURL = 'http://danone.cooffa.shop/api/v1/clients/wilayas';
    String baseURL = BASEURL + '/wilayas';
    //---
    //  print("++++++++ ENTER LIST STATES ++++++++++ ");
    //----------------------------------------------------------------
    _statesList.clear();
    /* _citiesList.clear();
    _localitiesList.clear();
    _currentLocalityID = null;*/

    // _citiesList.clear();
    // _localitiesList.clear();
    //........
    try {
      var response = await http.get(baseURL,
          headers: {'Content-Type': 'application/x-www-form-urlencoded'});
      var jsonObject = jsonDecode(response.body);

      //........
      switch (jsonObject['code']) {
        case 200:
          //...
          if (jsonObject['data'].length == 0) {
            throw ResourceNotFound('wilayas');
            //...
          } else {
            for (var item in jsonObject['data']) {
              _statesList.add(StateArea.fromJson(item));
            }
            //  print("+++++++  DISPLAY STATES LIST  +++++++++++ ");
            //  print('_statesList ==== ${jsonEncode(_statesList)}');
            notifyListeners();

            return Future.value(_statesList);
          }
          //..
          break;
        case 404:
          throw ResourceNotFound('Willayas');
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
      // StateArea result = StateArea(stateName: 'Erreur de connexion', id: 0);
      // return Future.value([result]);
    }
  }

  /*..................................................................
              +++++++++ GET CITIES FROM API +++++++++ 
  ...................................................................*/
  Future<List<CityArea>> fetchCitiesAreaAPI() async {
    //..........
    print(
        'STATE NAME::: $getcurrentStateName | State ID ::: $getcurrentStateID');
    //.....
    String baseURL = BASEURL + '/dairas/$getcurrentStateID';
    //---
    // print("++++++++ ENTER LIST CITIES  ++++++++++ ");
    //----------------------------------------------------------------
    //.......
    _citiesList.clear();
    // _localitiesList.clear();
    //  _currentLocalityID = null;

    //........
    try {
      // var response = await rootBundle.loadString('assets/jsons/cities.json');
      // var jsonObject = jsonDecode(response);

      var response = await http.get(baseURL,
          headers: {'Content-Type': 'application/x-www-form-urlencoded'});
      var jsonObject = jsonDecode(response.body);

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
            //   print("+++++++  DISPLAY CITIES LIST  +++++++++++ ");
            //  print('_statesList ==== ${jsonEncode(_citiesList)}');

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
      //return Future.error('Erreur de connexion au serveur. veuillez réessayer');
      throw Exception(': Erreur de connexion, merci de réessayer');
      // CityArea result = CityArea(CityArea: e.toString(), id: 0);
      // return Future.value([result]);
    }
  }

  /*..................................................................
              +++++++++ GET LOCALITIES FROM API +++++++++ 
  ...................................................................*/
  Future<List<LocalityArea>> fetchLocalitiesAreaAPI() async {
    //..........
    print('CITY NAME::: $getcurrentCityName | CITY ID ::: $getcurrentCityID');
    //.....
    String baseURL = BASEURL + '/communes/$getcurrentCityID';
    //---
    // print("++++++++ ENTER LIST CITIES  ++++++++++ ");
    //----------------------------------------------------------------
    //.......
    _localitiesList.clear();
    //........
    try {
      // var response = await rootBundle.loadString('assets/jsons/cities.json');
      // var jsonObject = jsonDecode(response);

      var response = await http.get(baseURL,
          headers: {'Content-Type': 'application/x-www-form-urlencoded'});
      var jsonObject = jsonDecode(response.body);

      //........
      switch (jsonObject['code']) {
        case 200:
          //...
          if (jsonObject['data'].length == 0) {
            throw ResourceNotFound('Dairas');
            //...
          } else {
            for (var item in jsonObject['data']) {
              _localitiesList.add(LocalityArea.fromJson(item));
            }

            notifyListeners();
            //    print("+++++++  DISPLAY LOCALITIES LIST  +++++++++++ ");
            //  print('_localitiesList ==== ${jsonEncode(_localitiesList)}');

            return Future.value(_localitiesList);
          }
          //..
          break;
        case 404:
          throw ResourceNotFound('Commune');
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
      //return Future.error('Erreur de connexion au serveur. veuillez réessayer');
      throw Exception(': Erreur de connexion, merci de réessayer');
      // CityArea result = CityArea(CityArea: e.toString(), id: 0);
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
