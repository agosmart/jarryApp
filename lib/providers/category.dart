import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jariapp/models/category.dart';
import 'package:jariapp/utils/constantes.dart';

import 'package:http/http.dart' as http;

import 'exeptions/exeptions.dart';

class CategoryProvider extends ChangeNotifier {
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

  List<Category> _categories = [];
  Color _currentCatColor;
  String _currentCategoryName;
  String _currentCategoryID;
  IconData _currentIcon;

  //......

  Color get currentCatColor => _currentCatColor;
  setCurrentCatColor(Color value) {
    // print('color :::: $value');
    _currentCatColor = value;
    notifyListeners();
  }

  //......
  IconData get currentCatIcon => _currentIcon;
  setCurrentCatIcon(IconData value) {
    //print('Icon :::: $value');
    _currentIcon = value;
    notifyListeners();
  }

  //......
  String get currentCategoryID {
    print('  CATEGORY ID FROM PROVIDER :::: $_currentCategoryID');
    return _currentCategoryID;
  }

  String get currentCategoryName {
    print('NAME CATEGORY FROM PROVIDER :::: $_currentCategoryName');
    return _currentCategoryName;
  }

  setCurrentCategoryName(String value) {
    print('====== CatName ========= $value');
    _currentCategoryName = value;
    notifyListeners();
  }

  setCurrentCategoryID(String value) {
    print('====== CatName ========= $value');
    _currentCategoryID = value;
    notifyListeners();
  }

  //++++++++++++++++++ GET CATEGORIES FROM API  ++++++++++++++++++++++

  Future<List<Category>> fetchCategoriesAPI() async {
    //---
    print("++++++++ ENTER LIST Categories ++++++++++ ");
    //----------------------------------------------------------------
    //http://danone.cooffa.shop/api/v1/clients/familles
    String baseURL = BASEURL + '/familles';
    //.......
    _categories.clear();
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
            throw ResourceNotFound('Categories');
            //...
          } else {
            for (var item in jsonObject['data']) {
              _categories.add(Category.fromJson(item));
            }
            notifyListeners();
            print(_categories);

            print('ITEM !!!!!! ${_categories.length}');
            return Future.value(_categories);
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
    } catch (e) {
      throw Exception(': Erreur de serveur. Veuillez réessayer plus tard');
    }
  }

  //++++++++++++++++++ GET CATEGORIES FROM LOCAL  +++++++++++++++++++++++
  Future<List<Category>> fetchCategoriesLocal() async {
    Future.delayed(Duration(seconds: 5));
    //---
    print("++++++++ ENTER LIST Categories ++++++++++ ");
    //----------------------------------------------------------------
    // if (ctx == null) ctx = ctx.dependOnInheritedWidgetOfExactType();

    //.......
    _categories.clear();
    //........

    // try {  } catch (e) {
    //   throw Exception();
    // }
    // var response = await DefaultAssetBundle.of(context)
    //     .loadString("assets/jsons/users_group.json");
    var response = await rootBundle.loadString('assets/jsons/categories.json');
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
            _categories.add(Category.fromJson(item));
          }
          print(_categories);
          // _usersOfGroup =  List.from(jsonObject['data']).map((e) => e.UserGroupData.fromJson());
          print('ITEM !!!!!! ${_categories.length}');
          print("+++++++  DISPLAY CARD INFO CATEGORIES  +++++++++++ ");

          return Future.value(_categories);

          // if (_categories.length > 0) {
          //   print("+++++++++++++ LISt of Category ++++++++++++++++++++++ ");
          //   //--
          //   // notifyListeners();

          // }

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
}
