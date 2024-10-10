import 'package:go_mekanik/repository/machineRepo.dart';

class MachineBloc {
  final _machineRepo = MachineRepo();

  getMachineByBarcode(String barcode) {
    return _machineRepo.getMachineByBarcode(barcode);
  }
}

mixin Observable {}

final machineBloc = MachineBloc();
