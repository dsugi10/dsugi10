
// import 'package:delivery/model/menuitemcls.dart';

// class CartItem {
//   final MenuItem product;
//   int quantity;

//   CartItem({required this.product, this.quantity=0});




 
// }//og

















// class CartItem {
//   final MenuItem product;
//   int quantity;

//   CartItem({required this.product, this.quantity = 0});

//   factory CartItem.fromJson(Map<String, dynamic> json) {
//     return CartItem(
//       product: MenuItem.fromJson(json['product']),
//       quantity: json['quantity'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'product': product.toJson(),
//       'quantity': quantity,
//     };
//   }
// }

















import 'package:delivery/model/menuitemcls.dart';

class CartItem {
  final MenuItem product;
  int quantity;

  CartItem({
    required this.product,
    required this.quantity,
  });

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      product: MenuItem.fromMap(map['product']),
      quantity: map['quantity'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'product': product.toMap(),
      'quantity': quantity,
    };
  }
}
