import 'dart:convert';
import 'package:get_contact/constants.dart';
import 'package:get_contact/models/storage.dart';
import 'package:get_contact/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:developer';

class UserService {
  static Future<void> login(String phone, String password) async {
    var response = await http.post(
      Uri.parse(Constant.BASE_URL + '/users/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {'phone': phone, 'password': password},
      ),
    );

    if (response.statusCode == 201) {
      var data = jsonDecode(response.body);
      var accessToken = data["access_token"];

      var storage = await Storage.getStorage();
      await storage.login(accessToken);
    } else if (response.statusCode == 401) {
      return Future.error("Wrong Phone/Password");
    } else {
      return Future.error("Internal server error");
    }
  }

  static Future<String> register(
      String name, String email, String phone, String password) async {
    var response = await http.post(
      Uri.parse(Constant.BASE_URL + '/users/register'),
      headers: {'Content-type': 'application/json'},
      body: jsonEncode(
        {"name": name, "phone": phone, "email": email, "password": password},
      ),
    );

    if (response.statusCode == 200) {
      return "Registered";
    } else {
      return Future.error("Phone/Email is already taken");
    }
  }

  static Future<User> getProfile() async {
    var storage = await Storage.getStorage();
    log(storage.getAccessToken() ?? "Null Access Token");
    var response = await http.get(
      Uri.parse(Constant.BASE_URL + '/users/profile'),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${storage.getAccessToken()}'
      },
    );

    if (response.statusCode == 401) {
      storage.logout();
      return Future.error("Unauthorized");
    }

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      User user = User.fromJson(data);
      return user;
    } else {
      return Future.error("Internal server error");
    }
  }

  static Future<void> logout() async {
    var storage = await Storage.getStorage();
    storage.logout();
  }
}
