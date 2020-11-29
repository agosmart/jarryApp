import 'dart:convert';

import 'package:jarryApp/models/cart.item.dart';

class Cart {
  int id;
  List<CartItem> cartItems;
  double total;

  Cart(this.id, this.cartItems, this.total);

  Cart.formJson(Map<String, dynamic> jsonObject) {
    cartItems = [];

    // print('cartItems[0] ::-> ${items[1]['product']}');
    // print('cartItems product->id ::-> ${items[1]['product']['product_id']}');

    this.id = jsonObject['id'];
    this.total = jsonObject['total'];

    var items = jsonDecode(jsonObject['cart_items']);
    for (var item in items) {
      // print('_ _ _ _ _ _ _ * Cart * _ _ _ _ _ _ _ _ ');
      // print('cartItems Price ::-> ${CartItem.fromJson(item).product.product_total}');
      // print('_ _ _ _ _ _ _* END Cart * _ _ _ _ _ _ _ _ ');
      this.cartItems.add(CartItem.fromJson(item));
    }
  }
}
