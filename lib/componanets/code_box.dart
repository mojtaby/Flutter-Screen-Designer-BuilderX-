// ignore_for_file: must_be_immutable

import 'package:builder/colors.dart';
import 'package:builder/componanets/text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../systems/screen.dart';

class CodeBox extends StatelessWidget {
  CodeBox({super.key, this.add, this.name});
  String? name = "Loding..";
  Function? add;
  @override
  Widget build(BuildContext context) {
    Color scendryColor = context.watch<ScreenInfo>().scendryColor;
    Color backGroundColor = context.watch<ScreenInfo>().backGroundColor;
    Color firstColor = context.watch<ScreenInfo>().firstColor;
    Color textColor = context.watch<ScreenInfo>().textColor;
    return GestureDetector(
      onTap: () {
        add!();
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        height: 100,
        width: 100,
        decoration: BoxDecoration(
            color: scendryColor,
            border: Border.all(color: scendryColor, width: 2),
            borderRadius: BorderRadius.circular(10)),
        child: TextForLessCode(
          value: name!,
          color: textColor,
        ),
      ),
    );
  }
}
