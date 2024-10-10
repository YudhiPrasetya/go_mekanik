import 'package:go_mekanik/model/orderModel.dart';
import 'package:go_mekanik/service/orderService.dart';

class OrderRepo {
  final _orderService = OrderService();

  Future<List<OrderModel>> getOrder(String status) {
    return _orderService.getOrder(status);
  }

  Future<List<OrderModel>> getByIdUser(String? idUser) {
    return _orderService.getByIdUser(idUser);
  }

  Future getMachineBreakdownStatus(String id) {
    return _orderService.getMachineBreakdownStatus(id);
  }

  Future getMachineBreakdownData(String id) {
    return _orderService.getMachineBreakdownData(id);
  }

  Future tambahMachineBreakdown(
      String? barcode, String idUser, String masalahMesin) {
    return _orderService.tambahOrder(barcode, idUser, masalahMesin);
  }

  Future sendNotifToSPV(String? idMachineBreakdown, String? catatanMekanik) {
    return _orderService.sendNotifToSPV(idMachineBreakdown, catatanMekanik);
  }

  Future getByBarcodeAndRepairing(String? barcode) {
    return _orderService.getByBarcodeAndRepairing(barcode);
  }

  Future deleteMB(String? idMB) {
    return _orderService.deleteMB(idMB);
  }
}
