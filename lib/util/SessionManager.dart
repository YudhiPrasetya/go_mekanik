import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  setSession(String idUserMekanik, String nik) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('is_login', true);
    preferences.setString("id_user", idUserMekanik);
    preferences.setString("nik", nik);
  }

  Future<bool> getIsLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // bool? isLogin = preferences.getBool('is_login');

    // return isLogin;
    return preferences.getBool("is_login") ?? false;
    //return preferences.containsKey("is_login");
  }

  Future<String> getIdUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('id_user') ?? '0';
  }

  Future<String> getNIK() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString("nik") ?? "0";
  }

  removeSession() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove("is_login");
    preferences.remove("id_user");
    preferences.remove("nik");
  }
}
