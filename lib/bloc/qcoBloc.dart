import 'package:go_mekanik/model/qcoModel.dart';
import 'package:go_mekanik/repository/qcoRepo.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class QCOBloc {
  final _qcoRepo = QCORepo();

  final _getAllQCO = PublishSubject<List<QCOModel>>();
  // PublishSubject<List<QCOModel>> get countQCO => _getAllQCO.stream;
  Stream<List<QCOModel>> get countQCO => _getAllQCO.stream;

  getQCO(String status) async {
    List<QCOModel> qco = await _qcoRepo.getQCO(status);
    _getAllQCO.sink.add(qco);
  }

  getQCOStatus(String id) async {
    return _qcoRepo.getQCOStatus(id);
  }

  updateQCODetail(String idUser, String idQCODetail) async {
    return _qcoRepo.updateQCODetail(idUser, idQCODetail);
  }

  finishQCODetail(String idQCODetail) async {
    return _qcoRepo.finishQCODetail(idQCODetail);
  }

  countQCO1() async {
    return _qcoRepo.countQCO();
  }

  dispose() async {
    await _getAllQCO.drain();
    _getAllQCO.close();
  }
}

mixin Observable {}

final qcoBloc = QCOBloc();
