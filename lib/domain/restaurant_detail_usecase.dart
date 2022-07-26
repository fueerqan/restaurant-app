import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/network/restaurant_detail.dart';

class RestaurantDetailUsecase {
  Future<RestaurantDetailNetwork> fetchRestaurantDetails(String id) async {
    final networkResponse = await ApiService.fetchRestaurantDetails(id);

    if (!networkResponse.error) {
      final RestaurantDetailNetwork restaurantDetail =
          RestaurantDetailNetwork.fromJson(networkResponse.data?["data"]);
      return restaurantDetail;
    } else {
      throw Exception(networkResponse.message);
    }
  }
}
