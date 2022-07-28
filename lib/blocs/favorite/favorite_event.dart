part of 'favorite_bloc.dart';

@immutable
abstract class FavoriteEvent {}

class FavoriteFetchListEvent extends FavoriteEvent {
  FavoriteFetchListEvent({
    this.shouldShowSnackbar = false,
    this.snackbarMessage = "",
  });

  final bool shouldShowSnackbar;
  final String snackbarMessage;
}

class RemoveFavoriteRestaurantEvent extends FavoriteEvent {
  RemoveFavoriteRestaurantEvent(this.id, this.name);

  final String id;
  final String name;
}
