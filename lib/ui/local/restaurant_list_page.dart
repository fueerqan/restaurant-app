import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/common/routes.dart';
import 'package:restaurant_app/data/model/local/restaurant.dart';
import 'package:restaurant_app/data/model/ui/restaurant.dart';
import 'package:restaurant_app/data/restaurant_data_source.dart';
import 'package:restaurant_app/widgets/platforms/platform_widget_builder.dart';
import 'package:restaurant_app/widgets/restaurant_item.dart';

class RestaurantListPage extends StatefulWidget {
  const RestaurantListPage({Key? key}) : super(key: key);

  @override
  State<RestaurantListPage> createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage> {
  static const int _minCharsToSearch = 3;

  String keywords = "";
  bool isSearching = false;

  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchTapped() {
    setState(() {
      isSearching = true;
    });
  }

  void _onCloseSearch() {
    _searchController.text = "";
    setState(() {
      isSearching = false;
      keywords = "";
    });
  }

  void _onSearching(String words) {
    if (words.length >= _minCharsToSearch) {
      setState(() {
        keywords = words;
      });
    } else if (keywords != "") {
      setState(() {
        keywords = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidgetBuilder(
      iOSBuilder: CupertinoPageScaffold(
        child: _buildBody(context),
      ),
      androidBuilder: Scaffold(
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) => Container(
        padding: const EdgeInsets.only(
          top: kToolbarHeight,
          left: 16,
          right: 16,
          bottom: 0,
        ),
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
            _buildSearchView(),
            FutureBuilder(
              future: RestaurantDataSource.fetchRestaurantList(context,
                  keywords: keywords),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  List<RestaurantLocal> restaurantData =
                      snapshot.data as List<RestaurantLocal>;

                  return Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.only(top: 16, bottom: 16),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => RestaurantItem(
                        restaurant:
                            RestaurantUiModel.fromLocal(restaurantData[index]),
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            Routes.localDetail,
                            arguments: restaurantData[index].id,
                          );
                        },
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

  Widget _buildSearchView() {
    if (isSearching) {
      return PlatformWidgetBuilder(
        iOSBuilder: CupertinoTextField(
          controller: _searchController,
          keyboardType: TextInputType.text,
          onChanged: _onSearching,
          suffix: GestureDetector(
            onTap: _onCloseSearch,
            child: const Icon(Icons.clear),
          ),
          placeholder: "Search restaurant by name or menu...",
        ),
        androidBuilder: TextField(
          controller: _searchController,
          keyboardType: TextInputType.text,
          onChanged: _onSearching,
          decoration: InputDecoration(
            hintText: "Search restaurant by name or menu...",
            suffix: IconButton(
              onPressed: _onCloseSearch,
              icon: const Icon(Icons.clear),
            ),
          ),
        ),
      );
    } else {
      return Align(
        alignment: Alignment.centerRight,
        child: PlatformWidgetBuilder(
          iOSBuilder: GestureDetector(
            onTap: _onSearchTapped,
            child: const Material(
              child: Icon(CupertinoIcons.search, size: 32),
            ),
          ),
          androidBuilder: InkWell(
            onTap: _onSearchTapped,
            child: const Icon(Icons.search, size: 32),
          ),
        ),
      );
    }
  }
}
