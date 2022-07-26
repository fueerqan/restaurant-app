import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:restaurant_app/data/model/network/restaurant_detail.dart';
import 'package:restaurant_app/domain/restaurant_detail_usecase.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailBloc() : super(DetailInitial()) {
    on<FetchDetailDataEvent>((event, emit) async {
      emit(DetailLoadingState());

      final RestaurantDetailUsecase usecase =
          GetIt.instance<RestaurantDetailUsecase>();

      try {
        final result = await usecase.fetchRestaurantDetails(event.restaurantId);
        emit(DetailSuccessState(result));
      } on Exception catch (e) {
        emit(DetailFailedState(e.toString()));
      }
    });
  }
}
