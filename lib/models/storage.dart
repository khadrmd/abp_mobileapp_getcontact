import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  final SharedPreferences storage;

  bool isLoggedIn;
  String? accessToken;

  Storage({
    required this.storage,
    required this.isLoggedIn,
    this.accessToken,
  });

  static Future<Storage> getStorage() async {}
}
