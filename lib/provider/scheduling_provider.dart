import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:restaurant_app/main.dart';
import 'package:restaurant_app/utils/background/background_service.dart';
import 'package:restaurant_app/utils/date_time_helper.dart';
import 'package:restaurant_app/utils/shared_prefs/shared_pref_helper.dart';

class SchedulingProvider extends ChangeNotifier {
  static bool isScheduled = false;

  Future<bool> scheduledRestaurant(bool value) async {
    await SharedPrefHelper.saveScheduleStatus(value);
    isScheduled = value;
    if (isScheduled) {
      if (kDebugMode) {
        print('Scheduling Recommendation Restaurant Activated');
      }
      notifyListeners();
      // return await AndroidAlarmManager.periodic(
      //   const Duration(hours: 24),
      //   1,
      //   BackgroundService.callback,
      //   startAt: DateTimeHelper.format(),
      //   exact: true,
      //   wakeup: true,
      // );
      return await AndroidAlarmManager.periodic(
        const Duration(minutes: 1),
        alarmId,
        BackgroundService.callback,
        startAt: DateTime.now(),
        exact: true,
        wakeup: true,
      );
    } else {
      if (kDebugMode) {
        print('Scheduling Recommendation Restaurant Canceled');
      }
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
