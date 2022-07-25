part of 'list_bloc.dart';

@immutable
abstract class ListState {}

class ListInitial extends ListState {}

class ListLoadingState extends ListState {}

class ListFailedState extends ListState {
  ListFailedState(this.message);

  final String message;
}

class ListSuccessState extends ListState {
  ListSuccessState(this.restaurantList);

  final List<RestaurantUiModel> restaurantList;
}
