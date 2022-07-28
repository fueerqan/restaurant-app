import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/model/ui/restaurant.dart';
import 'package:restaurant_app/utils/database/database_helper.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteInitial()) {
    on<FavoriteFetchListEvent>((event, emit) async {
      emit(FavoriteLoadingState());

      final _dbHelper = DatabaseHelper();

      try {
        final restaurantList = await _dbHelper.getFavoriteRestaurants();
        emit(FavoriteSuccessState(
          restaurantList,
          shouldShowSnackbar: event.shouldShowSnackbar,
          snackBarMessage: event.snackbarMessage,
        ));
      } on Exception catch (e) {
        emit(FavoriteFailedState("Failed to load favorite restaurant!"));
        if (kDebugMode) {
          print(e);
        }
      }
    });

    on<RemoveFavoriteRestaurantEvent>((event, emit) async {
      final _dbHelper = DatabaseHelper();

      try {
        await _dbHelper.removeFavorite(event.id);
        add(FavoriteFetchListEvent(
          shouldShowSnackbar: true,
          snackbarMessage: "Restaurant ${event.name} removed from favorite!",
        ));
      } on Exception catch (e) {
        if (kDebugMode) {
          print(e);
        }
        add(FavoriteFetchListEvent(
          shouldShowSnackbar: true,
          snackbarMessage: "Failed to remove ${event.name} from favorite!",
        ));
      }
    });
  }
}
