import 'package:delivery/model/rescls.dart';

class MenuData {
  final List<Restaurant> restaurants;

  MenuData({required this.restaurants});

  factory MenuData.fromMap(Map<String, dynamic> map) {
    return MenuData(
      restaurants: List<Restaurant>.from(map['restaurants']?.map((x) => Restaurant.fromMap(x))),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'restaurants': List<dynamic>.from(restaurants.map((x) => x.toMap())),
    };
  }
}


