// String locality; // APC
// String administrativeArea; // Daira
// String departement;
// String city; // la ville
// String state; //  Wilaya
// String country; //

// class MyResponse {
//   String status;
//   int code;
//   String message;
//   List<StateArea> data;

//   MyResponse({this.code, this.message, this.status, this.data});

//   MyResponse.fromJson(Map<String, dynamic> obj) {
//     this.code = obj['code'];
//     this.status = obj['status'];
//     this.message = obj['message'];

//     this.data = [];

//     if (obj['data'] != null) {
//       List<dynamic> statesMap = obj['data'];
//       //.............................
//       _setstateArea(statesMap);
//       //.............................
//     }
//   }

//   _setstateArea(List<dynamic> statesJson) {
//     if (statesJson.length > 0) {
//       for (var state in statesJson) {
//         if (state != null) {
//           data.add(StateArea.fromJson(state));
//         }
//       }
//     }
//   }
// }

class StateArea {
  //+++++
  String stateName;
  int id;
  //+++++
  StateArea({this.id, this.stateName});
  //+++++
  StateArea.fromJson(Map<String, dynamic> objJson) {
    this.id = objJson['id'];
    this.stateName = objJson['wilayaName'];
  }
  //+++++
  toJson() {
    var data = {};
    data['id'] = this.id;
    data['willayaName'] = this.stateName;
    return data;
  }
}

class CityArea {
  //+++++
  int id;
  String cityName;
  //+++++
  CityArea({this.id, this.cityName});
  //+++++
  CityArea.fromJson(Map<String, dynamic> objJson) {
    this.id = objJson['id'];
    this.cityName = objJson['dairaName'];
  }
  //+++++
  toJson() {
    var data = {};
    data['id'] = this.id;
    data['dairaName'] = this.cityName;
    return data;
  }
}

class LocalityArea {
  //+++++
  String localityName;
  int id;
  //+++++
  LocalityArea({this.id, this.localityName});
  //+++++
  LocalityArea.fromJson(Map<String, dynamic> objJson) {
    this.id = objJson['id'];
    this.localityName = objJson['communeName'];
  }
  //+++++
  toJson() {
    var data = {};
    data['id'] = this.id;
    data['communeName'] = this.localityName;
    return data;
  }
}
