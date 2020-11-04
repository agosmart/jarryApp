import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jariapp/models/deliver.dart';

import 'package:http/http.dart' as http;
import 'package:jariapp/providers/exeptions/exeptions.dart';
import 'package:jariapp/utils/constantes.dart';

class MapProvider extends ChangeNotifier {
  //......

  final String localityId;
  MapProvider({this.localityId});

  //.......
  final List<Deliver> _deliversList = [];

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

    print("++++++++ ENTER LIST DELIVERS / localityId :$localityId ++++++++++ ");
    //----------------------------------------------------------------
    // if (ctx == null) ctx = ctx.dependOnInheritedWidgetOfExactType();

    //.......
    _deliversList.clear();
    //........
    //++++++++++++++++++++++++++++++++++++++
    // final localityId = getcurrentLocalityID;
    //++++++++++++++++++++++++++++++++++++++
/*
  String baseURL = BASEURL + '/livreurs/$localityId';

  final headers = {
    // 'Content-Type': 'application/json; charset=UTF-8',
    // 'Content-Type': 'application/x-www-form-urlencoded',
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    // 'Authorization': 'Bearer $tokenValue',
  };
*/
    //-----------------------------------------------------
    final json = const JsonCodec();
    var order = [
      {"productId": "25", "quantity": "15", "unitPrice": "20"},
      {"productId": "26", "quantity": "8", "unitPrice": "35"},
      {"productId": "31", "quantity": "9", "unitPrice": "135"}
    ];

    final queryParameters = {
      "latitude": "36.725",
      "longitude": "3.1004224",
      "order": json.encode(order)
    };
    print(queryParameters);

    //final queryParameters1 ='clientMobile=0560159966&latitude=36.725&longitude=3.1004224&order= "[{"productId": "25", "quantity": "15", "unitPrice": "20"},{"productId": "26", "quantity": "8", "unitPrice": "35"},{"productId": "31", "quantity": "9", "unitPrice": "135"}]';
/*
    final queryParameters1 = '''{
        'clientMobile':'0560159966',
        'latitude':'36.725',
        'longitude':'3.1004224',
        'order'= '[
          [{"productId": "25", "quantity": "15", "unitPrice": "20"},{"productId": "26", "quantity": "8", "unitPrice": "35"},{"productId": "31", "quantity": "9", "unitPrice": "135"}]
        ]'
        }''';

        */
    //final queryParametersObj = json. (queryParameters);

    /* ****************************************
     NOTE : you sould avoid  to use 'http:// withe  Uri.http()   like this'http://danone.cooffa.shop' 
     you get Error (Radix 10) , you need to use link without (http://)
    
    
    *********************************  */
    //localityId =575
    final uri = Uri.http(
      'danone.cooffa.shop',
      '/api/v1/clients/livreurs/$localityId',
      queryParameters,
    );
    final headerData = {
      // 'Content-Type': 'application/json;charset=UTF-8',
      // 'Charset': 'utf-8'
      'Accept': 'application/json',
      'Content-Type': 'application/json',

      // HttpHeaders.contentTypeHeader: 'application/json'
    };

/*
  Uri uri = Uri.parse("http://theapiiamcalling:8000");
  final newURI = uri.replace(queryParameters: params);

  var response = await http.get(newURI, headers: {
    HttpHeaders.contentTypeHeader: "application/json",
    // "Authorization": Constants.APPOINTMENT_TEST_AUTHORIZATION_KEY,
    // "callMethod" : "DOCTOR_AVAILABILITY"
  });
  */
    //....
    try {
      //var response = await http.get(baseURL, headers: headers);
      final response = await http.get(
        uri,
        headers: headerData,
      );
      //var jsonObject = jsonDecode(response.body);

      var jsonData = json.decode(response.body);

      print('---- slot: $jsonData');
/*
    //........
    switch (jsonObject['code']) {
      case 200:
        //...
        if (jsonObject['data'].length == 0) {
          throw ResourceNotFound('wilayas');
          //...
        } else {
          for (var item in jsonObject['data']) {
            _deliversList.add(Deliver.fromJson(item));
          }
          //  print("+++++++  DISPLAY STATES LIST  +++++++++++ ");
          //  print('_statesList ==== ${jsonEncode(_statesList)}');
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
        print('List of users group is null :::::: ${jsonObject['data']}');
        return null;

        break;
      //..
    }*/
    } catch (e) {
      print(e);
      // throw Exception(': Erreur de serveur. Veuillez réessayer plus tard');
      //return Future.error('Erreur de connexion au serveur. veuillez réessayer');
      // StateArea result = StateArea(stateName: 'Erreur de connexion', id: 0);
      // return Future.value([result]);
    }
  }
  //............................
}
