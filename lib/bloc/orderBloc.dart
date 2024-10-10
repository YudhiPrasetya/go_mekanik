import 'package:go_mekanik/model/orderModel.dart';
import 'package:go_mekanik/repository/orderRepo.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class OrderBloc {
  final _orderRepo = OrderRepo();

  final _getAllOrder = PublishSubject<List<OrderModel>>();
  final _getOrderByIdUser = PublishSubject<List<OrderModel>>();

  // PublishSubject<List<OrderModel>> get countOrder => _getAllOrder.stream;
  Stream<List<OrderModel>> get countOrder => _getAllOrder.stream;
  Stream<List<OrderModel>> get countOrderByIdUser => _getOrderByIdUser.stream;

  getOrder(String status) async {
    List<OrderModel> order = await _orderRepo.getOrder(status);
    _getAllOrder.sink.add(order);
  }

  getByIdUser(String? idUser) async {
    List<OrderModel> orders = await _orderRepo.getByIdUser(idUser);
    _getOrderByIdUser.sink.add(orders);
    // return _orderRepo.getByIdUser(idUser);
  }

  getMachineBreakdownStatus(String id) async {
    return _orderRepo.getMachineBreakdownStatus(id);
  }

  getMachineBreakdownData(String id) async {
    return _orderRepo.getMachineBreakdownData(id);
  }

  tambahMachineBreakdown(String? barcode, String idUser, String masalahMesin) {
    return _orderRepo.tambahMachineBreakdown(barcode, idUser, masalahMesin);
  }

  sendNotifToSPV(String? idMachineBreakdown, String? catatanMekanik) {
    return _orderRepo.sendNotifToSPV(idMachineBreakdown, catatanMekanik);
  }

  getByBarcodeAndRepairing(String? barcode) {
    return _orderRepo.getByBarcodeAndRepairing(barcode);
  }

  deleteMB(String? idMB) {
    return _orderRepo.deleteMB(idMB);
  }

  dispose() async {
    await _getAllOrder.drain();
    _getAllOrder.close();
  }
}

mixin Observable {}

final orderBloc = OrderBloc();
