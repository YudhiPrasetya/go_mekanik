// import 'package:go_mekanik/model/mekanikRepairingModel.dart';
import 'package:go_mekanik/repository/mekanikRepairingRepo.dart';

class MekanikReparingBloc {
  final _mekanikRepairingRepo = MekanikRepairingRepo();

  simpanMekanikRepairing(String idUser, String idMachineBreakdown) {
    return _mekanikRepairingRepo.simpanMekanikRepairing(
        idUser, idMachineBreakdown);
  }

  cancelMekanikRepairing(String idMekanikRepairing, String idUserMekanik) {
    return _mekanikRepairingRepo.cancelMekanikRepairing(
        idMekanikRepairing, idUserMekanik);
  }

  cancelRepairingNotification(String idMekanikRepairing) {
    return _mekanikRepairingRepo
        .cancelRepairingNotification(idMekanikRepairing);
  }

  userTotalOrders(String idUserMekanik) {
    return _mekanikRepairingRepo.userTotalOrders(idUserMekanik);
  }

  userTotalCanceledOrders(String idUserMekanik, String month, String year) {
    return _mekanikRepairingRepo.userTotalCanceledOrders(
        idUserMekanik, month, year);
  }

  userCanceledOrders(String idUserMekanik, String month, String year) {
    return _mekanikRepairingRepo.userCanceledOrders(idUserMekanik, month, year);
  }

  userCanceledOrdersDetail(String id, String month, String year) {
    return _mekanikRepairingRepo.userCanceledOrdersDetail(id, month, year);
  }

  userOrdersDetail(String id, String month, String year) {
    return _mekanikRepairingRepo.userOrdersDetail(id, month, year);
  }

  getByBarcodeAndRepairingStatus(String? barcode) {
    return _mekanikRepairingRepo.getByBarcodeAndRepairingStatus(barcode);
  }
}

final mekanikRepairingBloc = MekanikReparingBloc();
