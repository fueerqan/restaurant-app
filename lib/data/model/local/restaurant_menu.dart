class RestaurantMenu {
  RestaurantMenu({required this.foods, required this.drinks});

  final List<RestaurantMenuItem> foods;
  final List<RestaurantMenuItem> drinks;

  RestaurantMenu.fromJson(Map<String, dynamic>? json)
      : foods = ((json?["foods"] ?? []) as List)
            .map((item) => RestaurantMenuItem.fromJson(item))
            .toList(),
        drinks = ((json?["drinks"] ?? []) as List)
            .map((item) => RestaurantMenuItem.fromJson(item))
            .toList();
}

class RestaurantMenuItem {
  RestaurantMenuItem({
    required this.name,
    required this.imageUrl,
    required this.price,
  });

  final String name;
  final String imageUrl;
  final String price;

  RestaurantMenuItem.fromJson(Map<String, dynamic>? json)
      : name = json?["name"] ?? "",
        imageUrl = json?["imageUrl"] ?? "",
        price = json?["price"] ?? "";
}
