import 'package:restaurant_app/common/url.dart';
import 'package:restaurant_app/data/model/local/restaurant.dart';
import 'package:restaurant_app/data/model/network/restaurant.dart';

class RestaurantUiModel {
  RestaurantUiModel({
    required this.id,
    required this.name,
    required this.desciption,
    required this.pictureId,
    required this.pictureUrl,
    required this.city,
    required this.rating,
  });

  final String id;
  final String name;
  final String desciption;
  final String pictureId;
  final String pictureUrl;
  final String city;
  final num rating;

  RestaurantUiModel.fromLocal(RestaurantLocal restaurant)
      : id = restaurant.id,
        name = restaurant.name,
        desciption = restaurant.desciption,
        pictureId = restaurant.pictureId,
        pictureUrl = Url.image_url_medium
            .replaceFirst("{pictureId}", restaurant.pictureId),
        city = restaurant.city,
        rating = restaurant.rating;

  RestaurantUiModel.fromNetwork(RestaurantNetwork restaurant)
      : id = restaurant.id,
        name = restaurant.name,
        desciption = restaurant.desciption,
        pictureId = restaurant.pictureId,
        pictureUrl = Url.image_url_medium
            .replaceFirst("{pictureId}", restaurant.pictureId),
        city = restaurant.city,
        rating = restaurant.rating;
}
