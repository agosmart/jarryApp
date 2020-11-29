import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'package:jarryApp/models/deliver.dart';
import 'package:jarryApp/providers/exeptions/exeptions.dart';
import 'package:jarryApp/utils/constantes.dart';

/*
class OrderItem {
  String productId;
  String quantity;
  String unitPrice;
  OrderItem({this.productId, this.quantity, this.unitPrice});

  OrderItem.fromJson(Map<String, dynamic> jsonObject) {
    this.productId = jsonObject['productId'];
    this.quantity = jsonObject['qty'];
    this.unitPrice = jsonObject['priceUnit'];
  }
}

//....................................
class Body {
  String latitude;
  String longitude;
  List<OrderItem> order;
  Body({this.latitude, this.longitude, this.order});

  Body.fromJson(Map<String, dynamic> jsonObject) {
    this.latitude = jsonObject['latitude'];
    this.longitude = jsonObject['longitude'];

    order = [];
    var items = jsonDecode(jsonObject['order']);
    for (var item in items) {
      this.order.add(OrderItem.fromJson(item));
    }
  }
}
*/
class MapProvider extends ChangeNotifier {
  //......

  final String localityId;
  MapProvider({this.localityId});

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

  Future<List<Deliver>> fetchDeliversDatasAPI(
      {String localityId, Map<String, dynamic> orderDetails}) async {
    //---

    // print('Positions FROM API Map :: $latitudeClient / $longitudeClient');
    // print('_cartItems FROM API Map :: ${jsonEncode(orderDetails)} ');
    print("++++++++ ENTER LIST DELIVERS / localityId :$localityId ++++++++++ ");
    //----------------------------------------------------------------
    // if (ctx == null) ctx = ctx.dependOnInheritedWidgetOfExactType();

    //.......
    _deliversList.clear();
    //........
    //++++++++++++++++++++++++++++++++++++++
    // final localityId = getcurrentLocalityID;
    //++++++++++++++++++++++++++++++++++++++

    String baseURL = BASEURL + '/livreurs/$localityId';
    //.....
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json; charset=UTF-8',
    };
    //.....

    final body = orderDetails;
    /* final body = {
      'latitude': latitudeClient.toString(),
      'longitude': longitudeClient.toString(),
      'order': cartItems.map((CartItem item) {
        return {
          "productId": item.productId.toString(),
          "quantity": item.qty.toString(),
          "unitPrice": item.priceUnit.toString()
        };
      }).toList()
    };*/

    print('BODY :::::: ==>>>>>${jsonEncode(body)}');
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
        body: jsonEncode(body),
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
            return Future.value([]);
            //throw ResourceNotFound('wilayas');
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
      // print(e);
      throw Exception(': Erreur de serveur. Veuillez réessayer plus tard');
      //return Future.error('Erreur de connexion au serveur. veuillez réessayer');
      // StateArea result = StateArea(stateName: 'Erreur de connexion', id: 0);
      // return Future.value([result]);
    }
  }
  //............................
}
