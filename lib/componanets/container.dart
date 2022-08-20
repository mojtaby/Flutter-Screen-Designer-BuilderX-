// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../colors.dart';

class ContainerForLessCode extends StatelessWidget {
  ContainerForLessCode({
    Key? key,
    this.child,
    this.setHight = true,
    this.color,
  }) : super(key: key);
  Widget? child;
  bool? setHight;
  Color? color;
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.cover,
      child: Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: color ?? backGroundColor,
            border: Border.all(color: barSpriterColor, width: 1),
            borderRadius: BorderRadius.circular(5)),
        width: textFieldSize.width,
        height: setHight == true ? textFieldSize.height : null,
        child: child,
      ),
    );
  }
}
