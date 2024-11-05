import 'package:shared_preferences/shared_preferences.dart';

class AppUtils {
  static Future<String> getAccesToken() async {
    final perfs = await SharedPreferences.getInstance();
    final savedAccesToken = perfs.getString("access");
    return savedAccesToken ?? "";
  }
}
