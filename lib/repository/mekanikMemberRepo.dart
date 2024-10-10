import 'package:go_mekanik/service/mekanikMemberService.dart';

class MekanikMemberRepo {
  final _mekanikMemberService = MekanikMemberService();

  Future getMekanikMember(String idUserMekanik) {
    return _mekanikMemberService.getMekanikMember(idUserMekanik);
  }
}
