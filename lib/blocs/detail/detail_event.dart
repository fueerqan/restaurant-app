part of 'detail_bloc.dart';

@immutable
abstract class DetailEvent {}

class FetchDetailDataEvent extends DetailEvent {
  FetchDetailDataEvent(this.restaurantId);

  final String restaurantId;
}
