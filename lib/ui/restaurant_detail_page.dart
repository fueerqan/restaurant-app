import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/model/restaurant_menu.dart';
import 'package:restaurant_app/data/restaurant_data_source.dart';
import 'package:restaurant_app/widgets/icon_label.dart';
import 'package:restaurant_app/widgets/restaurant_menu_item.dart' as RestoMenu;

class RestaurantDetailPage extends StatelessWidget {
  const RestaurantDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // get restaurant id
    final restaurantId = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      body: FutureBuilder(
        future: RestaurantDataSource.fetchRestaurantById(context, restaurantId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }

            Restaurant restaurant = snapshot.data as Restaurant;

            return Padding(
              padding: const EdgeInsets.only(top: kTextTabBarHeight),
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
                          style:
                              Theme.of(context).textTheme.bodyText1?.copyWith(
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
                    ..._buildDescription(context, restaurant.desciption),
                    ..._buildMenus(context, "Foods", restaurant.menus.foods),
                    ..._buildMenus(context, "Drinks", restaurant.menus.drinks),
                  ],
                ),
              ),
            );
          } else {
            return const Expanded(
                child: Center(child: CircularProgressIndicator()));
          }
        },
      ),
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

  List<Widget> _buildDescription(BuildContext context, String description) {
    return [
      _paddingWidget(
        Text(
          "Description",
          style: Theme.of(context).textTheme.headline6,
        ),
        top: 24.0,
      ),
      _paddingWidget(
        Text(
          description,
          textAlign: TextAlign.justify,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        top: 8.0,
        bottom: 24.0,
      ),
    ];
  }

  List<Widget> _buildMenus(
      BuildContext context, String title, List<RestaurantMenuItem> menus) {
    return [
      _paddingWidget(Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      )),
      _paddingWidget(
        GridView.count(
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
