import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:restaurant_app/data/model/local/restaurant.dart';

class RestaurantDataSource {
  static Future<String?> _loadJson(BuildContext context) {
    return DefaultAssetBundle.of(context).loadString('assets/restaurant.json');
  }

  static List<RestaurantLocal> filterByKeywords(
      List<RestaurantLocal> restaurants, String keywords) {
    final String lowerCasedKeywords = keywords.toLowerCase();
    return restaurants
        .where((element) =>
            element.name.toLowerCase().contains(lowerCasedKeywords) ||
            element.menus.foods
                .where((food) =>
                    food.name.toLowerCase().contains(lowerCasedKeywords))
                .toList()
                .isNotEmpty ||
            element.menus.drinks
                .where((drink) =>
                    drink.name.toLowerCase().contains(lowerCasedKeywords))
                .toList()
                .isNotEmpty)
        .toList();
  }

  static Future<List<RestaurantLocal>> fetchRestaurantList(
    BuildContext context, {
    String keywords = "",
  }) async {
    final String? mData = await _loadJson(context);

    if (mData == null) {
      return [];
    }

    final Map<String, dynamic> parsedJson = jsonDecode(mData);
    List<RestaurantLocal> restaurantList = (parsedJson["restaurants"] as List)
        .map((item) => RestaurantLocal.fromJson(item))
        .toList();

    if (keywords != "") {
      restaurantList = filterByKeywords(restaurantList, keywords);
    }

    return restaurantList;
  }

  static Future<RestaurantLocal> fetchRestaurantById(
      BuildContext context, String id) async {
    final List<RestaurantLocal> restaurantList = await fetchRestaurantList(context);
    return restaurantList.firstWhere((element) => element.id == id);
  }
}
