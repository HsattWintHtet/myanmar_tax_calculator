import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {

  static Future<String> getParam(String numOfTimes) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(numOfTimes) ?? '1';
  }

  static Future<bool> saveParam(String numOfTimes, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(numOfTimes, value);
  }

  static Future<List<SharedItem>> getAllParam() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<SharedItem> list = new List();
    for (var key in prefs.getKeys()) {
      list.add(SharedItem(key, prefs.get(key)));
    }
    return list;
  }

  static Future<bool> deleteParam(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }
}

class SharedItem {
  String numOfTimes, param;
  SharedItem(this.numOfTimes, this.param);
}