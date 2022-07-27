import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/blocs/favorite/favorite_bloc.dart';
import 'package:restaurant_app/common/routes.dart';
import 'package:restaurant_app/widgets/platforms/platform_widget_builder.dart';
import 'package:restaurant_app/widgets/restaurant_item.dart';

class RestaurantFavoritePage extends StatefulWidget {
  const RestaurantFavoritePage({Key? key}) : super(key: key);

  @override
  State<RestaurantFavoritePage> createState() => _RestaurantFavoritePageState();
}

class _RestaurantFavoritePageState extends State<RestaurantFavoritePage> {
  static const int _minCharsToSearch = 3;

  bool isSearching = false;
  String keywords = "";

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

  void _onCloseSearch(BuildContext context) {
    _searchController.text = "";
    setState(() {
      isSearching = false;
    });
    if (keywords.length >= _minCharsToSearch) {
      keywords = "";
      FavoriteBloc bloc = BlocProvider.of<FavoriteBloc>(context);
      // bloc.add(FetchRestaurantListEvent());
    }
  }

  void _onSearching(BuildContext context, String words) {
    FavoriteBloc bloc = BlocProvider.of<FavoriteBloc>(context);
    if (words.length >= _minCharsToSearch) {
      keywords = words;
      // bloc.add(SearchRestaurantListEvent(words));
    } else if (_searchController.text != "" &&
        keywords.length >= _minCharsToSearch) {
      keywords = words;
      // bloc.add(FetchRestaurantListEvent());
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

  Widget _buildBody(BuildContext context) => BlocProvider(
        create: (_) => FavoriteBloc()..add(FavoriteFetchListEvent()),
        child: BlocBuilder<FavoriteBloc, FavoriteState>(
          builder: (blocContext, state) {
            return Container(
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
                    "Favorites",
                    style: Theme.of(context).textTheme.headline4?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  _buildSearchView(blocContext),
                  if (state is FavoriteFailedState) _buildFailedView(state),
                  if (state is FavoriteSuccessState) _buildSuccessView(state),
                  if (!(state is FavoriteFailedState ||
                      state is FavoriteSuccessState))
                    _buildLoadingView()
                ],
              ),
            );
          },
        ),
      );

  Expanded _buildLoadingView() {
    return const Expanded(
      child: Center(child: CircularProgressIndicator()),
    );
  }

  Expanded _buildSuccessView(FavoriteSuccessState state) {
    if (state.restaurantList.isEmpty) {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "No favorite restaurants available.",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontSize: 16,
                ),
          ),
        ),
      );
    }
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.only(top: 16, bottom: 16),
        shrinkWrap: true,
        itemBuilder: (context, index) => RestaurantItem(
          restaurant: state.restaurantList[index],
          onTap: () async {
            await Navigator.of(context).pushNamed(
              Routes.networkDetail,
              arguments: state.restaurantList[index].id,
            );

            try {
              // ignore: use_build_context_synchronously
              final bloc = BlocProvider.of<FavoriteBloc>(context);
              bloc.add(FavoriteFetchListEvent());
            } on Exception {
              /// do nothing, just prevent crash
            }
          },
        ),
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemCount: state.restaurantList.length,
      ),
    );
  }

  Expanded _buildFailedView(FavoriteFailedState state) {
    return Expanded(
      child: Center(
        child: Text(
          state.message,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildSearchView(BuildContext context) {
    if (isSearching) {
      return PlatformWidgetBuilder(
        iOSBuilder: CupertinoTextField(
          controller: _searchController,
          keyboardType: TextInputType.text,
          onChanged: (value) => _onSearching(context, value),
          suffix: GestureDetector(
            onTap: () => _onCloseSearch(context),
            child: const Icon(Icons.clear),
          ),
          placeholder: "Search restaurant by name or menu...",
        ),
        androidBuilder: TextField(
          controller: _searchController,
          keyboardType: TextInputType.text,
          onChanged: (value) => _onSearching(context, value),
          decoration: InputDecoration(
            hintText: "Search restaurant by name or menu...",
            suffix: IconButton(
              onPressed: () => _onCloseSearch(context),
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
