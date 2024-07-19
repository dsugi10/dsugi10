
// import 'package:delivery/model/cart_itemCls.dart';
// import 'package:delivery/model/menuitemcls.dart';
// import 'package:flutter/material.dart';

// class ProviderCart extends ChangeNotifier {
//   List<CartItem> _items = [];

//   List<CartItem> get items => [..._items];

//   void increment(MenuItem product) {
//     for (var item in _items) {
//       if (item.product.id == product.id) {
//         item.quantity++;
//         notifyListeners();
//         return;
//       }
//     }
//     _items.add(
//         CartItem(product: product, quantity: 1)); // Initialize with quantity 1
//     notifyListeners();
//   }

//   void decrement(MenuItem product) {
//     for (var item in _items) {
//       if (item.product.id == product.id) {
//         item.quantity--;
//         if (item.quantity < 1) {
//           _items.removeWhere((i) => i.product.id == product.id);
//         }
//         notifyListeners();
//         return;
//       }
//     }
//   }
// }
