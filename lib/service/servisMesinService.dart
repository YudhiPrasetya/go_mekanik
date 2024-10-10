import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:go_mekanik/model/servisMesinModel.dart';
import 'package:http/http.dart' show Client;
import 'package:flutter/foundation.dart' show compute;
import 'baseUrl.dart';

class ServisMesinService {
  final Client _client = Client();

  Future<List<ServisMesinModel>> getServisMesin(String status) async {
    String _baseUrl = BaseUrl.baseUrl;
    String _baseUri = _baseUrl + "/ServisMesin";

    var uri = Uri.parse(_baseUri);
    uri = uri.replace(queryParameters: <String, String>{'status': status});

    final res = await _client.get(uri, headers: {'Accept': 'application/json'});

    if (res.statusCode == 200) {
      return compute(servisMesinFromJson, res.body);
    } else {
      return [];
    }
  }

  Future<dynamic> getServisMesinStatus(String id) async {
    String _baseUrl = BaseUrl.baseUrl;
    String _baseUri = _baseUrl + "/ServisMesin/getServisMesinStatus";
    var uri = Uri.parse(_baseUri);

    final res = await _client
        .post(uri, headers: {'Accept': 'application/json'}, body: {'id': id});

    return jsonDecode(res.body);
  }

  Future<dynamic> updateServisMesin(String idUser, String idServisMesin) async {
    String _baseUrl = BaseUrl.baseUrl;
    String _baseUri = _baseUrl + "/ServisMesin/updateServisMesin";

    var uri = Uri.parse(_baseUri);
    final res = await _client.post(uri,
        headers: {'Accept': 'application/json'},
        body: {'idUser': idUser, 'idServisMesin': idServisMesin});

    return jsonDecode(res.body);
  }

  Future<dynamic> finishServisMesin(String idServisMesin) async {
    String _baseUrl = BaseUrl.baseUrl;
    String _baseUri = _baseUrl + "/ServisMesin/finishServisMesin";

    var uri = Uri.parse(_baseUri);
    final res = await _client.post(uri,
        headers: {'Accept': 'application/json'},
        body: {'idServisMesin': idServisMesin});

    return jsonDecode(res.body);
  }

  Future<dynamic> countServisMesin() async {
    String _baseUrl = BaseUrl.baseUrl;
    String _baseUri = _baseUrl + "/ServisMesin/countServisMesin";

    var uri = Uri.parse(_baseUri);
    final res = await _client.get(uri, headers: {'Accept': 'application/json'});

    return jsonDecode(res.body);
  }
}
