import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'baseUrl.dart';

class MekanikMemberService {
  final Client _client = Client();

  Future<dynamic> getMekanikMember(String idUserMekanik) async {
    String _baseUrl = BaseUrl.baseUrl;
    String _baseUri = _baseUrl + "/MekanikMember/getByUserMekanik";
    var uri = Uri.parse(_baseUri);

    final res = await _client.post(uri,
        headers: {'Accept': 'application/json'},
        body: {'idUserMekanik': idUserMekanik});

    return jsonDecode(res.body);
  }
}
