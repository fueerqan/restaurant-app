class RestaurantNetwork {
  RestaurantNetwork({
    required this.id,
    required this.name,
    required this.desciption,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  final String id;
  final String name;
  final String desciption;
  final String pictureId;
  final String city;
  final num rating;

  RestaurantNetwork.fromJson(Map<String, dynamic>? json)
      : id = json?["id"] ?? "",
        name = json?["name"] ?? "",
        desciption = json?["description"] ?? "",
        pictureId = json?["pictureId"] ?? "",
        city = json?["city"] ?? "",
        rating = json?["rating"] ?? 0.0;
}
