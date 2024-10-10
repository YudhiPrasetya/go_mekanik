import 'package:go_mekanik/service/authFirebaseService.dart';

class AuthFirebaseRepo {
  final _authFirebaseService = AuthFirebaseService();

  Future signUp(String email, String password) {
    return _authFirebaseService.signUp(email, password);
  }

  Future signIn(String email, String password) {
    return _authFirebaseService.signIn(email, password);
  }
}
