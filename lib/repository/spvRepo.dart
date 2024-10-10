import 'package:go_mekanik/service/spvService.dart';

class SpvRepo {
  final _spvService = SpvService();

  Future cekNIK(String nik) {
    return _spvService.cekNIK(nik);
  }
}
