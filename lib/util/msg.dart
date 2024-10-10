// import 'dart:convert';

// import 'package:flutter/rendering.dart';

class Msg {
  final int? value;
  final String? message;

  Msg({
    this.value,
    this.message,
  });

  factory Msg.fromJson(Map<String, dynamic> map) {
    return Msg(value: map['value'], message: map['message']);
  }

  Map<String, dynamic> toJson() {
    return {"value": value, "message": message};
  }

  @override
  String toString() {
    return '{value: $value, message: $message}';
  }
}
