// ignore_for_file: file_names

import 'dart:convert';
// import 'dart:io';

import 'package:go_mekanik/model/orderModel.dart';
import 'package:http/http.dart' show Client;
import 'package:go_mekanik/service/baseUrl.dart';
import 'package:flutter/foundation.dart' show compute, kDebugMode;

class OrderService {
  final Client _client = Client();

  Future<List<OrderModel>> getOrder(String status) async {
    String _baseUrl = BaseUrl.baseUrl;
    String _baseUri = _baseUrl + "API/MachinesBreakdown";

    // OrderModel order = OrderModel();

    var uri = Uri.parse(_baseUri);
    uri = uri.replace(queryParameters: <String, String>{'status': status});

    final res = await _client.get(uri, headers: {'Accept': 'application/json'});

    if (res.statusCode == 200) {
      return compute(orderFromJson, res.body);
    } else {
      return [];
    }
  }

  Future<List<OrderModel>> getByIdUser(String? idUser) async {
    String _baseUrl = BaseUrl.baseUrl;
    String _baseUri = _baseUrl + "API/MachineBreakdown/getByIdUser";
    var uri = Uri.parse(_baseUri);
    uri = uri.replace(queryParameters: <String, String?>{'idUser': idUser});

    final res = await _client.get(uri, headers: {'Accept': 'application/json'});

    //print('res.body: ${res.body}');
    if (res.statusCode == 200) {
      return compute(orderFromJson, res.body);
    } else {
      return [];
    }
    // return jsonDecode(res.body);
  }

  Future<dynamic> getMachineBreakdownStatus(String id) async {
    if (kDebugMode) {
      print('idMachineBreakdown: $id');
    }
    String _baseUrl = BaseUrl.baseUrl;
    String _baseUri =
        _baseUrl + "API/MachineBreakdown/getMachineBreakdownStatus";

    // String _baseUri = _baseUrl + "API/MachineBreakdown/getById";
    var uri = Uri.parse(_baseUri);

    final res = await _client
        .post(uri, headers: {'Accept': 'application/json'}, body: {'id': id});
    // final res = await _client.post(uri,
    //     headers: {'Content-Type': 'application/json'}, body: {'id': id});

    // final data = jsonDecode(res.body);

    return jsonDecode(res.body);
    // return data['status'];
  }

  Future<dynamic> getMachineBreakdownData(String id) async {
    if (kDebugMode) {
      print('idMachineBreakdown: $id');
    }
    String _baseUrl = BaseUrl.baseUrl;
    // String _baseUri =
    //     _baseUrl + "API/MachineBreakdown/getMachineBreakdownStatus";
    String _baseUri = _baseUrl + "API/MachineBreakdown/getById";
    var uri = Uri.parse(_baseUri);

    final res = await _client
        .post(uri, headers: {'Accept': 'application/json'}, body: {'id': id});

    return jsonDecode(res.body);
  }

  Future<dynamic> tambahOrder(
      String? barcode, String idUser, String? masalahMesin) async {
    String _baseUrl = BaseUrl.baseUrl;
    String _baseUri = _baseUrl + "API/Machinebreakdown/tambahMachineBreakdown";
    var uri = Uri.parse(_baseUri);

    final res = await _client.post(uri, headers: {
      'Accept': 'application/json'
    }, body: {
      'barcode': barcode,
      'idUser': idUser,
      'masalahMesin': masalahMesin
    });

    //print('res.body: ${res.body}');
    if (kDebugMode) {
      print('res.body: ${jsonDecode(res.body)}');
    }

    return jsonDecode(res.body);
  }

  Future<dynamic> sendNotifToSPV(
      String? idMachineBreakdown, String? catatanMekanik) async {
    String _baseUrl = BaseUrl.baseUrl;
    String _baseUri = _baseUrl + "API/MachineBreakdown/sendNotifToSPV";
    var uri = Uri.parse(_baseUri);

    final res = await _client.post(uri, headers: {
      'Accept': 'application/json'
    }, body: {
      'idMachineBreakdown': idMachineBreakdown,
      'catatanMekanik': catatanMekanik
    });

    //print('res.body: ${res.body}');
    if (kDebugMode) {
      print(jsonDecode(res.body));
    }

    return jsonDecode(res.body);
  }

  Future<dynamic> getByBarcodeAndRepairing(String? barcode) async {
    String _baseUrl = BaseUrl.baseUrl;
    String _baseUri =
        _baseUrl + "API/MachineBreakdown/getByBarcodeAndRepairing";
    final uri = Uri.parse(_baseUri);
    // final headers = {HttpHeaders.contentTypeHeader: 'application/json'};

    try {
      final res = await _client.post(uri,
          headers: {'Accept': 'application/json'}, body: {'barcode': barcode});

      return jsonDecode(res.body);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    // final res = await _client.post(uri,
    //     headers: {'Accept': 'application/json'}, body: {'barcode': barcode});

    // return jsonDecode(res.body);
  }

  Future<dynamic> deleteMB(String? idMB) async {
    String _baseUrl = BaseUrl.baseUrl;
    String _baseUri = _baseUrl + "API/MachineBreakdown/deleteMB";
    var uri = Uri.parse(_baseUri);

    final res = await _client.post(uri,
        headers: {'Accept': 'application/json'}, body: {'idMB': idMB});

    //print('res.body: ${res.body}');

    return jsonDecode(res.body);
  }
}
