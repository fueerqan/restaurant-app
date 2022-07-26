import 'package:restaurant_app/common/url.dart';

class RestaurantDetailNetwork {
  RestaurantDetailNetwork({
    required this.id,
    required this.name,
    required this.desciption,
    required this.pictureId,
    required this.pictureUrl,
    required this.city,
    required this.rating,
    required this.categories,
    required this.menus,
    required this.reviews,
  });

  final String id;
  final String name;
  final String desciption;
  final String pictureId;
  final String pictureUrl;
  final String city;
  final num rating;
  final List<RestaurantDetailNameNetwork> categories;
  final RestaurantDetailMenuNetwork menus;
  final List<RestaurantDetailReviewNetwork> reviews;

  RestaurantDetailNetwork.fromJson(Map<String, dynamic>? json)
      : id = json?["id"] ?? "",
        name = json?["name"] ?? "",
        desciption = json?["description"] ?? "",
        pictureId = json?["pictureId"] ?? "",
        pictureUrl = Url.image_url_medium
            .replaceFirst("{pictureId}", json?["pictureId"] ?? ""),
        city = json?["city"] ?? "",
        rating = json?["rating"] ?? 0.0,
        categories = ((json?["categories"] ?? []) as List)
            .map((e) => RestaurantDetailNameNetwork.fromJson(e))
            .toList(),
        menus = RestaurantDetailMenuNetwork.fromJson(json?["menus"]),
        reviews = ((json?["customerReviews"] ?? []) as List)
            .map((e) => RestaurantDetailReviewNetwork.fromJson(e))
            .toList();
}

class RestaurantDetailNameNetwork {
  RestaurantDetailNameNetwork({required this.name});

  final String name;

  RestaurantDetailNameNetwork.fromJson(Map<String, dynamic>? json)
      : name = json?["name"] ?? "";
}

class RestaurantDetailMenuNetwork {
  RestaurantDetailMenuNetwork({required this.foods, required this.drinks});

  final List<RestaurantDetailNameNetwork> foods;
  final List<RestaurantDetailNameNetwork> drinks;

  RestaurantDetailMenuNetwork.fromJson(Map<String, dynamic>? json)
      : foods = ((json?["foods"] ?? []) as List)
            .map((e) => RestaurantDetailNameNetwork.fromJson(e))
            .toList(),
        drinks = ((json?["drinks"] ?? []) as List)
            .map((e) => RestaurantDetailNameNetwork.fromJson(e))
            .toList();
}

class RestaurantDetailReviewNetwork {
  RestaurantDetailReviewNetwork({
    required this.name,
    required this.review,
    required this.date,
  });

  final String name;
  final String review;
  final String date;

  RestaurantDetailReviewNetwork.fromJson(Map<String, dynamic>? json)
      : name = json?["name"] ?? "",
        review = json?["review"] ?? "",
        date = json?["date"] ?? "";
}
