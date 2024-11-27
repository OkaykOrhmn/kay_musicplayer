import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static late SharedPreferences preferences;

  static Future<void> initial() async {
    preferences = await SharedPreferences.getInstance();
  }

  static const String firstTime = 'first-time-open-app';
}

class FirstTimeStorage {
  static bool getStatus() {
    final prefs = SharedPreferencesHelper.preferences;
    return prefs.getBool(SharedPreferencesHelper.firstTime) ?? true;
  }

  static void setStatus(bool status) {
    final prefs = SharedPreferencesHelper.preferences;
    prefs.setBool(SharedPreferencesHelper.firstTime, status);
  }

  static void clearStatus() {
    final prefs = SharedPreferencesHelper.preferences;
    prefs.remove(SharedPreferencesHelper.firstTime);
  }
}
