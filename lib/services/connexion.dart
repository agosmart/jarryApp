import 'dart:convert';
import 'package:http/http.dart' as http;

class Connexion {
  //.....

  bool _isLoggedIn = false;
  String apiURL = '127.0.0.1';
  String tokenValue = '123';
//......

  Future<bool> logIn(String param1, int param2) async {
    try {
      final _headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $tokenValue',
      };

      final _body = jsonEncode(
        <String, dynamic>{'data': param1, 'password': param2},
      );

      final http.Response response =
          await http.post(apiURL, body: _body, headers: _headers);

      Map<String, dynamic> responseJson;

      if (response.statusCode == 200) {
        //-------------------------------
        responseJson = jsonDecode(response.body);
        //-----------------------------------
        var result = responseJson['data'];

        _isLoggedIn = result.user != null ? true : false;

        //.....

      }
      return _isLoggedIn;
    } catch (e) {
      print('error ::::  An error occured');

      return Future.value(false);
    }

    //+++++++++++++++++++++++++++++++++
  }
}
