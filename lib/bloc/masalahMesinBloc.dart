import 'package:go_mekanik/model/masalahMesinModel.dart';
import 'package:go_mekanik/repository/masalahMesinRepo.dart';
import 'package:rxdart/rxdart.dart';

class MasalahMesinBloc {
  final _masalahMesinRepo = MasalahMesinRepo();
  final _getAllMasalahMesin = PublishSubject<List<MasalahMesinModel>>();

  Stream<List<MasalahMesinModel>> get countMasalahOrder =>
      _getAllMasalahMesin.stream;

  Future<List<MasalahMesinModel>> getMasalahMesinAll() async {
    // List<MasalahMesinModel> masalahMesin =
    //     await _masalahMesinRepo.getMasalahMesinAll();
    // _getAllMasalahMesin.sink.add(masalahMesin);
    return _masalahMesinRepo.getMasalahMesinAll();
  }

  dispose() async {
    await _getAllMasalahMesin.drain();
    _getAllMasalahMesin.close();
  }
}

mixin Observable {}
final masalahMesinBloc = MasalahMesinBloc();
