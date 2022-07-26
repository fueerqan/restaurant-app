import 'dart:convert';

import 'package:restaurant_app/common/network_service.dart';
import 'package:restaurant_app/common/url.dart';
import 'package:restaurant_app/data/model/network/network_response.dart';

class ApiService {
  static Future<NetworkResponse> fetchRestaurantList() async {
    final response =
        await NetworkService.get(Uri.parse(Url.baseUrl + Url.path_list));

    if (response.statusCode == 200) {
      return NetworkResponse.fromJson(
          json.decode(response.body), "restaurants");
    } else {
      return const NetworkResponse(
          error: true,
          message: "Failed to load Restaurant List!",
          count: 0,
          founded: 0,
          data: null);
    }
  }

  static Future<NetworkResponse> fetchRestaurantDetails(String id) async {
    final response = await NetworkService.get(
      Uri.parse(Url.baseUrl + Url.path_detail.replaceFirst("{id}", id)),
    );

    if (response.statusCode == 200) {
      return NetworkResponse.fromJson(json.decode(response.body), "restaurant");
    } else {
      return NetworkResponse(
          error: true,
          message: "Failed to load Restaurant Detail with ID $id!",
          count: 0,
          founded: 0,
          data: null);
    }
  }
}
