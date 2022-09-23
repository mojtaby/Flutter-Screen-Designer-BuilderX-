// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../colors.dart';
import '../systems/screen.dart';

class ContainerForLessCode extends StatelessWidget {
  ContainerForLessCode({
    Key? key,
    this.child,
    this.setHight = true,
    this.color,
    this.height = null,
    this.width = 230,
  }) : super(key: key);
  Widget? child;
  bool? setHight;
  Color? color;
  double? height;
  double? width;
  @override
  Widget build(BuildContext context) {
    Color scendryColor = context.watch<ScreenInfo>().scendryColor;
    Color backGroundColor = context.watch<ScreenInfo>().backGroundColor;
    Color firstColor = context.watch<ScreenInfo>().firstColor;
    Color textColor = context.watch<ScreenInfo>().textColor;
    return FittedBox(
      fit: BoxFit.cover,
      child: Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: color ?? backGroundColor,
            border: Border.all(color: scendryColor, width: 1),
            borderRadius: BorderRadius.circular(5)),
        width: setHight == true ? textFieldSize.width : width,
        height: setHight == true ? textFieldSize.height : height,
        child: child,
      ),
    );
  }
}
