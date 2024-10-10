import 'dart:convert';
// import 'package:flutter/material.dart';
import 'package:http/http.dart' show Client;
import 'package:go_mekanik/service/baseUrl.dart';
import 'package:go_mekanik/model/userMekanik.dart';
import 'package:go_mekanik/util/msg.dart';

class UserMekanikApiService {
  String baseUrl = BaseUrl.baseUrl;

  Client client = Client();

  Future<Msg> createUserMekanik(UserMekanik userMekanik) async {
    final response =
        await client.post("$baseUrl/UserMekanik/create" as Uri, body: {
      "userName": userMekanik.user_name,
      "nik": userMekanik.nik,
      "password": userMekanik.password
    });

    if (response.statusCode == 200) {
      // print('Msg.fromJson: ${Msg.fromJson(jsonDecode(response.body))}');
      return Msg.fromJson(jsonDecode(response.body)['value']);
    } else {
      throw Exception('Failed to Sign In');
    }
  }

  Future<dynamic> getMekanikById(String id) async {
    String _baseUrl = BaseUrl.baseUrl;
    // String _baseUri = _baseUrl + "/UserMekanik/getById";
    String _baseUri = _baseUrl + "API/MemberUser/getById";

    var uri = Uri.parse(_baseUri);
    final res = await client
        .post(uri, headers: {'Accept': 'application/json'}, body: {'id': id});

    return jsonDecode(res.body);
  }
}
