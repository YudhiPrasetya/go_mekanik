import 'dart:convert';

List<MasalahMesinModel> masalahMesinFromJson(String str) {
  final jsonData = jsonDecode(str);

  return List<MasalahMesinModel>.from(
      jsonData.map((x) => MasalahMesinModel.fromJson(x)));
}

class MasalahMesinModel {
  String? idMasalahMesin;
  String? masalahMesin;
  String? barcode;
  String? symptom;

  MasalahMesinModel(
      {this.idMasalahMesin, this.masalahMesin, this.barcode, this.symptom});

  factory MasalahMesinModel.fromJson(Map<String, dynamic> json) =>
      MasalahMesinModel(
          idMasalahMesin: json['id_masalah_mesin'],
          masalahMesin: json['masalah_mesin'],
          barcode: json['barcode'],
          symptom: json['symptom']);

  Map<String, dynamic> toJson() => {
        'id_masalah_mesin': idMasalahMesin,
        'masalah_mesin': masalahMesin,
        'barcode': barcode,
        'symptom': symptom
      };
}
