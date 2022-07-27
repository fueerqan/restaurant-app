part of 'detail_bloc.dart';

abstract class DetailState {}

class DetailInitial extends DetailState {}

class DetailLoadingState extends DetailState {}

class DetailFailedState extends DetailState {
  DetailFailedState(this.message);

  final String message;
}

class DetailSuccessState extends DetailState {
  DetailSuccessState(this.details, {this.isLoadingFavorite = false});

  final RestaurantDetailNetwork details;
  final bool isLoadingFavorite;
}
