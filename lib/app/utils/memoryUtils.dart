import 'package:call_screening_app/app/constants/app_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Memoryutils {
  static Future<List<String>> loadList(String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(value) ?? [];
  }

  static updateList(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(key.toString(), value);
  }
}
