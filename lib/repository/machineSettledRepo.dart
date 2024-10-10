import 'package:go_mekanik/service/machineSettledService.dart';

class MachineSettledRepo {
  final _machineSettledService = MachineSettledService();

  Future simpanMachineSettled(
      String? barcode, String? catatanSPV, double? rating) {
    return _machineSettledService.simpanMachineSettled(
        barcode, catatanSPV, rating);
  }

  Future totalUserOrdersFinished(
      String idUserMekanik, String month, String year) {
    return _machineSettledService.totalUserOrdersFinished(
        idUserMekanik, month, year);
  }

  Future getUserOrdersFinished(
      String idUserMekanik, String month, String year) {
    return _machineSettledService.getUserOrdersFinished(
        idUserMekanik, month, year);
  }

  Future getUserOrdersFinishedDetail(String id, String month, String year) {
    return _machineSettledService.fetchFinishedDetail(id, month, year);
  }
}
