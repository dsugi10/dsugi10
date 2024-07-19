
import 'package:delivery/model/menucatCls.dart';


class Restaurant {
  final int id;
  final String name;
  final String address;
  final String image;
  final List<MenuCategory> menu;

  Restaurant({required this.id, required this.name, required this.address, required this.menu, required this.image});

  factory Restaurant.fromMap(Map<String, dynamic> map) {
    return Restaurant(
      id: map['id'],
      name: map['name'],
      address: map['address'],
      image: map['image'],
      menu: List<MenuCategory>.from(map['menu']?.map((x) => MenuCategory.fromMap(x))),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'image': image,
      'menu': List<dynamic>.from(menu.map((x) => x.toMap())),
    };
  }
}