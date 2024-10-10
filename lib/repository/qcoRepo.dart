import 'package:go_mekanik/model/qcoModel.dart';
import 'package:go_mekanik/service/qcoService.dart';

class QCORepo {
  final _qcoService = QCOService();

  Future<List<QCOModel>> getQCO(String status) {
    return _qcoService.getQCO(status);
  }

  Future updateQCODetail(String idUser, String idQCODetail) {
    return _qcoService.updateQCODetail(idUser, idQCODetail);
  }

  Future finishQCODetail(String idQCODetail) {
    return _qcoService.finishQCODetail(idQCODetail);
  }

  Future getQCOStatus(String id) {
    return _qcoService.getQCOStatus(id);
  }

  Future countQCO() {
    return _qcoService.countQCO();
  }
}
