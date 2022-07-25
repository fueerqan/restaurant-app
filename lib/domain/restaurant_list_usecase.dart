import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/network/restaurant.dart';
import 'package:restaurant_app/data/model/ui/restaurant.dart';

class RestaurantListUsecase {
  Future<List<RestaurantUiModel>> fetchRestaurantList() async {
    final networkResponse = await ApiService.fetchRestaurantList();

    if (!networkResponse.error) {
      final List<RestaurantNetwork> restaurantList =
          ((networkResponse.data?["data"] ?? []) as List<Map<String, dynamic>>)
              .map((e) => RestaurantNetwork.fromJson(e))
              .toList();

      return restaurantList
          .map((e) => RestaurantUiModel.fromNetwork(e))
          .toList();
    } else {
      throw Exception(networkResponse.message);
    }
  }
}
