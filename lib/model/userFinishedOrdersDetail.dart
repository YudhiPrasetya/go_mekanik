// To parse this JSON data, do
//
//     final userOrdersFinishedDetail = userOrdersFinishedDetailFromJson(jsonString);

import 'dart:convert';

List<UserOrdersFinishedDetail> userOrdersFinishedDetailFromJson(String str) =>
    List<UserOrdersFinishedDetail>.from(
        json.decode(str).map((x) => UserOrdersFinishedDetail.fromJson(x)));

String userOrdersFinishedDetailToJson(List<UserOrdersFinishedDetail> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserOrdersFinishedDetail {
  UserOrdersFinishedDetail(
      {this.idMekanikMember,
      this.idUserMekanik,
      this.nik,
      this.nama,
      this.date,
      this.status,
      this.machineBrand,
      this.machineType,
      this.type,
      this.machineSn,
      this.sympton,
      this.duration});

  String? idMekanikMember;
  String? idUserMekanik;
  String? nik;
  String? nama;
  DateTime? date;
  String? status;
  String? machineBrand;
  String? machineType;
  String? type;
  String? machineSn;
  String? sympton;
  String? duration;

  factory UserOrdersFinishedDetail.fromJson(Map<String, dynamic> json) =>
      UserOrdersFinishedDetail(
          idMekanikMember: json["id_mekanik_member"],
          idUserMekanik: json["id_user_mekanik"],
          nik: json["NIK"],
          nama: json["Nama"],
          date: DateTime.parse(json["date"]),
          status: json["status"],
          machineBrand: json["machine_brand"],
          machineType: json["machine_type"],
          type: json["type"],
          machineSn: json["machine_sn"],
          sympton: json["sympton"],
          duration: json["duration"]);

  Map<String, dynamic> toJson() => {
        "id_mekanik_member": idMekanikMember,
        "id_user_mekanik": idUserMekanik,
        "NIK": nik,
        "Nama": nama,
        "date": date?.toIso8601String(),
        "status": status,
        "machine_brand": machineBrand,
        "machine_type": machineType,
        "type": type,
        "machine_sn": machineSn,
        "sympton": sympton,
        "duration": duration
      };
}
