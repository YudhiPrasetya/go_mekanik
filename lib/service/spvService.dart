import 'dart:convert';

import 'package:go_mekanik/service/baseUrl.dart';
import 'package:http/http.dart' show Client;

class SpvService {
  final Client _client = Client();

  Future<dynamic> cekNIK(String nik) async {
    String _baseUrl = BaseUrl.baseUrl;
    String _baseUri = _baseUrl + "/Spv/getByNIK";

    var uri = Uri.parse(_baseUri);
    final res = await _client
        .post(uri, headers: {'Accept': 'application/json'}, body: {'nik': nik});

    return jsonDecode(res.body);
  }
}
