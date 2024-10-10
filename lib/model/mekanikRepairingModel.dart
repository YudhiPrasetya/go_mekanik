import 'dart:convert';

List<MekanikRepairingModel> mekanikRepairingFromJson(String str) {
  final jsonData = jsonDecode(str);

  return List<MekanikRepairingModel>.from(
      jsonData.map((x) => MekanikRepairingModel.fromJson(x)));
}

class MekanikRepairingModel {
  // ignore: non_constant_identifier_names
  String? id_mekanik_repairing;
  // ignore: non_constant_identifier_names
  String? id_machine_breakdown;
  // ignore: non_constant_identifier_names
  String? id_mekanik_member;
  String? line;
  String? tgl;
  // ignore: non_constant_identifier_names
  String? start_repairing;
  // ignore: non_constant_identifier_names
  String? end_repairing;
  String? barcode;
  // ignore: non_constant_identifier_names
  String? date_start_repairing;
  // ignore: non_constant_identifier_names
  String? date_end_repairing;
  String? status;

  MekanikRepairingModel(
      {
      // ignore: non_constant_identifier_names
      this.id_mekanik_repairing,
      // ignore: non_constant_identifier_names
      this.id_machine_breakdown,
      // ignore: non_constant_identifier_names
      this.id_mekanik_member,
      this.line,
      this.tgl,
      // ignore: non_constant_identifier_names
      this.start_repairing,
      // ignore: non_constant_identifier_names
      this.end_repairing,
      this.barcode,
      // ignore: non_constant_identifier_names
      this.date_start_repairing,
      // ignore: non_constant_identifier_names
      this.date_end_repairing,
      this.status});

  factory MekanikRepairingModel.fromJson(Map<String, dynamic> json) =>
      MekanikRepairingModel(
          id_mekanik_repairing: json['id_mekanik_repairing'],
          id_machine_breakdown: json['id_machine_breakdown'],
          id_mekanik_member: json['id_mekanik_member'],
          line: json['line'],
          tgl: json['tgl'],
          start_repairing: json['start_repairing'],
          end_repairing: json['end_repairing'],
          barcode: json['barcode'],
          date_start_repairing: json['date_start_repairing'],
          date_end_repairing: json['date_end_repairing'],
          status: json['status']);

  Map<String, dynamic> toJson() => {
        'id_mekanik_repairing': id_mekanik_repairing,
        'id_machine_breakdown': id_machine_breakdown,
        'id_mekanik_member': id_mekanik_member,
        'line': line,
        'tgl': tgl,
        'start_repairing': start_repairing,
        'end_repairing': end_repairing,
        'barcode': barcode,
        'date_start_repairing': date_start_repairing,
        'date_end_repairing': date_end_repairing,
        'status': status
      };
}
