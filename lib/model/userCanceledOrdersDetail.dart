// import 'dart:convert';

class UserCanceledOrdersDetail {
  final String? idUserMekanik;
  final String? idMekanikMember;
  final String? nik;
  final String? nama;
  final DateTime? tgl;
  final String? status;
  final String? machineBrand;
  final String? machineType;
  final String? type;
  final String? machineSN;
  final String? symptomp;

  UserCanceledOrdersDetail(
      {this.idUserMekanik,
      this.idMekanikMember,
      this.nik,
      this.nama,
      this.tgl,
      this.status,
      this.machineBrand,
      this.machineType,
      this.type,
      this.machineSN,
      this.symptomp});

  factory UserCanceledOrdersDetail.fromJson(Map<String, dynamic> json) =>
      UserCanceledOrdersDetail(
          idUserMekanik: json["id_user_mekanik"],
          idMekanikMember: json["id_mekanik_member"],
          nik: json["NIK"],
          nama: json["Nama"],
          tgl: DateTime.parse(json["tgl"]),
          status: json["status"],
          machineBrand: json["machine_brand"],
          machineType: json["machine_type"],
          type: json["type"],
          machineSN: json["machine_sn"],
          symptomp: json["sympton"]);
}
