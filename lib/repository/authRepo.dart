import 'package:go_mekanik/service/authService.dart';

class AuthRepo {
  final _authService = AuthService();

  Future getValidateNIK(String nik) {
    return _authService.getValidateNIK(nik);
  }

  Future getValidateNIK2(String nik) {
    return _authService.getValidateNIK2(nik);
  }

  Future getValidateUserName(String userName) {
    return _authService.getValidateUserName(userName);
  }

  Future getValidateUserNameRegister(String userName) {
    return _authService.getValidateUserNameRegister(userName);
  }

  Future getValidateEmailRegister(String email) {
    return _authService.getValidateEmailRegister(email);
  }

  Future login(String userName, String password, String token) {
    return _authService.login(userName, password, token);
  }

  Future register(String nik, String userName, String password, String token) {
    return _authService.register(nik, userName, password, token);
  }

  Future simpanPassword(String id, String password) {
    return _authService.simpanPassword(id, password);
  }

  Future deactiveUser(String id) {
    return _authService.deactiveUser(id);
  }

  Future getByIdUser(String? id) {
    return _authService.getByIdUser(id);
  }
}
