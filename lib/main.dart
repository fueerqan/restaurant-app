import 'package:flutter/material.dart';
import 'package:restaurant_app/common/data_source.dart';
import 'package:restaurant_app/domain/restaurant_detail_usecase.dart';
import 'package:restaurant_app/domain/restaurant_list_usecase.dart';
import 'package:restaurant_app/domain/restaurant_search_usecase.dart';
import 'package:restaurant_app/restaurant_app.dart';
import 'package:get_it/get_it.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initApp();
  runApp(const RestaurantApp(
    dataSource: DataSource.network,
  ));
}

void initApp() {
  final getIt = GetIt.instance;
  getIt.registerFactory<RestaurantListUsecase>(() => RestaurantListUsecase());
  getIt.registerFactory<RestaurantSearchUsecase>(() => RestaurantSearchUsecase());
  getIt.registerFactory<RestaurantDetailUsecase>(
      () => RestaurantDetailUsecase());
}
