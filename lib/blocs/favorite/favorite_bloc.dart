import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/common/database/database_helper.dart';
import 'package:restaurant_app/data/model/ui/restaurant.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteInitial()) {
    on<FavoriteFetchListEvent>((event, emit) async {
      emit(FavoriteLoadingState());

      final _dbHelper = DatabaseHelper();

      try {
        final restaurantList = await _dbHelper.getFavoriteRestaurants();
        emit(FavoriteSuccessState(restaurantList));
      } on Exception catch (e) {
        emit(FavoriteFailedState("Failed to load favorite restaurant!"));
        if (kDebugMode) {
          print(e);
        }
      }
    });
  }
}
