import 'package:jariapp/models/product..dart';

class CartItem {
  int productId;
  String productName;
  int qty;
  double priceUnit;
  double priceTotal;
  String image;

  CartItem(this.productId, this.productName, this.qty, this.priceUnit,
      this.priceTotal, this.image);

  CartItem.fromJson(Map<String, dynamic> jsonObject) {
    /* print('||||||||||||||||||||||||||||');
    print(jsonObject['qty'].runtimeType);
    print((jsonObject['qty']).toInt() );
    print('||||||||||||||||||||||||||||');
    */

    this.productId = jsonObject['id'];
    this.productName = jsonObject['productName'];
    this.qty = (jsonObject['qty']).toInt();
    this.priceUnit = jsonObject['priceUnit'];
    this.priceTotal = jsonObject['priceTotal'];
    this.image = jsonObject['image'];

    /*
      print('_ _ _ _ _ _ _ * CartItem * _ _ _ _ _ _ _ _ ');
      print('[ product 1 >>>> ] ->  ${jsonObject['product']}');
      print('[ product 1 >>>> ] ->  ${this.product.product_price}');
      print('_ _ _ _ _ _ _ * END / CartItem * _ _ _ _ _ _ _ _ ');
    */
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productId;
    data['productName'] = this.productName;
    data['qty'] = this.qty;
    data['priceUnit'] = this.priceUnit;
    data['priceTotal'] = this.priceTotal;

    return data;
  }

  // CartItem.toString() {
  //   print('[ product >>>> ] ->  ${this.product}');
  // }
}
