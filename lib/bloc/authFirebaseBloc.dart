// ignore_for_file: file_names

import 'package:go_mekanik/repository/authFirebaseRepo.dart';

class AuthFirebaseBloc {
  final _authFirebaseRepo = AuthFirebaseRepo();

  firebaseSignUp(String email, String password) {
    return _authFirebaseRepo.signUp(email, password);
  }

  firebaseSignIn(String email, String password) {
    return _authFirebaseRepo.signIn(email, password);
  }
}

final authFirebaseBloc = AuthFirebaseBloc();
