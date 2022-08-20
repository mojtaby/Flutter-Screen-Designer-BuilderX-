// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class TextForLessCode extends StatelessWidget {
  TextForLessCode(
      {Key? key,
      required this.value,
      this.color = const Color.fromARGB(255, 232, 171, 66),
      this.size = 15})
      : super(key: key);
  String value;
  Color? color;
  double? size;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        value,
        style: TextStyle(
            fontFamily: "Tajawal",
            fontSize: size,
            fontWeight: FontWeight.bold,
            color: color),
      ),
    );
  }
}
