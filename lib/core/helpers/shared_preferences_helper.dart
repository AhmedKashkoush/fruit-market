import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  final SharedPreferences prefs;

  SharedPreferencesHelper(this.prefs);


  void write<T>(String key, T value) async {
    switch (value.runtimeType) {
      case int:
        await prefs.setInt(key, value as int);
        break;
      case double:
        await prefs.setDouble(key, value as double);
        break;
      case String:
        await prefs.setString(key, value as String);
        break;
      case bool:
        await prefs.setBool(key, value as bool);
        break;
    }
  }

  Object? read<T>(String key) {
    if (T is int) {
      return prefs.getInt(key);
    } else if (T is double) {
      return prefs.getDouble(key);
    } else if (T is String) {
      return prefs.getString(key);
    } else if (T is bool) {
      return prefs.getBool(key);
    } else {
      return prefs.get(key);
    }
  }
}
