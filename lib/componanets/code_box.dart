// ignore_for_file: must_be_immutable

import 'package:builder/colors.dart';
import 'package:builder/componanets/text.dart';
import 'package:flutter/material.dart';

class CodeBox extends StatelessWidget {
  CodeBox({super.key, this.add, this.name});
  String? name = "Loding..";
  Function? add;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        add!();
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        height: 100,
        width: 100,
        decoration: BoxDecoration(
            color: codeBox,
            border: Border.all(color: codeBoxBoder, width: 2),
            borderRadius: BorderRadius.circular(10)),
        child: TextForLessCode(
          value: name!,
          color: codeBoxText,
        ),
      ),
    );
  }
}
