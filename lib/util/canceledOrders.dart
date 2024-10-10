class CanceledOrders {
  // ignore: non_constant_identifier_names
  // final String id_user_mekanik;
  // final String status;
  // ignore: non_constant_identifier_names
  final String count_tgl;

  // ignore: non_constant_identifier_names
  CanceledOrders({required this.count_tgl});

  factory CanceledOrders.fromJson(Map<String, dynamic> json) {
    return CanceledOrders(
        // id_user_mekanik: json['id_user_mekanik'],
        // status: json['status'],
        count_tgl: json['count_tgl']);
  }

  @override
  String toString() {
    return 'CanceledOrders: {count_tgl = $count_tgl}';
  }
}
