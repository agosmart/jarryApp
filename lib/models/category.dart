class Category {
  //++++
  int categoryId;
  String categoryName;
  // int iconId;

  //+++++
  Category({this.categoryId, this.categoryName});

  Category.fromJson(Map<String, dynamic> jsonObject) {
    this.categoryId = jsonObject['familleId'];
    this.categoryName = jsonObject['familleName'];
  }
}
