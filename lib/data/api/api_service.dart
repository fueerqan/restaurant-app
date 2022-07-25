import 'dart:convert';

import 'package:restaurant_app/common/url.dart';
import 'package:restaurant_app/data/model/network/network_response.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<NetworkResponse> fetchRestaurantList() async {
    final response = await http.get(Uri.parse(Url.baseUrl + Url.path_list));

    if (response.statusCode == 200) {
      return NetworkResponse.fromJson(
          json.decode(response.body), "restaurants");
    } else {
      return NetworkResponse(
          error: true,
          message: "Failed to load Restaurant List!",
          count: 0,
          founded: 0,
          data: null);
    }
  }
}
