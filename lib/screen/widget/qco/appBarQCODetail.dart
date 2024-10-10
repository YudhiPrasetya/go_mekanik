import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
AppBar AppBarQCODetail(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.lightBlue[800],
    elevation: 0.0,
    leading: IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(
        Icons.chevron_left,
        size: 32.0,
      ),
    ),
  );
}
