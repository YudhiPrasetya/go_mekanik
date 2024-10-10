class UserOrdersDetail {
  UserOrdersDetail({
    this.idUserMekanik,
    this.idMekanikmember,
    this.nik,
    this.nama,
    this.tgl,
    this.status,
    this.machineBrand,
    this.machineType,
    this.type,
    this.machineSN,
    this.symptomp,
  });

  final String? idUserMekanik;
  final String? idMekanikmember;
  final String? nik;
  final String? nama;
  final DateTime? tgl;
  final String? status;
  final String? machineBrand;
  final String? machineType;
  final String? type;
  final String? machineSN;
  final String? symptomp;

  factory UserOrdersDetail.fromJson(Map<String, dynamic> json) =>
      UserOrdersDetail(
          idUserMekanik: json["id_user_mekanik"],
          idMekanikmember: json["id_mekanik_member"],
          nik: json["NIK"],
          tgl: DateTime.parse(json["tgl"]),
          status: json["status"],
          machineBrand: json["machine_brand"],
          machineType: json["machine_type"],
          type: json["type"],
          machineSN: json["machine_sn"],
          symptomp: json["sympton"]);
}
