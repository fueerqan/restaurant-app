import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:restaurant_app/common/data_source.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/common/routes.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/widgets/platforms/platform_widget_builder.dart';

class RestaurantApp extends StatelessWidget {
  const RestaurantApp({Key? key, required this.dataSource}) : super(key: key);

  final DataSource dataSource;

  @override
  Widget build(BuildContext context) {
    return PlatformWidgetBuilder(
      androidBuilder: MaterialApp(
        title: _getTitle,
        theme: getThemeData,
        initialRoute: _initialRoute,
        navigatorKey: navigatorKey,
        routes: getRoutes(dataSource),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
      ),
      iOSBuilder: CupertinoApp(
        title: _getTitle,
        theme: getCupertinoThemeData,
        initialRoute: _initialRoute,
        navigatorKey: navigatorKey,
        routes: getRoutes(dataSource),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
      ),
    );
  }

  String get _getTitle => "Restaurant App";

  String get _initialRoute => Routes.home;
}
