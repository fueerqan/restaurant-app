

import 'package:restaurant_app/data/model/local/restaurant_menu.dart';

class RestaurantLocal {
  RestaurantLocal({
    required this.id,
    required this.name,
    required this.desciption,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.menus,
  });

  final String id;
  final String name;
  final String desciption;
  final String pictureId;
  final String city;
  final num rating;
  final RestaurantMenuLocal menus;

  RestaurantLocal.fromJson(Map<String, dynamic>? json)
      : id = json?["id"] ?? "",
        name = json?["name"] ?? "",
        desciption = json?["description"] ?? "",
        pictureId = json?["pictureId"] ?? "",
        city = json?["city"] ?? "",
        rating = json?["rating"] ?? 0.0,
        menus = RestaurantMenuLocal.fromJson(json?["menus"]);
}
