// ignore_for_file: file_names

import 'package:go_mekanik/repository/authRepo.dart';

class AuthBloc {
  final _authRepo = AuthRepo();

  getValidateNIK(String nik) {
    return _authRepo.getValidateNIK(nik);
  }

  getValidateNIK2(String nik) {
    return _authRepo.getValidateNIK2(nik);
  }

  getValidateUserNameRegister(String userName) {
    return _authRepo.getValidateUserNameRegister(userName);
  }

  getValidateEmailRegister(String email) {
    return _authRepo.getValidateUserNameRegister(email);
  }

  getValidateUserName(String userName) {
    return _authRepo.getValidateUserName(userName);
  }

  login(String userName, String password, String token) {
    return _authRepo.login(userName, password, token);
  }

  register(String nik, String userName, String password, String token) {
    return _authRepo.register(nik, userName, password, token);
  }

  simpanPassword(String id, String password) {
    return _authRepo.simpanPassword(id, password);
  }

  deactiveUser(String id) {
    return _authRepo.deactiveUser(id);
  }

  getByIdUser(String? id) {
    return _authRepo.getByIdUser(id);
  }
}

final authBloc = AuthBloc();
