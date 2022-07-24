import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

class RestaurantDataSource {
  static Future<String?> _loadJson(BuildContext context) {
    return DefaultAssetBundle.of(context).loadString('assets/restaurant.json');
  }

  static Future<List<Restaurant>> fetchRestaurantList(
      BuildContext context) async {
    final String? mData = await _loadJson(context);

    if (mData == null) {
      return [];
    }

    final Map<String, dynamic> parsedJson = jsonDecode(mData);

    return (parsedJson["restaurants"] as List)
        .map((item) => Restaurant.fromJson(item))
        .toList();
  }

  static Future<Restaurant> fetchRestaurantById(
      BuildContext context, String id) async {
    final List<Restaurant> restaurantList = await fetchRestaurantList(context);
    return restaurantList.firstWhere((element) => element.id == id);
  }
}
