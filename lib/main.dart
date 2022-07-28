import 'dart:isolate';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_app/common/data_source.dart';
import 'package:restaurant_app/domain/restaurant_detail_usecase.dart';
import 'package:restaurant_app/domain/restaurant_list_usecase.dart';
import 'package:restaurant_app/domain/restaurant_search_usecase.dart';
import 'package:restaurant_app/restaurant_app.dart';
import 'package:get_it/get_it.dart';
import 'package:restaurant_app/utils/background/background_service.dart';
import 'package:restaurant_app/utils/notification/notification_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
const alarmId = 1111;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();

  initApp();

  runApp(const RestaurantApp(
    dataSource: DataSource.network,
  ));

  setupPeriodicRandomRestaurantTask();
}

void printHello() {
  final DateTime now = DateTime.now();
  final int isolateId = Isolate.current.hashCode;
  print("[$now] Hello, world! isolate=${isolateId} function='$printHello'");
}

void initApp() async {
  final getIt = GetIt.instance;
  getIt.registerFactory<RestaurantListUsecase>(() => RestaurantListUsecase());
  getIt.registerFactory<RestaurantSearchUsecase>(
      () => RestaurantSearchUsecase());
  getIt.registerFactory<RestaurantDetailUsecase>(
      () => RestaurantDetailUsecase());

  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService backgroundService = BackgroundService();
  backgroundService.initializeIsolate();

  if (defaultTargetPlatform == TargetPlatform.android) {
    await AndroidAlarmManager.initialize();
  }
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);
}

void setupPeriodicRandomRestaurantTask() async {
  await AndroidAlarmManager.periodic(
      const Duration(seconds: 10), alarmId, printHello);
}
