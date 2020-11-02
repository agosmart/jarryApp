import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jariapp/models/deliver.dart';

import 'package:http/http.dart' as http;
import 'package:jariapp/providers/exeptions/exeptions.dart';

class MapProvider extends ChangeNotifier {
  //......
  List<Deliver> _deliversList = [];

//+++++++++++++++++++ GET STATES FROM LOCAL +++++++++++++++++++++++++++
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
}
