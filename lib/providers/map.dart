import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jariapp/models/cart.item.dart';
import 'package:jariapp/models/deliver.dart';

import 'package:http/http.dart' as http;
import 'package:jariapp/models/product..dart';
import 'package:jariapp/providers/exeptions/exeptions.dart';
import 'package:jariapp/utils/constantes.dart';
import 'package:jariapp/providers/products.dart';

class MapProvider extends ChangeNotifier {
  //......

  final String localityId;
  MapProvider({this.localityId});

  List<CartItem> _cartItems = ProductsProvider().getCartItems;

  //.......
  final List<Deliver> _deliversList = [];

  double _latClient;
  double _lntClient;

  double get latitudeClient => _latClient;
  double get longitudeClient => _lntClient;
  setLatitudeClient(value) {
    _latClient = value;
    notifyListeners();
  }

  setLongitudeClient(value) {
    _lntClient = value;
    notifyListeners();
  }

//+++++++++++++++++++ GET DELIVERS LIST  FROM LOCAL +++++++++++++++++++++++++++
  Future<List<Deliver>> fetchDeliversDatasLocal() async {
    await Future.delayed(Duration(milliseconds: 700));
    //---
    print("++++++++ ENTER LIST DELIVERS ++++++++++ ");
    //----------------------------------------------------------------
    // if (ctx == null) ctx = ctx.dependOnInheritedWidgetOfExactType();

    //.......
    _deliversList.clear();
    //........
    try {
      var response = await rootBundle.loadString('assets/jsons/delivers.json');
      var jsonObject = jsonDecode(response);

      //........
      switch (jsonObject['code']) {
        case 200:
          //...
          if (jsonObject['data'].length == 0) {
            throw ResourceNotFound('Delivers');
            //...
          } else {
            for (var item in jsonObject['data']) {
              _deliversList.add(Deliver.fromJson(item));
            }

            notifyListeners();
            //++++++
            // print('_deliversList ==== ${jsonEncode(_deliversList)}');

            // print("+++++++  DISPLAY DELEIVERS +++++++++++ ");

            return Future.value(_deliversList);
          }
          //..
          break;
        case 404:
          throw ResourceNotFound('delivers');
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
      throw Exception(': Erreur de serveur. Veuillez réessayer plus tard');
      //return Future.error('Erreur de connexion au serveur. veuillez réessayer');
      // StateArea result = StateArea(stateName: e.toString(), id: 0);
      // return Future.value([result]);
    }
  }

  //+++++++++++++++++++ GET DELIVERS LIST FROM API +++++++++++++++++++++++++++

  Future<List<Deliver>> fetchDeliversDatasAPI({String localityId}) async {
    //---

    print('latitudeClient FROM API Map :: $latitudeClient ');
    print('_cartItems FROM API Map :: $_cartItems ');
    print("++++++++ ENTER LIST DELIVERS / localityId :$localityId ++++++++++ ");
    //----------------------------------------------------------------
    // if (ctx == null) ctx = ctx.dependOnInheritedWidgetOfExactType();

    //.......
    _deliversList.clear();
    //........
    //++++++++++++++++++++++++++++++++++++++
    // final localityId = getcurrentLocalityID;
    //++++++++++++++++++++++++++++++++++++++

    //-----------------------------------------------------
    // final json = const JsonCodec();
    // var order = [
    //   {"productId": "25", "quantity": "15", "unitPrice": "20"},
    //   {"productId": "26", "quantity": "8", "unitPrice": "35"},
    //   {"productId": "31", "quantity": "9", "unitPrice": "135"}
    // ];

    // print(queryParameters);
    //final body = jsonEncode(queryParameters);

    //+++++++++++++++++++++++
    //localityId =575
    /*
    final uri = Uri.http(
      'danone.cooffa.shop',
      '/api/v1/clients/livreurs/$localityId',
      queryParameters,
    );
     var jsonData = json.decode(response.body);

      print('---- slot: $jsonData');
  
    final headerData = {
      // 'Content-Type': 'application/json;charset=UTF-8',
      // 'Charset': 'utf-8'
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      // HttpHeaders.contentTypeHeader: 'application/json'
    };
    */
    String baseURL = BASEURL + '/livreurs/$localityId';
    //.....
    final headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    //.....
    //  final body = Map<String,String>{
    //   latitude: "123",
    //   longitude: "987",
    //   order: [
    //     {"productId": "25", "quantity": "15", "unitPrice": "20"},
    //     {"productId": "26", "quantity": "8", "unitPrice": "35"},
    //     {"productId": "31", "quantity": "9", "unitPrice": "135"}
    //   ]
    // };

    //....
    try {
      //var response = await http.get(baseURL, headers: headers);
      final http.Response response = await http.post(
        baseURL,
        headers: headers,
        body: jsonEncode(<String, dynamic>{
          'latitude': "123",
          'longitude': "987",
          'order': [
            {"productId": "25", "quantity": "15", "unitPrice": "20"},
            {"productId": "26", "quantity": "8", "unitPrice": "35"},
            {"productId": "31", "quantity": "9", "unitPrice": "135"}
          ]
        }),
      );
      //final jsonObject = jsonDecode(response.body);

      print('status:::: ${response.statusCode}');

      Map<String, dynamic> responseJson = jsonDecode(response.body);

      /*
      if (response.statusCode == 200) {
        responseJson = jsonDecode(response.body);
        print('SUCCESS ::: $responseJson');

        for (var item in responseJson['data']) {
          _deliversList.add(Deliver.fromJson(item));
        }
        notifyListeners();
        return Future.value(_deliversList);
      }
      */

      //........
      switch (responseJson['code']) {
        case 200:
          //...
          if (responseJson['data'].length == 0) {
            throw ResourceNotFound('wilayas');
            //...
          } else {
            for (var item in responseJson['data']) {
              _deliversList.add(Deliver.fromJson(item));
            }
            //  print("+++++++  DISPLAY STATES LIST  +++++++++++ ");
            // print('_statesList ==== ${jsonEncode(_deliversList)}');
            notifyListeners();
            return Future.value(_deliversList);
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
          print('List of users group is null :::::: ${responseJson['data']}');
          return null;

          break;
        //..
      }
    } catch (e) {
      print(e);
      throw Exception(': Erreur de serveur. Veuillez réessayer plus tard');
      //return Future.error('Erreur de connexion au serveur. veuillez réessayer');
      // StateArea result = StateArea(stateName: 'Erreur de connexion', id: 0);
      // return Future.value([result]);
    }
  }
  //............................
}
