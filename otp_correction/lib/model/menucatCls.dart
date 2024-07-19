// import 'package:delivery/model/menuitemcls.dart';



import 'package:delivery/model/menuitemcls.dart';

class MenuCategory {
  final int id;
  final String category;
  final List<MenuItem> items;

  MenuCategory({required this.id, required this.category, required this.items});

  factory MenuCategory.fromMap(Map<String, dynamic> map) {
    return MenuCategory(
      id: map['id'],
      category: map['category'],
      items: List<MenuItem>.from(map['items']?.map((x) => MenuItem.fromMap(x))),//
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'items': List<dynamic>.from(items.map((x) => x.toMap())),//
    };
  }
}