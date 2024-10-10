import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:go_mekanik/service/baseUrl.dart';

class AuthService {
  Client client = Client();

  Future<dynamic> getValidateNIK(String nik) async {
    String _baseUrl = BaseUrl.baseUrl;
    String _baseUri = _baseUrl + "/Auth/getValidateNIK";

    var uri = Uri.parse(_baseUri);
    uri = uri.replace(queryParameters: <String, String>{'nik': nik});

    final res = await client.get(uri, headers: {'Accept': 'application/json'});

    return jsonDecode(res.body);
  }

  Future<dynamic> getValidateNIK2(String nik) async {
    String _baseUrl = BaseUrl.baseUrl;
    String _baseUri = _baseUrl + "/Auth/getValidateNIK2";

    var uri = Uri.parse(_baseUri);
    uri = uri.replace(queryParameters: <String, String>{'nik': nik});

    final res = await client.get(uri, headers: {'Accept': 'application/json'});

    //print('res.body: ${res.body}');

    return jsonDecode(res.body);
  }

  Future<dynamic> getValidateUserName(String userName) async {
    String _baseUrl = BaseUrl.baseUrl;
    String _baseUri = _baseUrl + "API/Auth/getValidateUserName";

    var uri = Uri.parse(_baseUri);
    uri = uri.replace(queryParameters: <String, String>{'userName': userName});

    final res = await client.get(uri, headers: {'Accept': 'application/json'});

    return jsonDecode(res.body);
  }

  Future<dynamic> getValidateUserNameRegister(String userName) async {
    String _baseUrl = BaseUrl.baseUrl;
    String _baseUri = _baseUrl + "/Auth/getValidateUserNameRegister";

    var uri = Uri.parse(_baseUri);
    uri = uri.replace(queryParameters: <String, String>{'userName': userName});

    final res = await client.get(uri, headers: {'Accept': 'application/json'});

    return jsonDecode(res.body);
  }

  Future<dynamic> getValidateEmailRegister(String email) async {
    String _baseUrl = BaseUrl.baseUrl;
    String _baseUri = _baseUrl + "/Auth/getValidateEmailRegister";

    var uri = Uri.parse(_baseUri);
    uri = uri.replace(queryParameters: <String, String>{'email': email});

    final res = await client.get(uri, headers: {'Accept': 'application/json'});

    return jsonDecode(res.body);
  }

  Future<dynamic> getByIdUser(String? id) async {
    String _baseUrl = BaseUrl.baseUrl;
    String _baseUri = _baseUrl + "API/Auth/getByIdUser";

    var uri = Uri.parse(_baseUri);
    uri = uri.replace(queryParameters: <String, String?>{'id': id});

    final res = await client.get(
      uri,
      headers: {'Accept': 'application/json'},
    );

    return jsonDecode(res.body);
  }

  Future<dynamic> login(String userName, String password, String token) async {
    String _baseUrl = BaseUrl.baseUrl;
    String _baseUri = _baseUrl + "API/Auth/login";

    var uri = Uri.parse(_baseUri);

    final res = await client.post(uri,
        headers: {'Accept': 'application/json'},
        body: {'userName': userName, 'password': password, 'token': token});

    //print('res.body: ${res.body}');

    return jsonDecode(res.body);
  }

  Future<dynamic> register(
      String nik, String userName, String password, String token) async {
    String _baseUrl = BaseUrl.baseUrl;
    String _baseUri = _baseUrl + "API/Auth/register";

    var uri = Uri.parse(_baseUri);

    final res = await client.post(uri, headers: {
      'Accept': 'application/json'
    }, body: {
      'nik': nik,
      'userName': userName,
      'password': password,
      'token': token
    });

    // final res = await client.post(
    //   uri,
    //   headers: {'Accept': 'application/json'},
    //   body: {
    //     'email': email,
    //     'password': password,
    //     'tokenId': tokenId
    //   }
    // )

    return jsonDecode(res.body);
  }

  Future<dynamic> deactiveUser(String id) async {
    String _baseUrl = BaseUrl.baseUrl;
    String _baseUri = _baseUrl + "API/Auth/deactiveUser";

    var uri = Uri.parse(_baseUri);

    final res = await client
        .post(uri, headers: {'Accept': 'application/json'}, body: {'id': id});

    return jsonDecode(res.body);
  }

  Future<dynamic> simpanPassword(String id, String password) async {
    String _baseUrl = BaseUrl.baseUrl;
    String _baseUri = _baseUrl + "/Auth/simpanPassword";

    var uri = Uri.parse(_baseUri);

    final res = await client.post(uri,
        headers: {'Accept': 'application/json'},
        body: {'id': id, 'password': password});

    //print('simpanPassword return value: ${res.body}');

    return jsonDecode(res.body);
  }
}
