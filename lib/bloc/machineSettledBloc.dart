// import 'package:go_mekanik/model/mekanikRepairingModel.dart';
import 'package:go_mekanik/repository/machineSettledRepo.dart';

class MekanikReparingBloc {
  final _machineSettledRepo = MachineSettledRepo();

  // simpanMekanikRepairing(String? barcode, String? catatan, double? rating) {
  //   return _machineSettledRepo.simpanMachineSettled(barcode!, catatan, rating);
  // }

  totalUserOrdersFinished(String idUserMekanik, String month, String year) {
    return _machineSettledRepo.totalUserOrdersFinished(
        idUserMekanik, month, year);
  }

  getUserOrdersFinished(String idUserMekanik, String month, String year) {
    return _machineSettledRepo.getUserOrdersFinished(
        idUserMekanik, month, year);
  }

  getUserOrdersFinishedDetail(String id, String month, String year) {
    return _machineSettledRepo.getUserOrdersFinishedDetail(id, month, year);
  }

  simpanMachineSettled(String? barcode, String? catatanSPV,
      String? catatanMekanik, double? rating) {
    return _machineSettledRepo.simpanMachineSettled(
        barcode, catatanSPV, rating);
  }
}

final machineSettledBloc = MachineSettledRepo();
