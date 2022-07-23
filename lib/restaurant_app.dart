import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/common/routes.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/widgets/platforms/platform_widget_builder.dart';

class RestaurantApp extends StatelessWidget {
  const RestaurantApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformWidgetBuilder(
      androidBuilder: MaterialApp(
        title: _getTitle,
        theme: getThemeData,
        initialRoute: _initialRoute,
        routes: getRoutes,
      ),
      iOSBuilder: CupertinoApp(
        title: _getTitle,
        theme: getCupertinoThemeData,
        initialRoute: _initialRoute,
        routes: getRoutes,
      ),
    );
  }

  String get _getTitle => "Restaurant App";

  String get _initialRoute => "/";
}
