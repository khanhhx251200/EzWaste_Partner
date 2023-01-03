import 'package:app_shipper/core/constants/key_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  Future setTokenFirebase(String token) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(KeyConstant.KEY_TOKEN_FIREBASE, token);
  }

  Future setToken(String token, int timeExprise) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(KeyConstant.KEY_TOKEN, token);
    await preferences.setInt(KeyConstant.KEY_TOKEN_TIME_EXPRISE, timeExprise);
  }

  Future<String?> getTokenFirebase() async {
    final preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString(KeyConstant.KEY_TOKEN_FIREBASE);
    return token ?? '';
  }

  Future<String?> getToken() async {
    final preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString(KeyConstant.KEY_TOKEN);
    return token ?? '';
  }

  Future<int?> getTimeExprise() async {
    final preferences = await SharedPreferences.getInstance();
    int? time = preferences.getInt(KeyConstant.KEY_TOKEN_TIME_EXPRISE);
    return time ?? DateTime.now().millisecondsSinceEpoch;
  }

  Future<bool> getIsLogging() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.containsKey(KeyConstant.KEY_TOKEN);
  }

  logout() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.remove(KeyConstant.KEY_TOKEN);
    await preferences.remove(KeyConstant.KEY_TOKEN_TIME_EXPRISE);
  }
}
