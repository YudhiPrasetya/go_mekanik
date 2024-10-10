import 'package:go_mekanik/model/servisMesinModel.dart';
import 'package:go_mekanik/service/servisMesinService.dart';

class ServisMesinRepo {
  final _servisMesinService = ServisMesinService();

  Future<List<ServisMesinModel>> getServisMesin(String status) {
    return _servisMesinService.getServisMesin(status);
  }

  Future getServisMesinStatus(String id) {
    return _servisMesinService.getServisMesinStatus(id);
  }

  Future updateServisMesin(String idUser, String idServisMesin) {
    return _servisMesinService.updateServisMesin(idUser, idServisMesin);
  }

  Future finishServisMesin(String idServisMesin) {
    return _servisMesinService.finishServisMesin(idServisMesin);
  }

  Future countServisMesin() {
    return _servisMesinService.countServisMesin();
  }
}
