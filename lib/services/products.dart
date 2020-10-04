import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:jariapp/models/product..dart';
import 'package:jariapp/services/exeptions/exeptions.dart';

class ProductsProvider extends ChangeNotifier {
//+++++++++++++++++++++++++++++++

  List<Product> _products;
  get products => _products;
  setProducts(List<Product> values) {
    _products = values;
    notifyListeners();
  }

  //++++++++++++++++++++++++++++

  Future<List<Product>> fetchProductsCategoryLocal() async {
    Future.delayed(Duration(seconds: 5));
    //---
    print("++++++++ ENTER LIST Categories ++++++++++ ");
    //----------------------------------------------------------------
    // if (ctx == null) ctx = ctx.dependOnInheritedWidgetOfExactType();

    //.......
    _products.clear();
    //........

    // try {  } catch (e) {
    //   throw Exception();
    // }
    // var response = await DefaultAssetBundle.of(context)
    //     .loadString("assets/jsons/users_group.json");
    var response =
        await rootBundle.loadString('assets/jsons/product.cat4.json');
    var jsonObject = jsonDecode(response);

    //........
    switch (jsonObject['code']) {
      case 200:
        //...
        if (jsonObject['data'].length == 0) {
          throw ResourceNotFound('Categories');
          //...
        } else {
          for (var item in jsonObject['data']) {
            var product = Product.fromJson(item);
            _products.add(product);
          }

          print('ITEM !!!!!! ${_products.length}');
          print("+++++++  DISPLAY CARD INFO _products  +++++++++++ ");

          return Future.value(_products);
        }
        //..
        break;
      case 404:
        throw ResourceNotFound('Coursiers');
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
  }

  //++++++++++++++++++++++++++++++
}
