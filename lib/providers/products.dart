import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jariapp/models/cart.item.dart';
import 'package:jariapp/models/product.dart';
import 'package:jariapp/providers/exeptions/exeptions.dart';
import 'package:jariapp/utils/constantes.dart';

import 'package:http/http.dart' as http;

class ProductsProvider extends ChangeNotifier {
//+++++++++++++++++++++++++++++++

  // ProductsProvider() {
  //   init();
  // }

  // init() {
  //   _numOfItems = 1;
  // }
  List<CartItem> _cartItems = [];
  List<Product> _products = [];
  Product _currentProduct;
  bool _isChecked;

  //int _numOfItems;

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
  bool get isChecked => _isChecked ?? false;
  setIsChecked(bool value) {
    _isChecked = value;
    notifyListeners();
  }

  bool isProductExist(int id) {
    //if (_cartItems.length <= 0) return false;

    try {
      return _cartItems.indexOf(
                  _cartItems?.firstWhere((CartItem e) => e?.productId == id)) >=
              0 ??
          false;
    } catch (e) {
      return false;
    }

    /* var item =
        _cartItems.indexOf(_cartItems?.firstWhere((CartItem e) => e?.productId == id));

    return item >= 0 ? true : false;
 */
    /* return _cartItems.length <= 0
        ? false
        : _cartItems.indexOf(_cartItems?.firstWhere((e) => e.productId == id)) == -1
            ? false
            : true;
     */
    //  return _cartItems.every((e) => e.idProduct == id);
    // bool result = false;
    // for (var item in _cartItems) {
    //   if (item.idProduct == id)
    //     result = true;
    //   else
    //     result = false;
    // }
    // //...............................
    // return result;
  }

  /*    get getNumOfItems => _numOfItems;
  setNumOfItems(int value) {
    print('_numOfItems ::: $_numOfItems');
    _numOfItems = value;
    // setTotalPrice(_numOfItems);
    notifyListeners();
  } */

  int getNumOfItems(int id) {
    try {
      /*
      //...........
      int numItems;
      //...........
      bool _isExist = isProductExist(id);
      numItems =
          _isExist ? _cartItems.firstWhere((e) => e.idProduct == id)?.qty : null;

      return numItems;
      */
      return _cartItems?.firstWhere((e) => e.productId == id)?.qty;
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

  get getItemCount => _cartItems.length;
  get getCartItems => _cartItems;
//......
  Product get currentProduct => _currentProduct;
  setCurrentProduct(Product value) {
    _currentProduct = value;
    notifyListeners();
  }

  addProductToCart(CartItem cart) {
    _cartItems.add(cart);
    notifyListeners();
  }

  updateProductCart(int id, int qty, double priceUnit, double priceTotal) {
    CartItem item = _cartItems.firstWhere((e) => e.productId == id);
    item.qty = qty;
    item.priceUnit = priceUnit;
    item.priceTotal = priceTotal;
    notifyListeners();
  }

  removeProductFromCart(id) {
    print('_cartItems BEFOR :: ${_cartItems.length}');
    //+++++
    _cartItems.removeWhere((item) => item.productId == id);
    //+++++
    print('_cartItems AFTER:: ${_cartItems.length}');
    notifyListeners();
  }

  clearCartItems() {
    _cartItems.clear();
    print('_cartItems CLEARED:: ${_cartItems.length}');
    notifyListeners();
  }
  // Future<bool> clearCartItems() {
  //   _cartItems.clear();
  //   notifyListeners();
  //   return Future.value(true);
  // }

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
        throw ResourceNotFound('Produits');
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

  Future<List<Product>> fetchProductsByCategoryAPI({String categoryId}) async {
    //---
    print("++++++++ ENTER PRODUCTS / productId :$categoryId ++++++++++ ");
    //  http: //danone.cooffa.shop/api/v1/clients/familles
    String baseURL = BASEURL + '/products/famille/$categoryId';

    //.......
    _products.clear();
    //........
    try {
      var response = await http.get(baseURL,

          // headers: {'Content-Type': 'application/x-www-form-urlencoded'});
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          });

      var jsonObject = jsonDecode(response.body);
      //........
      switch (jsonObject['code']) {
        case 200:
          //...
          if (jsonObject['data'].length == 0) {
            throw ResourceNotFound('Produits');
            //...
          } else {
            for (var item in jsonObject['data']) {
              _products.add(Product.fromJson(item));
            }
            //  print("+++++++  DISPLAY STATES LIST  +++++++++++ ");
            //  print('_statesList ==== ${jsonEncode(_statesList)}');
            notifyListeners();

            return Future.value(_products);
          }
          //..
          break;
        case 404:
          throw ResourceNotFound('Produits');
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
    }
  }
  //++++++++++++++++++++++++++++++

}
