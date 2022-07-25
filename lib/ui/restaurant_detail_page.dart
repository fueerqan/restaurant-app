import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/local/restaurant.dart';
import 'package:restaurant_app/data/model/local/restaurant_menu.dart';
import 'package:restaurant_app/data/restaurant_data_source.dart';
import 'package:restaurant_app/widgets/description.dart';
import 'package:restaurant_app/widgets/icon_label.dart';
import 'package:restaurant_app/widgets/platforms/platform_widget_builder.dart';
import 'package:restaurant_app/widgets/restaurant_menu_item.dart' as RestoMenu;

class RestaurantDetailPage extends StatelessWidget {
  const RestaurantDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// get restaurant id
    final restaurantId = ModalRoute.of(context)!.settings.arguments as String;

    return PlatformWidgetBuilder(
      iOSBuilder: CupertinoPageScaffold(
        child: _buildBody(context, restaurantId),
      ),
      androidBuilder: Scaffold(
        body: _buildBody(context, restaurantId),
      ),
    );
  }

  FutureBuilder<Restaurant> _buildBody(
      BuildContext context, String restaurantId) {
    return FutureBuilder(
      future: RestaurantDataSource.fetchRestaurantById(context, restaurantId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Center(
                child: Text(snapshot.error.toString()),
              ),
            );
          }

          Restaurant restaurant = snapshot.data as Restaurant;

          return Padding(
            padding: EdgeInsets.only(
                top: (defaultTargetPlatform == TargetPlatform.iOS)
                    ? kTextTabBarHeight
                    : 0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    child: Image.network(restaurant.pictureId),
                  ),
                  _paddingWidget(
                    Text(
                      restaurant.name,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    top: 16.0,
                  ),
                  _paddingWidget(
                    IconLabel(
                      icon: const Icon(
                        Icons.location_on,
                        color: Colors.grey,
                      ),
                      label: Text(
                        restaurant.city,
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              fontWeight: FontWeight.w300,
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    top: 8.0,
                  ),
                  Description(description: restaurant.desciption),
                  ..._buildMenus(context, "Foods", restaurant.menus.foods),
                  ..._buildMenus(context, "Drinks", restaurant.menus.drinks),
                ],
              ),
            ),
          );
        } else {
          return const SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Widget _paddingWidget(
    Widget child, {
    double top = 0.0,
    double right = 16.0,
    double bottom = 0.0,
    double left = 16.0,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        top: top,
        right: right,
        bottom: bottom,
        left: left,
      ),
      child: child,
    );
  }

  List<Widget> _buildMenus(
      BuildContext context, String title, List<RestaurantMenuItem> menus) {
    return [
      _paddingWidget(
          Text(
            title,
            style: Theme.of(context).textTheme.headline6,
          ),
          top: 16),
      _paddingWidget(
        GridView.count(
          padding: const EdgeInsets.only(top: 16),
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: menus
              .map((menu) => RestoMenu.RestaurantMenuItem(
                    name: menu.name,
                    imageUrl: menu.imageUrl,
                    price: menu.price,
                  ))
              .toList(),
        ),
      ),
    ];
  }
}
