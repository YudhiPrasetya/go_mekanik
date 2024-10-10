// To parse this JSON data, do
//
//     final userCanceledOrders = userCanceledOrdersFromJson(jsonString);

import 'dart:convert';

List<UserCanceledOrders> userCanceledOrdersFromJson(String str) =>
    List<UserCanceledOrders>.from((json.decode(str)['data'] != null
        ? json.decode(str)['data'].map((x) => UserCanceledOrders.fromJson(x))
        : List<UserCanceledOrders>));

String userCanceledOrdersToJson(List<UserCanceledOrders> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserCanceledOrders {
  UserCanceledOrders({
    required this.countId,
    required this.day,
  });

  int countId;
  String day;

  factory UserCanceledOrders.fromJson(Map<String, dynamic> json) =>
      UserCanceledOrders(
        countId: int.parse(json["count_id"]),
        day: json["day"],
      );

  Map<String, dynamic> toJson() => {
        "count_id": countId,
        "day": day,
      };
}
