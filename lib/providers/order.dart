import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:jarryApp/providers/exeptions/exeptions.dart';
import 'package:jarryApp/utils/constantes.dart';

class OrderProvider extends ChangeNotifier {
//+++++++++++++++++++++++++++++++

//......

  // bool _isItemsOrdred = false;
  // get isItemsOrdred => _isItemsOrdred;
  // setIsItemsOrdred(bool value) {
  //   _isItemsOrdred = value;
  //   notifyListeners();
  // }

//.....
  Map<String, dynamic> _currentOrder = {};
  //....
  get getOrderDetailsEnd => _currentOrder;
  //....
  setOrderDetailsEnd(Map<String, dynamic> obj) {
    _currentOrder = obj;
    notifyListeners();
  }

  //++++++++++++++++++++++++++++++

  Future<dynamic> fetchOrderAPI() async {
    //---
    print("++++++++ ENTER ORDER ++++++++++ ");
    //  http: //danone.cooffa.shop/api/v1/clients/familles
    String baseURL = BASEURL + '/order';
    //.....
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json; charset=UTF-8',
    };
    //....
    final body = getOrderDetailsEnd;
    //.......
    print('BODY :::::: ==>>>>>${jsonEncode(body)}');
    //........

/*
    final body = {
      "order": [
        {"productId": "1", "quantity": "1", "unitPrice": "25.0"}
      ],
      "clientMobile": "0560125252",
      "livreurId": "19",
      "stateOrder": "2",
      "communeId": "575"
    };
*/
    // try {
    final http.Response response = await http.post(
      baseURL,
      headers: headers,
      body: jsonEncode(body),
    );
    print('status:::: ${response.statusCode}');

    Map<String, dynamic> responseJson = jsonDecode(response.body);
    //........
    switch (responseJson['code']) {
      case 200:
      case 201:
        //...
        if (responseJson['data'].length == 0) {
          throw ResourceNotFound('Commande');

          //...
        } else {
          /*
             final result =  {
                "status": "Success",
                    "code": 201,
                    "message": "Commande envoyé avec success.",
                    "data": {
                        "id": 216}
             };*/

          final resultOrder = {
            'id': (responseJson['data']['id']),
            'code': (responseJson['code']),
          };
          // final transactionID = (responseJson['data']['id']).toString();

          /*
            for (var item in responseJson['data']) {
              _products.add(Product.fromJson(item));
            }
            //  print("+++++++  DISPLAY STATES LIST  +++++++++++ ");
            //  print('_statesList ==== ${jsonEncode(_statesList)}');
            notifyListeners();
            return Future.value(_products);
            */
          print("+++++++  DISPLAY ORDER +++++++++++ ");
          return Future.value(resultOrder);
        }
        //..
        break;
      case 404:
        throw ResourceNotFound('Order');
        break;
      case 422:
        //throw ResourceNotFound('Téléphone invalide');
        return Future.value({'code': '422'});
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
    // } catch (e) {
    //   throw Exception(': Erreur de serveur. Veuillez réessayer plus tard');
    // }
  }
  //++++++++++++++++++++++++++++++

}
