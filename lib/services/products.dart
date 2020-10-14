import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jariapp/models/cart.item.dart';
import 'package:jariapp/models/product..dart';
import 'package:jariapp/services/exeptions/exeptions.dart';

class ProductsProvider extends ChangeNotifier {
//+++++++++++++++++++++++++++++++

  // ProductsProvider() {
  //   init();
  // }

  // init() {
  //   _numOfItems = 1;
  // }
  List<CartItem> _cart = [];
  List<Product> _products = [];
  Product _currentProduct;

  int _numOfItems;
  //int _total;
  //int _price = 10;
  //......
  /*
  get getTotalPrice => _total;
  setTotalPrice(int value) {
    print('Total ::: $_total');
    _total = value * _price;
    //notifyListeners();
  }
  */
//......

  bool isProductExist(int id) {
    //if (_cart.length <= 0) return false;

    try {
      return _cart.indexOf(
                  _cart?.firstWhere((CartItem e) => e?.productId == id)) >=
              0 ??
          false;
    } catch (e) {
      return false;
    }

    /* var item =
        _cart.indexOf(_cart?.firstWhere((CartItem e) => e?.productId == id));

    return item >= 0 ? true : false;
 */
    /* return _cart.length <= 0
        ? false
        : _cart.indexOf(_cart?.firstWhere((e) => e.productId == id)) == -1
            ? false
            : true;
     */
    //  return _cart.every((e) => e.idProduct == id);
    // bool result = false;
    // for (var item in _cart) {
    //   if (item.idProduct == id)
    //     result = true;
    //   else
    //     result = false;
    // }
    // //...............................
    // return result;
  }

  // get getNumOfItems => _numOfItems;
  setNumOfItems(int value) {
    print('_numOfItems ::: $_numOfItems');
    _numOfItems = value;
    // setTotalPrice(_numOfItems);
    notifyListeners();
  }

  int getNumOfItems(int id) {
    try {
      /*
      //...........
      int numItems;
      //...........
      bool _isExist = isProductExist(id);
      numItems =
          _isExist ? _cart.firstWhere((e) => e.idProduct == id)?.qty : null;

      return numItems;
      */
      return _cart?.firstWhere((e) => e.productId == id)?.qty;
    } catch (e) {
      return null;
    }
  }

//......

  List<Product> get products => _products;
  setProducts(List<Product> values) {
    _products = values;
    notifyListeners();
  }

//......

  get getItemCount => _cart.length;
  get getCartItems => _cart;
//......
  Product get currentProduct => _currentProduct;
  setCurrentProduct(Product value) {
    _currentProduct = value;
    notifyListeners();
  }

  addProductToCart(CartItem cart) {
    _cart.add(cart);
    notifyListeners();
  }

  updateProductCart(int id, int qty, double priceTotal) {
    CartItem item = _cart.firstWhere((e) => e.productId == id);
    item.qty = qty;
    item.priceTotal = priceTotal;
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
