// import 'package:go_mekanik/model/mekanikRepairingModel.dart';
import 'package:go_mekanik/repository/spvRepo.dart';

class SpvBloc {
  final _spvRepo = SpvRepo();

  cekNIK(String nik) {
    return _spvRepo.cekNIK(nik);
  }
}

final spvBloc = SpvRepo();
