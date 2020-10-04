class Category {
  //++++
  int familleId;
  String familleName;
  // int iconId;

  //+++++
  Category({this.familleId, this.familleName});

  Category.fromJson(Map<String, dynamic> jsonObject) {
    this.familleId = jsonObject['familleId'];
    this.familleName = jsonObject['familleName'];
  }
}
