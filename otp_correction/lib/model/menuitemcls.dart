
class MenuItem {
  final int id;
  final String name;
  final String description;
  final String image;
  final int price;

  MenuItem({required this.id, required this.name, required this.description, required this.price, required this.image});

  factory MenuItem.fromMap(Map<String, dynamic> map) {
    return MenuItem(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      image:map['image'],
      price: map['price'],
    );
  }



  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'price': price,
    };
  }


}



