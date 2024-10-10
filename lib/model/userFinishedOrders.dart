// To parse this JSON data, do
//
//     final userFinishedOrders = userFinishedOrdersFromJson(jsonString);

import 'dart:convert';

List<UserFinishedOrders> userFinishedOrdersFromJson(String str) =>
    List<UserFinishedOrders>.from((json.decode(str)['data'] != null
        ? json.decode(str)['data'].map((x) => UserFinishedOrders.fromJson(x))
        : List<UserFinishedOrders>));

String userFinishedOrdersToJson(List<UserFinishedOrders> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserFinishedOrders {
  UserFinishedOrders({
    required this.countId,
    required this.day,
  });

  int countId;
  String day;

  factory UserFinishedOrders.fromJson(Map<String, dynamic> json) =>
      UserFinishedOrders(
        countId: int.parse(json["count_id"]),
        day: json["day"],
      );

  Map<String, dynamic> toJson() => {
        "count_id": countId,
        "day": day,
      };
}
