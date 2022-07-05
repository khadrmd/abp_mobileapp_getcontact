import 'dart:convert';

import 'package:get_contact/constants.dart';
import 'package:get_contact/models/detail_contact.dart';
import 'package:get_contact/models/storage.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:developer';

class ContactService {
  static Future<DetailContact> getProfile(String id) async {
    var storage = await Storage.getStorage();
    var response = await http.get(
      Uri.parse(Constant.BASE_URL + '/contact/$id'),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${storage.getAccessToken()}'
      },
    );

    log(response.statusCode.toString());

    if (response.statusCode == 401) {
      storage.logout();
      return Future.error("Unauthorized");
    }

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      DetailContact detail = DetailContact.fromJson(data);
      return detail;
    } else {
      return Future.error("Internal server error");
    }
  }
}
