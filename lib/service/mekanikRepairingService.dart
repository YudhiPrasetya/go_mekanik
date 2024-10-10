import 'dart:convert';

import 'package:go_mekanik/model/mekanikRepairingModel.dart';
import 'package:go_mekanik/model/userCanceledOrders.dart';
import 'package:go_mekanik/model/userCanceledOrdersDetail.dart';
import 'package:go_mekanik/model/userOrdersDetail.dart';
import 'package:go_mekanik/service/baseUrl.dart';
import 'package:http/http.dart' show Client;

class MekanikRepairingService {
  final Client _client = Client();

  Future<dynamic> simpanMekanikRepairing(
      String idUser, String idMachineBreakdown) async {
    String _baseUrl = BaseUrl.baseUrl;
    String _baseUri = _baseUrl + "API/MekanikRepairing/simpanMekanikRepairing";

    var uri = Uri.parse(_baseUri);
    final res = await _client.post(uri,
        headers: {'Accept': 'application/json'},
        body: {'idUser': idUser, 'idMachineBreakdown': idMachineBreakdown});

    // print('id SimpanMekanikRepairing: ${jsonDecode(res.body)}');
    // print('res.body: ${res.body}');

    return jsonDecode(res.body);
  }

  Future<dynamic> cancelRepairing(
      String idMekanikRepairing, String idUserMekanik) async {
    String _baseUrl = BaseUrl.baseUrl;
    String _baseUri = _baseUrl + "API/MekanikRepairing/cancelMekanikRepairing";

    var uri = Uri.parse(_baseUri);
    final res = await _client.post(uri, headers: {
      'Accept': 'application/json'
    }, body: {
      'idMekanikRepairing': idMekanikRepairing,
      'idUserMekanik': idUserMekanik
    });

    return jsonDecode(res.body);
  }

  Future<dynamic> cancelRepairingNotification(String idMekanikRepairing) async {
    String _baseUrl = BaseUrl.baseUrl;
    String _baseUri =
        _baseUrl + "/MekanikRepairing/cancelRepairingNotification";

    var uri = Uri.parse(_baseUri);
    final res = await _client.post(uri,
        headers: {'Accept': 'application/json'},
        body: {'idMekanikRepairing': idMekanikRepairing});

    return jsonDecode(res.body);
  }

  Future<dynamic> userTotalOrders(String idUserMekanik) async {
    String _baseUrl = BaseUrl.baseUrl;
    String _baseUri = _baseUrl + "/MekanikRepairing/getTotalUserOrders";

    var uri = Uri.parse(_baseUri);
    final res = await _client.post(uri,
        headers: {'Accept': 'application/json'},
        body: {'idUserMekanik': idUserMekanik});

    return jsonDecode(res.body);
  }

  Future<dynamic> userTotalCanceledOrders(
      String idUserMekanik, String month, String year) async {
    String _baseUrl = BaseUrl.baseUrl;
    String _baseUri =
        _baseUrl + "API/MekanikRepairing/getTotalUserCanceledOrders";

    var uri = Uri.parse(_baseUri);
    final res = await _client.post(uri,
        headers: {'Accept': 'application/json'},
        body: {'idUserMekanik': idUserMekanik, 'month': month, 'year': year});

    return jsonDecode(res.body);
  }

  Future<dynamic> getUserCanceledOrders(
      String idUserMekanik, String month, String year) async {
    String _baseUrl = BaseUrl.baseUrl;
    String _baseUri = _baseUrl + "API/MekanikRepairing/getUserCanceledOrders";

    var uri = Uri.parse(_baseUri);
    final res = await _client.post(uri,
        headers: {'Accept': 'application/json'},
        body: {'idUserMekanik': idUserMekanik, 'month': month, 'year': year});

    // return jsonDecode(res.body);
    return userCanceledOrdersFromJson(res.body);
  }

  Future<List<UserCanceledOrdersDetail>> fetchCanceledDetail(
      String id, String month, String year) async {
    String _baseUrl = BaseUrl.baseUrl;
    String _baseUri =
        _baseUrl + "API/MekanikRepairing/getUserCanceledOrdersDetail";

    var uri = Uri.parse(_baseUri);
    final res = await _client.post(uri,
        headers: {'Accept': 'application/json'},
        body: {'id': id, 'month': month, 'year': year});

    if (res.statusCode == 200) {
      var parsed = json.decode(res.body);
      List jsonResponse = parsed['data'] as List;

      return jsonResponse
          .map((detailCanceledOrders) =>
              UserCanceledOrdersDetail.fromJson(detailCanceledOrders))
          .toList();
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<List<UserOrdersDetail>> fetchOrders(
      String id, String month, String year) async {
    String _baseUrl = BaseUrl.baseUrl;
    String _baseUri = _baseUrl + "API/MekanikRepairing/getUserOrdersDetail";

    var uri = Uri.parse(_baseUri);
    final res = await _client.post(uri,
        headers: {'Accept': 'application/json'},
        body: {'id': id, 'month': month, 'year': year});

    if (res.statusCode == 200) {
      var parsed = json.decode(res.body);
      List jsonResponse = parsed['data'] as List;

      return jsonResponse
          .map((detailOrders) => UserOrdersDetail.fromJson(detailOrders))
          .toList();
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<dynamic> getByBarcodeAndRepairingStatus(String? barcode) async {
    String _baseUrl = BaseUrl.baseUrl;
    String _baseUri =
        _baseUrl + "API/MekanikRepairing/getByBarcodeAndRepairingStatus";

    var uri = Uri.parse(_baseUri);
    final res = await _client.post(uri,
        headers: {'Accept': 'application/json'}, body: {'barcode': barcode});
    if (res.statusCode == 200) {
      var parsed = json.decode(res.body);
      MekanikRepairingModel jsonResponse = parsed['data'];
      return jsonResponse;
    }
  }
}
