import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/restaurant_data_source.dart';
import 'package:restaurant_app/widgets/restaurant_item.dart';

class RestaurantListPage extends StatelessWidget {
  const RestaurantListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) => Container(
        padding: const EdgeInsets.only(
            top: kToolbarHeight, left: 16, right: 16, bottom: 0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Restaurant",
              style: Theme.of(context).textTheme.headline4?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(
              "Recommendation restaurant for you",
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            FutureBuilder(
              future: RestaurantDataSource.fetchRestaurantList(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  List<Restaurant> restaurantData =
                      snapshot.data as List<Restaurant>;

                  return Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) => RestaurantItem(
                        restaurant: restaurantData[index],
                        onTap: () {},
                      ),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 8),
                      itemCount: restaurantData.length,
                    ),
                  );
                } else {
                  return const Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
              },
            ),
          ],
        ),
      );
}
