class Deliver {
  //+++++++++++++++
  int deliverId;
  String lastName;
  String firstName;
  String phone1;
  String phone2;
  double latitude;
  double longitude;
//+++++++++++++++
  Deliver({
    this.deliverId,
    this.lastName,
    this.firstName,
    this.phone1,
    this.phone2,
    this.latitude,
    this.longitude,
  });
//+++++++++++
  Deliver.fromJson(Map<String, dynamic> objMap) {
    this.deliverId = objMap['livreurId'];
    this.lastName = objMap['lastname'];
    this.firstName = objMap['firstname'];
    this.phone1 = objMap['mobile1'];
    this.phone2 = objMap['mobile2'];
    this.latitude = double.tryParse(objMap['latitude']).toDouble();
    this.longitude = double.tryParse(objMap['longitude']).toDouble();
  }
}
