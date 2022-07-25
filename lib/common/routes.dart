import 'package:flutter/material.dart';
import 'package:restaurant_app/common/data_source.dart';
import 'package:restaurant_app/ui/local/restaurant_detail_page.dart';
import 'package:restaurant_app/ui/local/restaurant_list_page.dart' as Local;
import 'package:restaurant_app/ui/network/restaurant_list_page.dart' as Network;

Map<String, WidgetBuilder> getRoutes(DataSource source) => {
      "/": (context) => (source == DataSource.local)
          ? const Local.RestaurantListPage()
          : const Network.RestaurantListPage(),
      "/local-detail": (context) => const RestaurantDetailPage(),
    };

class Routes {
  static const String home = "/";
  static const String localDetail = "/local-detail";
}
