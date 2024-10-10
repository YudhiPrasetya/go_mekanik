import 'package:flutter/material.dart';

class Sympton extends StatelessWidget {
  final String sympton;

  const Sympton({
    Key? key,
    required this.sympton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
      child: Text(
        sympton,
        style: const TextStyle(
            // height: 10.0,
            fontSize: 26.0,
            fontFamily: 'Varela',
            fontWeight: FontWeight.bold,
            color: Colors.red),
        textAlign: TextAlign.justify,
      ),
    );
  }
}
