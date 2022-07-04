import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

class UserService {
  static Future<void> login(String phone, String password) async {
    var response = await http.post(
      Uri.parse("http://178.128.25.31:8000/user/login"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {'phone': phone, 'password': password},
      ),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var access_token = data["access_token"];
    }
  }
}
