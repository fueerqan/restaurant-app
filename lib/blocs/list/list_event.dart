part of 'list_bloc.dart';

@immutable
abstract class ListEvent {}

class FetchRestaurantListEvent extends ListEvent {}

class SearchRestaurantListEvent extends ListEvent {
  SearchRestaurantListEvent(this.query);

  final String query;
}
