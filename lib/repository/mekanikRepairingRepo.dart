import 'package:go_mekanik/service/mekanikRepairingService.dart';

class MekanikRepairingRepo {
  final _mekanikRepairingService = MekanikRepairingService();

  Future simpanMekanikRepairing(String idUser, String idMachineBreakdown) {
    return _mekanikRepairingService.simpanMekanikRepairing(
        idUser, idMachineBreakdown);
  }

  Future cancelMekanikRepairing(
      String idMekanikRepairing, String idUserMekanik) {
    return _mekanikRepairingService.cancelRepairing(
        idMekanikRepairing, idUserMekanik);
  }

  Future cancelRepairingNotification(String idMekanikRepairing) {
    return _mekanikRepairingService
        .cancelRepairingNotification(idMekanikRepairing);
  }

  Future userTotalOrders(String idUserMekanik) {
    return _mekanikRepairingService.userTotalOrders(idUserMekanik);
  }

  Future userTotalCanceledOrders(
      String idUserMekanik, String month, String year) {
    return _mekanikRepairingService.userTotalCanceledOrders(
        idUserMekanik, month, year);
  }

  Future userCanceledOrders(String idUserMekanik, String month, String year) {
    return _mekanikRepairingService.getUserCanceledOrders(
        idUserMekanik, month, year);
  }

  Future userCanceledOrdersDetail(String id, String month, String year) {
    return _mekanikRepairingService.fetchCanceledDetail(id, month, year);
  }

  Future userOrdersDetail(String id, String month, String year) {
    return _mekanikRepairingService.fetchOrders(id, month, year);
  }

  Future getByBarcodeAndRepairingStatus(String? barcode) {
    return _mekanikRepairingService.getByBarcodeAndRepairingStatus(barcode);
  }
}
