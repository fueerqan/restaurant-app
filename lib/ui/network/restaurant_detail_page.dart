import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/blocs/detail/detail_bloc.dart';
import 'package:restaurant_app/data/model/network/restaurant_detail.dart';
import 'package:restaurant_app/data/model/ui/restaurant_menu.dart';
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

  Widget _buildBody(BuildContext context, String restaurantId) {
    return BlocProvider(
      create: (_) => DetailBloc()
        ..add(
          FetchDetailDataEvent(restaurantId),
        ),
      child: BlocBuilder<DetailBloc, DetailState>(
        builder: (context, state) {
          if (state is DetailFailedState) {
            return SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Center(
                child: Text(state.message.toString()),
              ),
            );
          } else if (state is DetailSuccessState) {
            RestaurantDetailNetwork restaurant = state.details;

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
                      child: Image.network(restaurant.pictureUrl),
                    ),
                    _paddingWidget(
                      Text(
                        restaurant.name,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      top: 16.0,
                    ),
                    _paddingWidget(
                      Row(
                        children: [
                          Expanded(
                            child: IconLabel(
                              icon: const Icon(
                                Icons.location_on,
                                color: Colors.grey,
                              ),
                              label: Text(
                                restaurant.city,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.copyWith(
                                      fontWeight: FontWeight.w300,
                                      color: Colors.grey,
                                      fontSize: 16,
                                    ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ),
                          Expanded(
                            child: IconLabel(
                              icon: const Icon(
                                Icons.star,
                                color: Colors.orange,
                              ),
                              label: Text(
                                restaurant.rating.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.copyWith(
                                      fontWeight: FontWeight.w300,
                                      color: Colors.grey,
                                      fontSize: 16,
                                    ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                      top: 8.0,
                    ),
                    Description(description: restaurant.desciption),
                    ..._buildMenus(
                      context,
                      "Foods",
                      restaurant.menus.foods
                          .map((e) => RestaurantMenuUiModel(
                              name: e.name,
                              imageUrl:
                                  "https://restaurant-api.dicoding.dev/images/medium/14",
                              price: "Rp15.000"))
                          .toList(),
                    ),
                    ..._buildMenus(
                      context,
                      "Drinks",
                      restaurant.menus.drinks
                          .map((e) => RestaurantMenuUiModel(
                              name: e.name,
                              imageUrl:
                                  "https://restaurant-api.dicoding.dev/images/medium/14",
                              price: "Rp15.000"))
                          .toList(),
                    ),
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

  List<Widget> _buildMenus(
      BuildContext context, String title, List<RestaurantMenuUiModel> menus) {
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
