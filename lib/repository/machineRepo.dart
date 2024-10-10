import 'package:go_mekanik/service/machineService.dart';

class MachineRepo {
  final _machineService = MachineService();

  Future getMachineByBarcode(String barcode) {
    return _machineService.getMachineByBarcode(barcode);
  }
}
