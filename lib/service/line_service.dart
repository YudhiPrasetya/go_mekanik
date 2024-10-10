import 'dart:convert';

import 'package:go_mekanik/model/Line.dart';
import 'package:http/http.dart' show Client;
import 'package:go_mekanik/service/baseUrl.dart';

class ApiService {
  // final String baseUrl = "http://go-mekanik-api.test";
  // final String baseUrl = "http://192.168.10.85/GO-MEKANIK-API/public/index.php";
  // final String baseUrl = "http://10.10.10.251/GO-MEKANIK-API/public/index.php";
  // final String baseUrl = "http://10.10.10.249/GO-MEKANIK-API/public/index.php";
  String baseUrl = BaseUrl.baseUrl;

  Client client = Client();
  Line line = Line();

  Future<List>? getLines() async {
    final response = await client.get("$baseUrl/line" as Uri);
    // if (response.statusCode == 200) {
    //   // return line.lineFromJson(response.body);
    //   return json.decode(response.body);
    // } else {
    //   return null;
    // }
    return json.decode(response.body);
  }

  Future<bool> createLine(Line line) async {
    final response = await client.post("$baseUrl/line/create" as Uri, body: {
      "name": line.name,
      "description": line.description,
      "shift": line.shift,
      "operators": line.operators,
      "head": line.head,
      "id_spv": line.id_spv,
      "floor": line.floor
    });
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateLine({String? id, Line? line}) async {
    final response =
        await client.post("$baseUrl/line/update/$id" as Uri, body: {
      "name": line?.name,
      "description": line?.description,
      "shift": line?.shift,
      "operators": line?.operators,
      "head": line?.head,
      "id_spv": line?.id_spv,
      "floor": line?.floor
    });

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteLine({String? id}) async {
    final response = await client.post("$baseUrl/line/delete/$id" as Uri);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
