import 'package:shared_preferences/shared_preferences.dart';

const String prefsKeyToken = "PREFS_KEY_TOKEN";

class AppPreferences{
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<void> setUserToken(String token) async {
    _sharedPreferences.setString(prefsKeyToken, token);
  }

  String getUserToken() {
    return _sharedPreferences.getString(prefsKeyToken) ?? "";
  }

}