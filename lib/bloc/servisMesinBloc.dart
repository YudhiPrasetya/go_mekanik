import 'package:go_mekanik/model/servisMesinModel.dart';
import 'package:go_mekanik/repository/servisMesinRepo.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class ServisMesinBloc {
  final _servisMesinRepo = ServisMesinRepo();

  final _getAllServisMesin = PublishSubject<List<ServisMesinModel>>();
  // PublishSubject<List<ServisMesinModel>> get countServisMesin =>
  //     _getAllServisMesin.stream;
  Stream<List<ServisMesinModel>> get countServisMesin =>
      _getAllServisMesin.stream;

  getServisMesin(String status) async {
    List<ServisMesinModel> servisMesin =
        await _servisMesinRepo.getServisMesin(status);
    _getAllServisMesin.sink.add(servisMesin);
  }

  getServisMesinStatus(String id) async {
    return _servisMesinRepo.getServisMesinStatus(id);
  }

  updateServisMesin(String idUser, String idServisMesin) async {
    return _servisMesinRepo.updateServisMesin(idUser, idServisMesin);
  }

  finishServisMesin(String idServisMesin) async {
    return _servisMesinRepo.finishServisMesin(idServisMesin);
  }

  countServisMesin1() async {
    return _servisMesinRepo.countServisMesin();
  }

  dispose() async {
    await _getAllServisMesin.drain();
    _getAllServisMesin.close();
  }
}

mixin Observable {}

final servisMesinBloc = ServisMesinBloc();
