import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:go_mekanik/util/http_exception.dart';

class AuthFirebaseService {
  Client client = Client();

  Future<void> signUp(String email, String password) async {
    const url =
        // 'https://identitytoolkit.googleapis.com/v1/accounts:signInWithCustomToken?key=AIzaSyDTMZn7apfWpUO5ETl0_fFgjiGkZvNjTcQ';
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDTMZn7apfWpUO5ETl0_fFgjiGkZvNjTcQ';

    try {
      final response = await client.post(url as Uri,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true
          }));

      final responseData = jsonDecode(response.body);

      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      // print(jsonDecode(response.body));

      return jsonDecode(response.body);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> signIn(String email, String password) async {
    const url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDTMZn7apfWpUO5ETl0_fFgjiGkZvNjTcQ';

    try {
      final response = await client.post(url as Uri,
          body: json.encode({'email': email, 'password': password}));

      final responseData = jsonDecode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      // print(jsonDecode(response.body));

      return jsonDecode(response.body);
    } catch (error) {
      rethrow;
    }
  }
}
