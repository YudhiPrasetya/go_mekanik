import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:go_mekanik/model/qcoModel.dart';
import 'package:http/http.dart' show Client;
import 'package:flutter/foundation.dart' show compute;
import 'baseUrl.dart';

class QCOService {
  final Client _client = Client();

  Future<List<QCOModel>> getQCO(String status) async {
    String _baseUrl = BaseUrl.baseUrl;
    String _baseUri = _baseUrl + "/QCO";

    // OrderModel order = OrderModel();

    var uri = Uri.parse(_baseUri);
    uri = uri.replace(queryParameters: <String, String>{'status': status});

    final res = await _client.get(uri, headers: {'Accept': 'application/json'});

    if (res.statusCode == 200) {
      return compute(qcoFromJson, res.body);
    } else {
      return [];
    }
  }

  Future<dynamic> getQCOStatus(String id) async {
    String _baseUrl = BaseUrl.baseUrl;
    String _baseUri = _baseUrl + "/QCO/getQCOStatus";
    var uri = Uri.parse(_baseUri);

    final res = await _client
        .post(uri, headers: {'Accept': 'application/json'}, body: {'id': id});

    return jsonDecode(res.body);
  }

  Future<dynamic> updateQCODetail(String idUser, String idQCODetail) async {
    String _baseUrl = BaseUrl.baseUrl;
    String _baseUri = _baseUrl + "/QCO/updateQCODetail";

    var uri = Uri.parse(_baseUri);
    final res = await _client.post(uri,
        headers: {'Accept': 'application/json'},
        body: {'idUser': idUser, 'idQCODetail': idQCODetail});

    return jsonDecode(res.body);
  }

  Future<dynamic> finishQCODetail(String idQCODetail) async {
    String _baseUrl = BaseUrl.baseUrl;
    String _baseUri = _baseUrl + "/QCO/finishQCODetail";

    var uri = Uri.parse(_baseUri);
    final res = await _client.post(uri,
        headers: {'Accept': 'application/json'},
        body: {'idQCODetail': idQCODetail});

    return jsonDecode(res.body);
  }

  Future<dynamic> countQCO() async {
    String _baseUrl = BaseUrl.baseUrl;
    String _baseUri = _baseUrl + "/QCO/countQCO";

    var uri = Uri.parse(_baseUri);
    final res = await _client.get(uri, headers: {'Accept': 'application/json'});

    return jsonDecode(res.body);
  }
}
