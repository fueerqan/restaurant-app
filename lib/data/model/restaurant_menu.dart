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
  RestaurantMenuItem({required this.name});

  final String name;

  RestaurantMenuItem.fromJson(Map<String, dynamic>? json)
      : name = json?["name"] ?? "";
}
