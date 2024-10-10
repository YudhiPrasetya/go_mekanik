import 'package:go_mekanik/repository/userMekanikRepo.dart';

class UserMekanikBloc {
  final _userMekanikRepo = UserMekanikRepo();

  getById(String id) {
    return _userMekanikRepo.getById(id);
  }
}

final userMekanikBloc = UserMekanikBloc();
