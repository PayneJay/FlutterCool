import 'package:shared_preferences/shared_preferences.dart';

Future<String> getString(String key) async {
  String value;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  value = prefs.getString(key);
  return value;
}

saveString(String key, String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}

Future<bool> getBool(String key) async {
  bool value;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  value = prefs.getBool(key);
  return value;
}

saveBool(String key, bool value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool(key, value);
}

Future<double> getDouble(String key) async {
  double value;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  value = prefs.getDouble(key);
  return value;
}

saveDouble(String key, double value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setDouble(key, value);
}

Future<int> getInt(String key) async {
  int value;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  value = prefs.getInt(key);
  return value;
}

saveInt(String key, int value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt(key, value);
}
