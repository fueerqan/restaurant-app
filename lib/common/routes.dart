import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/restaurant_list_page.dart';

Map<String, WidgetBuilder> get getRoutes => {
      "/": (context) => const RestaurantListPage(),
    };
