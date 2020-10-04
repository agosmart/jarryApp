class Product {
  //++++

  int productId;
  String productName;
  int familleId;
  double unitPrice;
  int minimumOrder;
  String image;

  //+++++
  Product(
      {this.productId,
      this.productName,
      this.familleId,
      this.unitPrice,
      this.minimumOrder,
      this.image});

  Product.fromJson(Map<String, dynamic> jsonObject) {
    this.productId = jsonObject['productId'];
    this.productName = jsonObject['productName'];
    this.familleId = jsonObject['familleId'];
    this.unitPrice = jsonObject['unitPrice'];
    this.minimumOrder = jsonObject['minimumOrder'];
    this.image = jsonObject['image'];
  }
}
