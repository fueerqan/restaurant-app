part of 'favorite_bloc.dart';

@immutable
abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoadingState extends FavoriteState {}

class FavoriteFailedState extends FavoriteState {
  FavoriteFailedState(this.message);

  final String message;
}

class FavoriteSuccessState extends FavoriteState {
  FavoriteSuccessState(
    this.restaurantList, {
    this.shouldShowSnackbar = false,
    this.snackBarMessage = "",
  });

  final List<RestaurantUiModel> restaurantList;
  final bool shouldShowSnackbar;
  final String snackBarMessage;
}
