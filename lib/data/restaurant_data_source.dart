import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

class RestaurantDataSource {
  Future<String?> _loadJson(BuildContext context) {
    return DefaultAssetBundle.of(context).loadString('assets/restaurant.json');
  }

  Future<List<Restaurant>> fetchRestaurantList(BuildContext context) async {
    final String? mData = await _loadJson(context);

    if (mData == null) {
      return [];
    }

    final List parsedJson = jsonDecode(mData)["restaurants"];
    return parsedJson.map((item) => Restaurant.fromJson(item)).toList();
  }
}
