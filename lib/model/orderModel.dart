import 'dart:convert';

List<OrderModel> orderFromJson(String str) {
  final jsonData = jsonDecode(str);

  return List<OrderModel>.from(jsonData.map((x) => OrderModel.fromJson(x)));
}

//from machine_breakdown table

class OrderModel {
  String? idMachineBreakdown;
  String? line;
  String? tglBreakdown;
  String? machineBrand;
  String? machineType;
  String? type;
  String? machineSN;
  String? sympton;
  String? status;
  String? dateStartWaiting;
  String? dateEndWaiting;
  String? floor;
  String? startWaiting;
  String? spv;
  String? barcodeMachine;

  OrderModel(
      {this.idMachineBreakdown,
      this.line,
      this.tglBreakdown,
      this.machineBrand,
      this.machineType,
      this.type,
      this.machineSN,
      this.sympton,
      this.status,
      this.dateStartWaiting,
      this.dateEndWaiting,
      this.floor,
      this.startWaiting,
      this.spv,
      this.barcodeMachine});

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
      idMachineBreakdown: json['id_machine_breakdown'],
      line: json['line'],
      tglBreakdown: json['tgl_breakdown'],
      machineBrand: json['machine_brand'],
      machineType: json['machine_type'],
      type: json['type'],
      machineSN: json['machine_sn'],
      sympton: json['sympton'],
      status: json['status'],
      dateEndWaiting: json['date_end_waiting'],
      dateStartWaiting: json['date_start_waiting'],
      floor: json["floor"],
      startWaiting: json['start_waiting'],
      spv: json['spv'],
      barcodeMachine: json['barcode_machine']);

  Map<String, dynamic> toJson() => {
        'id_machine_breakdown': idMachineBreakdown,
        'line': line,
        'tgl_breakdown': tglBreakdown,
        'machine_brand': machineBrand,
        'machine_type': machineType,
        'type': type,
        'machine_sn': machineSN,
        'sympton': sympton,
        'status': status,
        'date_end_waiting': dateEndWaiting,
        'date_start_waiting': dateStartWaiting,
        'floor': floor,
        'start_waiting': startWaiting,
        'spv': spv,
        'barcode_machine': barcodeMachine
      };
}
