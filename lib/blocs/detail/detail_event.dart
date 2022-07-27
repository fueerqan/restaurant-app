part of 'detail_bloc.dart';

@immutable
abstract class DetailEvent {}

class FetchDetailDataEvent extends DetailEvent {
  FetchDetailDataEvent(this.restaurantId);

  final String restaurantId;
}

class AddToFavoriteEvent extends DetailEvent {
  AddToFavoriteEvent(this.currentRestaurantDetail);

  final RestaurantDetailNetwork currentRestaurantDetail;
}

class RemoveFromFavoriteEvent extends DetailEvent {
  RemoveFromFavoriteEvent(this.currentRestaurantDetail);

  final RestaurantDetailNetwork currentRestaurantDetail;
}
