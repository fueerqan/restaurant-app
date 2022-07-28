import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static const String _isScheduleActive = "isScheduleActive";

  static Future<void> saveScheduleStatus(bool isActive) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(_isScheduleActive, isActive);
  }

  static Future<bool> isScheduleActivated() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isScheduleActive) ?? false;
  }
}
