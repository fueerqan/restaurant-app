import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:restaurant_app/data/model/ui/restaurant.dart';
import 'package:restaurant_app/domain/restaurant_list_usecase.dart';
import 'package:restaurant_app/domain/restaurant_search_usecase.dart';

part 'list_event.dart';
part 'list_state.dart';

class ListBloc extends Bloc<ListEvent, ListState> {
  ListBloc() : super(ListInitial()) {
    on<FetchRestaurantListEvent>((event, emit) async {
      emit(ListLoadingState());

      final usecase = GetIt.instance<RestaurantListUsecase>();

      try {
        final result = await usecase.fetchRestaurantList();
        emit(ListSuccessState(result));
      } on Exception catch (e) {
        emit(ListFailedState(e.toString()));
      }
    });

    on<SearchRestaurantListEvent>((event, emit) async {
      emit(ListLoadingState());

      final usecase = GetIt.instance<RestaurantSearchUsecase>();

      try {
        final result = await usecase.searchRestaurant(event.query);
        emit(ListSuccessState(result));
      } on Exception catch (e) {
        emit(ListFailedState(e.toString()));
      }
    });
  }
}
