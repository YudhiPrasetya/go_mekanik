class MachineBreakDownModel {
  String? idMachineBreakdown;
  String? line;
  String? tgl;
  String? barcodeMachine;
  String? machineBrand;
  String? machineType;
  String? type;
  String? machineSN;
  String? barcodeSympton;
  String? sympton;
  String? status;
  String? startWaiting;
  String? endWaiting;
  String? dateStartWaiting;
  String? dateEndWaiting;

  MachineBreakDownModel(
      {this.idMachineBreakdown,
      this.line,
      this.tgl,
      this.barcodeMachine,
      this.machineBrand,
      this.machineType,
      this.type,
      this.machineSN,
      this.barcodeSympton,
      this.sympton,
      this.status,
      this.startWaiting,
      this.endWaiting,
      this.dateStartWaiting,
      this.dateEndWaiting});

  factory MachineBreakDownModel.fromJson(Map<String, dynamic> json) =>
      MachineBreakDownModel(
          idMachineBreakdown: json['id_machine_breakdown'],
          line: json['line'],
          tgl: json['tgl'],
          barcodeMachine: json['barcode_machine'],
          machineBrand: json['machine_brand'],
          machineType: json['machine_type'],
          type: json['type'],
          machineSN: json['machine_sn'],
          barcodeSympton: json['barcode_sympton'],
          sympton: json['sympton'],
          status: json['status'],
          startWaiting: json['start_waiting'],
          endWaiting: json['end_waiting'],
          dateStartWaiting: json['date_start_waiting'],
          dateEndWaiting: json['date_end_waiting']);

  Map<String, dynamic> toJson() => {
        'id_machine_breakdown': idMachineBreakdown,
        'line': line,
        'tgl': tgl,
        'barcode_machine': barcodeMachine,
        'machine_brand': machineBrand,
        'machine_type': machineType,
        'type': type,
        'machine_sn': machineSN,
        'barcode_sympton': barcodeSympton,
        'sympton': sympton,
        'status': status,
        'start_waiting': startWaiting,
        'end_waiting': endWaiting,
        'date_start_waiting': dateStartWaiting,
        'date_end_waiting': dateEndWaiting
      };
}
