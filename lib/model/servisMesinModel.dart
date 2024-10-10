import 'dart:convert';

List<ServisMesinModel> servisMesinFromJson(String str) {
  final jsonData = jsonDecode(str);

  return List<ServisMesinModel>.from(
      jsonData.map((x) => ServisMesinModel.fromJson(x)));
}

class ServisMesinModel {
  String? idServisMesin;
  String? tgl;
  String? idMesin;
  String? jenis;
  String? merk;
  String? tipe;
  String? noSeri;
  String? lokasi;
  String? line;
  String? status;
  String? startWaiting;

  ServisMesinModel({
    this.idServisMesin,
    this.tgl,
    this.idMesin,
    this.jenis,
    this.merk,
    this.tipe,
    this.noSeri,
    this.lokasi,
    this.line,
    this.status,
    this.startWaiting,
  });

  factory ServisMesinModel.fromJson(Map<String, dynamic> json) =>
      ServisMesinModel(
          idServisMesin: json['id_servis_mesin'],
          tgl: json['tgl'],
          idMesin: json['id_mesin'],
          jenis: json['jenis'],
          merk: json['merk'],
          tipe: json['tipe'],
          noSeri: json['no_seri'],
          lokasi: json['lokasi'],
          line: json['line'],
          status: json['status'],
          startWaiting: json['start_waiting']);

  Map<String, dynamic> toJson() => {
        'id_servis_mesin': idServisMesin,
        'tgl': tgl,
        'id_mesin': idMesin,
        'jenis': jenis,
        'merk': merk,
        'tipe': tipe,
        'no_seri': noSeri,
        'lokasi': lokasi,
        'line': line,
        'status': status,
        'start_waiting': startWaiting
      };
}
