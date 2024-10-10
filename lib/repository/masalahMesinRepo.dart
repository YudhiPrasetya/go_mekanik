import 'package:go_mekanik/model/masalahMesinModel.dart';
import 'package:go_mekanik/service/masalahMesinService.dart';

class MasalahMesinRepo {
  final _masalahMesinService = MasalahMesinService();

  Future<List<MasalahMesinModel>> getMasalahMesinAll() {
    return _masalahMesinService.getMasalahMesinAll();
  }
}
