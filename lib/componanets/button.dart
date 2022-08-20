// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class ButtonForLessCode extends StatelessWidget {
  ButtonForLessCode(
      {Key? key,
      this.child,
      this.color,
      this.onClick,
      this.size = const Size(200, 35)})
      : super(key: key);
  Function()? onClick;
  Widget? child;
  Color? color;
  Size size;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height,
      width: size.width,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(primary: color),
          onPressed: onClick,
          child: child),
    );
  }
}
