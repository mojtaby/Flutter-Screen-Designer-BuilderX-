// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../colors.dart';

class Bar extends StatelessWidget {
  Bar({super.key, required this.child});
  Widget child;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width > 850
        ? MediaQuery.of(context).size.width / 7
        : MediaQuery.of(context).size.width / 5;
    return SizedBox(
      height: bar2Size.height,
      width: width,
      child: Container(
          decoration: BoxDecoration(
              color: barsColor,
              border: Border(
                  right: BorderSide(
                      color: barSpriterColor, width: barSpriterSize))),
          padding: const EdgeInsets.all(10),
          child: child),
    );
  }
}
