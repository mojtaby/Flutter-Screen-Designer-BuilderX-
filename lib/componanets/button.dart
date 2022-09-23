// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class ButtonForOutline extends StatelessWidget {
  ButtonForOutline(
      {Key? key,
      this.text = "button",
      this.onClick,
      this.stander = true,
      this.buttonColor = const Color.fromARGB(255, 0, 82, 234),
      this.textcolor = Colors.white,
      this.size = const Size(220, 50)})
      : super(key: key);
  Function()? onClick;
  Color buttonColor;
  String text;
  Color? textcolor;
  Size size;
  bool stander;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: stander ? EdgeInsets.all(5) : EdgeInsets.all(0),
      height: size.height,
      width: size.width,
      child: GFButton(
        hoverColor: buttonColor,
        color: buttonColor,
        onPressed: () {
          onClick!();
        },
        textStyle: TextStyle(color: textcolor),
        text: text,
        shape: stander ? GFButtonShape.standard : GFButtonShape.pills,
        type: stander ? GFButtonType.solid : GFButtonType.outline,
      ),
    );
  }
}

class ButtonForRounded extends StatelessWidget {
  ButtonForRounded(
      {Key? key,
      this.text = "button",
      this.onClick,
      this.buttonColor = const Color.fromARGB(255, 0, 82, 234),
      this.textcolor = Colors.white,
      this.stander = true,
      this.size = const Size(220, 50)})
      : super(key: key);
  Function()? onClick;
  Color buttonColor;
  String text;
  Color? textcolor;
  Size size;
  bool stander;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height,
      width: size.width,
      child: GFButton(
        hoverColor: buttonColor,
        color: buttonColor,
        onPressed: () {
          onClick!();
        },
        textStyle: TextStyle(color: textcolor),
        text: text,
        shape: stander ? GFButtonShape.standard : GFButtonShape.pills,
      ),
    );
  }
}
