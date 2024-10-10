import 'dart:convert';

List<MekanikMemberModel> mekanikMemberModelFromJson(String str) {
  final jsonData = jsonDecode(str);

  return List<MekanikMemberModel>.from(
      jsonData.map((x) => MekanikMemberModel.fromJson(x)));
}

class MekanikMemberModel {
  String? idMekanikMember;
  String? nik;
  String? nama;
  String? inisial;
  String? bagian;
  String? shift;
  int? isMachineBreakdown;
  int? isQuickChange;
  int? isMaintenance;

  MekanikMemberModel({
    this.idMekanikMember,
    this.nik,
    this.nama,
    this.inisial,
    this.bagian,
    this.shift,
    this.isMachineBreakdown,
    this.isQuickChange,
    this.isMaintenance,
  });

  factory MekanikMemberModel.fromJson(Map<String, dynamic> json) =>
      MekanikMemberModel(
          idMekanikMember: json['ie_mekanik_member'],
          nik: json['nik'],
          nama: json['nama'],
          inisial: json['inisial'],
          bagian: json['bagian'],
          shift: json['shift'],
          isMachineBreakdown: json['isMachineBreakdown'],
          isQuickChange: json['isQuicChange'],
          isMaintenance: json['isMaintenance']);

  Map<String, dynamic> toJson() => {
        'id_mekanik_member': idMekanikMember,
        'nik': nik,
        'nama': nama,
        'inisial': inisial,
        'bagian': bagian,
        'shift': shift,
        'isMachineBreakdown': isMachineBreakdown,
        'isQuickChange': isQuickChange,
        'isMaintenance': isMaintenance
      };
}
