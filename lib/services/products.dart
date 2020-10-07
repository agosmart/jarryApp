import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jariapp/models/product..dart';
import 'package:jariapp/services/exeptions/exeptions.dart';

class ProductsProvider extends ChangeNotifier {
//+++++++++++++++++++++++++++++++

  List<Product> _products = [];
  Product _currentProduct;
//......

  List<Product> get products => _products;
  setProducts(List<Product> values) {
    _products = values;
    notifyListeners();
  }

//......

  Product get currentProduct => _currentProduct;
  setCurrentProduct(Product value) {
    _currentProduct = value;
    notifyListeners();
  }

  //++++++++++++++++++++++++++++

  Future<List<Product>> fetchProductsByCategoryLocal() async {
    await Future.delayed(Duration(milliseconds: 1500));
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
        await rootBundle.loadString('assets/jsons/produits_cat4.json');
    var jsonObject = jsonDecode(response);

    //........
    switch (jsonObject['code']) {
      case 200:
        //...
        if (jsonObject['data'].length == 0) {
          throw ResourceNotFound('Produits');
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
