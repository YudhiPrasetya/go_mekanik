import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:go_mekanik/service/baseUrl.dart';
import 'package:http/http.dart' show Client;

import 'package:go_mekanik/model/userFinishedOrders.dart';
import 'package:go_mekanik/model/userFinishedOrdersDetail.dart';

class MachineSettledService {
  final Client _client = Client();

  Future<dynamic> simpanMachineSettled(
      String? barcode, String? catatanSPV, double? rating) async {
    String _baseUrl = BaseUrl.baseUrl;
    String _baseUri = _baseUrl + "API/MachineSettled/simpanMachineSettled";

    var uri = Uri.parse(_baseUri);
    final res = await _client.post(uri, headers: {
      'Accept': 'application/json'
    }, body: {
      'barcode': barcode,
      'catatanSPV': catatanSPV,
      'rating': rating.toString(),
    });

    return jsonDecode(res.body);
  }

  Future<dynamic> totalUserOrdersFinished(
      String idUserMekanik, String month, String year) async {
    String _baseUrl = BaseUrl.baseUrl;
    String _baseUri =
        _baseUrl + "API/MachineSettled/getTotalUserOrdersFinished";

    var uri = Uri.parse(_baseUri);
    final res = await _client.post(uri,
        headers: {'Accept': 'application/json'},
        body: {'idUserMekanik': idUserMekanik, 'month': month, 'year': year});

    return jsonDecode(res.body);
  }

  Future<dynamic> getUserOrdersFinished(
      String idUserMekanik, String month, String year) async {
    String _baseUrl = BaseUrl.baseUrl;
    String _baseUri = _baseUrl + "API/MachineSettled/getUserOrdersFinished";

    var uri = Uri.parse(_baseUri);
    final res = await _client.post(uri,
        headers: {'Accept': 'application/json'},
        body: {'idUserMekanik': idUserMekanik, 'month': month, 'year': year});

    if (kDebugMode) {
      print('res.body: ${res.body}');
    }

    return userFinishedOrdersFromJson(res.body);
    // return jsonDecode(res.body);
  }

  // Future<dynamic> getUserOrdersFinishedDetail(String id, String month) async{
  //   String _baseUrl = BaseUrl.baseUrl;
  //   String _baseUri = _baseUrl + "/MachineSettled/getUserOrdersFinishedDetail";

  //   var uri = Uri.parse(_baseUri);
  //   final res = await _client.post(uri,
  //       headers: {'Accept': 'application/json'},
  //       body: {'id': id, 'month': month});

  //   return userOrdersFinishedDetailFromJson(res.body);
  // }

  Future<List<UserOrdersFinishedDetail>> fetchFinishedDetail(
      String id, String month, String year) async {
    String _baseUrl = BaseUrl.baseUrl;
    String _baseUri =
        _baseUrl + "API/MachineSettled/getUserOrdersFinishedDetail";

    var uri = Uri.parse(_baseUri);
    final res = await _client.post(uri,
        headers: {'Accept': 'application/json'},
        body: {'id': id, 'month': month, 'year': year});

    if (res.statusCode == 200) {
      var parsed = json.decode(res.body);
      List jsonResponse = parsed['data'] as List;

      return jsonResponse
          .map((detailFinishedOrders) =>
              UserOrdersFinishedDetail.fromJson(detailFinishedOrders))
          .toList();
    } else {
      if (kDebugMode) {
        print('Error!Could not load data');
      }
      throw Exception('Failed to load data!');
    }
  }
}
