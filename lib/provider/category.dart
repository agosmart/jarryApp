import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:jariapp/exeptions/exeptions.dart';
import 'package:jariapp/models/category.dart';

class CategoryProvider {
  List<Category> _categories = [];

  Future<List<Category>> fetchCategoriesLocal() async {
    //---
    print("++++++++ ENTER LIST Categories ++++++++++ ");
    //----------------------------------------------------------------
    // if (ctx == null) ctx = ctx.dependOnInheritedWidgetOfExactType();

    //.......
    _categories.clear();
    //........

    // try {} catch (e) {
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

          if (_categories.length > 0) {
             print("+++++++++++++ LISt of Category ++++++++++++++++++++++ ");
            //--
            // notifyListeners();
          }
         
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
  }
}
