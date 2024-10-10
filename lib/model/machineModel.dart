class MachineModel {
  String? idMachine;
  String? noInventaris;
  String? kategoriBarang;
  String? jnsBarang;
  String? idMerk;
  String? type;
  String? noSeri;
  String? kodeBarang;
  String? kodeBarcode;
  String? urlBarcode;
  String? idJnsDoc;
  String? noBC;
  String? tglDocument;
  String? tglMasuk;
  String? statusBarang;
  String? lokasiAkhir;
  String? tglEdited;
  String? keterangan;
  String? mesinNo;
  String? idLokasi;
  String? scanUpdated;
  String? rfID;
  String? locRFID;

  MachineModel(
      {this.idMachine,
      this.noInventaris,
      this.kategoriBarang,
      this.jnsBarang,
      this.idMerk,
      this.type,
      this.noSeri,
      this.kodeBarang,
      this.kodeBarcode,
      this.urlBarcode,
      this.idJnsDoc,
      this.noBC,
      this.tglDocument,
      this.tglMasuk,
      this.statusBarang,
      this.lokasiAkhir,
      this.tglEdited,
      this.keterangan,
      this.mesinNo,
      this.idLokasi,
      this.scanUpdated,
      this.rfID,
      this.locRFID});

  factory MachineModel.fromJson(Map<String, dynamic> json) => MachineModel(
      idMachine: json['id_barang'],
      noInventaris: json['no_inventaris'],
      kategoriBarang: json['kategori_barang'],
      jnsBarang: json['jns_barang'],
      idMerk: json['id_merk'],
      type: json['type'],
      noSeri: json['no_seri'],
      kodeBarang: json['kode_barang'],
      kodeBarcode: json['kode_barcode'],
      urlBarcode: json['url_barcode'],
      idJnsDoc: json['id_jnsdoc'],
      noBC: json['no_bc'],
      tglDocument: json['tgl_document'],
      tglMasuk: json['tgl_masuk'],
      statusBarang: json['status_barang'],
      lokasiAkhir: json['lokasi_akhir'],
      tglEdited: json['tgl_edited'],
      keterangan: json['keterangan'],
      mesinNo: json['Mesin_No'],
      idLokasi: json['id_lokasi'],
      scanUpdated: json['scan_updated'],
      rfID: json['rfID'],
      locRFID: json['loc_rfID']);

  Map<String, dynamic> toJson() => {
        'id_barang': idMachine,
        'no_inventaris': noInventaris,
        'kategori_barang': kategoriBarang,
        'jns_barang': jnsBarang,
        'id_merk': idMerk,
        'type': type,
        'no_seri': noSeri,
        'kode_barang': kodeBarang,
        'kode_barcode': kodeBarcode,
        'url_barcode': urlBarcode,
        'id_jnsdoc': idJnsDoc,
        'no_bc': noBC,
        'tgl_document': tglDocument,
        'tgl_masuk': tglMasuk,
        'status_barang': statusBarang,
        'lokasi_akhir': lokasiAkhir,
        'tgl_edited': tglEdited,
        'keterangan': keterangan,
        'Mesin_No': mesinNo,
        'id_lokasi': idLokasi,
        'scan_updated': scanUpdated,
        'rfID': rfID,
        'loc_rfID': locRFID
      };
}
