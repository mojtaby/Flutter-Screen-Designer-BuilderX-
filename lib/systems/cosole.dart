// ignore_for_file: must_be_immutable

import 'package:builder/colors.dart';
import 'package:builder/componanets/text.dart';
import 'package:flutter/material.dart';

class Console extends StatefulWidget {
  Console({super.key, this.stremer});
  Stream<String>? stremer;
  @override
  State<Console> createState() => _ConsoleState();
}

class _ConsoleState extends State<Console> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      height: 300,
      width: double.infinity,
      color: barsColor,
      child: Align(
        alignment: Alignment.topLeft,
        child: StreamBuilder<String>(
          stream: widget.stremer,
          builder: (context, snapshot) {
            return TextForLessCode(value: snapshot.data.toString());
          },
        ),
      ),
    );
  }
}
