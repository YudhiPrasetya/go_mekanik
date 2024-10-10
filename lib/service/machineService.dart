import "dart:convert";

import "package:go_mekanik/service/baseUrl.dart";
import "package:http/http.dart";

class MachineService {
  final Client _client = Client();

  Future<dynamic> getMachineByBarcode(String barcode) async {
    String _baseUrl = BaseUrl.baseUrl;
    String _baseUri = "${_baseUrl}API/Machine/getMachineByBarcode";

    var uri = Uri.parse(_baseUri);
    uri = uri.replace(queryParameters: <String, String>{'barcode': barcode});

    final res = await _client.get(uri, headers: {'Accept': 'application/json'});
    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    }
  }
}
