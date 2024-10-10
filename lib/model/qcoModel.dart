import 'dart:convert';

List<QCOModel> qcoFromJson(String str) {
  final jsonData = jsonDecode(str);

  return List<QCOModel>.from(jsonData.map((x) => QCOModel.fromJson(x)));
}

class QCOModel {
  String? idQCO;
  String? idQCODetail;
  String? barcode;
  String? tgl;
  String? style;
  String? line;
  String? jenisBarang;
  String? merk;
  String? noSeri;
  String? status;
  String? startWaiting;
  String? endWaiting;
  String? startSetting;
  String? endSetting;
  String? location;

  QCOModel(
      {this.idQCO,
      this.idQCODetail,
      this.barcode,
      this.tgl,
      this.style,
      this.line,
      this.jenisBarang,
      this.merk,
      this.noSeri,
      this.status,
      this.startWaiting,
      this.endWaiting,
      this.startSetting,
      this.endSetting,
      this.location});

  factory QCOModel.fromJson(Map<String, dynamic> json) => QCOModel(
      idQCO: json['id_qco'],
      idQCODetail: json['id_qco_detail'],
      tgl: json['tgl'],
      style: json['style'],
      barcode: json['barcode'],
      jenisBarang: json['jenis_barang'],
      line: json['line'],
      merk: json['merk'],
      noSeri: json['no_seri'],
      status: json['status'],
      startWaiting: json['start_waiting'],
      endWaiting: json['end_waiting'],
      startSetting: json['start_setting'],
      endSetting: json['end_setting'],
      location: json['location']);

  Map<String, dynamic> toJson() => {
        'id_qco': idQCO,
        'id_qco_detail': idQCODetail,
        'tgl': tgl,
        'style': style,
        'barcode': barcode,
        'jenis_barang': jenisBarang,
        'line': line,
        'merk': merk,
        'no_seri': noSeri,
        'status': status,
        'start_waiting': startWaiting,
        'end_waiting': endWaiting,
        'start_setting': startSetting,
        'end_setting': endSetting,
        'location': location
      };
}
