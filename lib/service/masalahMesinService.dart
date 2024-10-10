// import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:go_mekanik/model/masalahMesinModel.dart';
import 'package:go_mekanik/service/baseUrl.dart';
import 'package:http/http.dart';

class MasalahMesinService {
  final Client _client = Client();

  Future<List<MasalahMesinModel>> getMasalahMesinAll() async {
    String _baseUrl = BaseUrl.baseUrl;
    String _baseUri = _baseUrl + "API/MasalahMesin";

    var uri = Uri.parse(_baseUri);

    final res = await _client.get(uri, headers: {'Accept': 'application/json'});
    if (res.statusCode == 200) {
      // return jsonDecode(res.body);
      return compute(masalahMesinFromJson, res.body);
    } else {
      return [];
    }
  }
}
