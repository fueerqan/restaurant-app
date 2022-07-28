import 'dart:isolate';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:restaurant_app/domain/restaurant_list_usecase.dart';
import 'package:restaurant_app/main.dart';
import 'package:restaurant_app/utils/notification/notification_helper.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolateName = 'restaurantApp';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    if (kDebugMode) {
      print('Alarm fired!');
    }

    final NotificationHelper notificationHelper = NotificationHelper();

    final restaurantUseCase = RestaurantListUsecase();
    final restaurantList = await restaurantUseCase.fetchRestaurantList();
    final randomIndex = Random().nextInt(restaurantList.length);

    await notificationHelper.showNotification(
      flutterLocalNotificationsPlugin,
      restaurantList[randomIndex],
    );

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
