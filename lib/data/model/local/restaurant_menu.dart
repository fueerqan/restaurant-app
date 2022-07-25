class RestaurantMenuLocal {
  RestaurantMenuLocal({required this.foods, required this.drinks});

  final List<RestaurantMenuItemLocal> foods;
  final List<RestaurantMenuItemLocal> drinks;

  RestaurantMenuLocal.fromJson(Map<String, dynamic>? json)
      : foods = ((json?["foods"] ?? []) as List)
            .map((item) => RestaurantMenuItemLocal.fromJson(item))
            .toList(),
        drinks = ((json?["drinks"] ?? []) as List)
            .map((item) => RestaurantMenuItemLocal.fromJson(item))
            .toList();
}

class RestaurantMenuItemLocal {
  RestaurantMenuItemLocal({
    required this.name,
    required this.imageUrl,
    required this.price,
  });

  final String name;
  final String imageUrl;
  final String price;

  RestaurantMenuItemLocal.fromJson(Map<String, dynamic>? json)
      : name = json?["name"] ?? "",
        imageUrl = json?["imageUrl"] ?? "",
        price = json?["price"] ?? "";
}
