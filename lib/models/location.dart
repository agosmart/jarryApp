// String locality; // APC
// String administrativeArea; // Daira
// String departement;
// String city; // la ville
// String state; //  Wilaya
// String country; //

class StateArea {
  String stateName;
  int id;
//  State({this.id, this.stateName});

  StateArea.fromJson(Map<String, dynamic> objJson) {
    this.id = objJson['id'];
    this.stateName = objJson['wilayaName'];
  }
}

class AdministrativeArea {
  String adminAreaName;
  int id;
//  AdministrativeArea({this.id, this.adminAreaName});
  AdministrativeArea.fromJson(Map<String, dynamic> objJson) {
    this.id = objJson['id'];
    this.adminAreaName = objJson['dairaName'];
  }
}

class Locality {
  String localityName;
  int id;
  // Locality({this.id, this.localityName});

  Locality.fromJson(Map<String, dynamic> objJson) {
    this.id = objJson['id'];
    this.localityName = objJson['communeName'];
  }
}
