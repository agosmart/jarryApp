import 'package:jariapp/models/product..dart';

class CartItem {
  int idProduct;
  String productName;
  int qty;
  double total;

  CartItem(this.idProduct, this.productName, this.qty, this.total);

  CartItem.fromJson(Map<String, dynamic> jsonObject) {
    /* print('||||||||||||||||||||||||||||');
    print(jsonObject['qty'].runtimeType);
    print((jsonObject['qty']).toInt() );
    print('||||||||||||||||||||||||||||');
    */

    this.idProduct = jsonObject['id'];
    this.productName = jsonObject['productName'];
    this.qty = (jsonObject['qty']).toInt();
    this.total = jsonObject['total'];
    /*
      print('_ _ _ _ _ _ _ * CartItem * _ _ _ _ _ _ _ _ ');
      print('[ product 1 >>>> ] ->  ${jsonObject['product']}');
      print('[ product 1 >>>> ] ->  ${this.product.product_price}');
      print('_ _ _ _ _ _ _ * END / CartItem * _ _ _ _ _ _ _ _ ');
    */
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idProduct'] = this.idProduct;
    data['productName'] = this.productName;
    data['qty'] = this.qty;
    data['total'] = this.total;

    return data;
  }

  // CartItem.toString() {
  //   print('[ product >>>> ] ->  ${this.product}');
  // }
}
