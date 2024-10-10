import 'package:go_mekanik/service/userMekanikService.dart';

class UserMekanikRepo {
  final _userMekanikRepo = UserMekanikApiService();

  Future getById(String id) {
    return _userMekanikRepo.getMekanikById(id);
  }
}
