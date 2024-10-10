import 'package:go_mekanik/repository/mekanikMemberRepo.dart';

class MekanikMemberBloc {
  final _mekanikMemberRepo = MekanikMemberRepo();

  getMekanikMember(String idUserMekanik) async {
    return _mekanikMemberRepo.getMekanikMember(idUserMekanik);
  }
}

mixin Observable {}

final mekanikMemberBloc = MekanikMemberBloc();
