import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static const String ACCESS_TOKEN = 'access_token';

  final SharedPreferences storage;

  bool isLoggedIn;
  String? accessToken;

  Storage({
    required this.storage,
    required this.isLoggedIn,
    this.accessToken,
  });

  static Future<Storage> getStorage() async {
    var storage = await SharedPreferences.getInstance();
    var accessToken = storage.getString(ACCESS_TOKEN);

    bool isLoggedIn = false;

    if (accessToken != null) {
      isLoggedIn = true;
    }

    return Storage(
        storage: storage, isLoggedIn: isLoggedIn, accessToken: accessToken);
  }

  Future<void> login(String accessToken) async {
    await storage.setString(ACCESS_TOKEN, accessToken);
    isLoggedIn = true;
  }

  Future<void> logout() async {
    await storage.remove(ACCESS_TOKEN);
    isLoggedIn = false;
  }

  bool loggedInStatus() {
    return isLoggedIn;
  }

  String? getAccessToken() {
    return accessToken;
  }
}
