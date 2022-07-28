import 'package:flutter/material.dart';
import 'package:restaurant_app/common/data_source.dart';
import 'package:restaurant_app/ui/local/restaurant_detail_page.dart'
    as local_detail;
import 'package:restaurant_app/ui/local/restaurant_list_page.dart'
    as local_list;
import 'package:restaurant_app/ui/network/restaurant_detail_page.dart'
    as network_detail;
import 'package:restaurant_app/ui/network/restaurant_favorite_page.dart';
import 'package:restaurant_app/ui/network/restaurant_list_page.dart'
    as network_list;
import 'package:restaurant_app/ui/settings_page.dart';

Map<String, WidgetBuilder> getRoutes(DataSource source) => {
      Routes.home: (context) => (source == DataSource.local)
          ? const local_list.RestaurantListPage()
          : const network_list.RestaurantListPage(),
      Routes.localDetail: (context) =>
          const local_detail.RestaurantDetailPage(),
      Routes.networkDetail: (context) =>
          const network_detail.RestaurantDetailPage(),
      Routes.favoriteList: (context) => const RestaurantFavoritePage(),
      Routes.settings: (context) => const SettingsPage(),
    };

class Routes {
  static const String home = "/";
  static const String localDetail = "/local-detail";
  static const String networkDetail = "/network-detail";
  static const String favoriteList = "/favorites";
  static const String settings = "/settings";
}
