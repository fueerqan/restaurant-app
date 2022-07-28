import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:restaurant_app/common/url.dart';
import 'package:restaurant_app/data/model/network/restaurant_detail.dart';
import 'package:restaurant_app/data/model/ui/restaurant.dart';
import 'package:restaurant_app/domain/restaurant_detail_usecase.dart';
import 'package:restaurant_app/utils/database/database_helper.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailBloc() : super(DetailInitial()) {
    on<FetchDetailDataEvent>((event, emit) async {
      emit(DetailLoadingState());

      final RestaurantDetailUsecase usecase =
          GetIt.instance<RestaurantDetailUsecase>();
      final dbHelper = DatabaseHelper();

      try {
        final result = await usecase.fetchRestaurantDetails(event.restaurantId);
        result.isFavorite = await dbHelper.isFavoriteRestaurant(result.id);

        emit(DetailSuccessState(result));
      } on Exception catch (e) {
        emit(DetailFailedState(e.toString()));
      }
    });

    on<AddToFavoriteEvent>((event, emit) async {
      emit(DetailSuccessState(event.currentRestaurantDetail,
          isLoadingFavorite: true));

      final dbHelper = DatabaseHelper();

      try {
        final detailModel = event.currentRestaurantDetail;
        final restaurantUiModel = RestaurantUiModel(
          id: detailModel.id,
          name: detailModel.name,
          desciption: detailModel.desciption,
          pictureId: detailModel.pictureId,
          pictureUrl: Url.image_url_medium
              .replaceFirst("{pictureId}", detailModel.pictureId),
          city: detailModel.city,
          rating: detailModel.rating,
        );

        await dbHelper.addToFavorite(restaurantUiModel);
        event.currentRestaurantDetail.isFavorite = true;
        emit(DetailSuccessState(event.currentRestaurantDetail));
      } on Exception {
        event.currentRestaurantDetail.isFavorite = false;
        emit(DetailSuccessState(event.currentRestaurantDetail));
      }
    });

    on<RemoveFromFavoriteEvent>((event, emit) async {
      emit(DetailSuccessState(event.currentRestaurantDetail,
          isLoadingFavorite: true));

      final dbHelper = DatabaseHelper();

      try {
        await dbHelper.removeFavorite(event.currentRestaurantDetail.id);
        event.currentRestaurantDetail.isFavorite = false;
        emit(DetailSuccessState(event.currentRestaurantDetail));
      } on Exception {
        event.currentRestaurantDetail.isFavorite = true;
        emit(DetailSuccessState(event.currentRestaurantDetail));
      }
    });
  }
}
