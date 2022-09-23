import 'package:builder/colors.dart';
import 'package:builder/componanets/container.dart';
import 'package:builder/componanets/text.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:provider/provider.dart';

import '../systems/screen.dart';

class CheckBoxForLessCode extends StatefulWidget {
  CheckBoxForLessCode(
      {super.key,
      required this.text,
      required this.setValue,
      required this.value});
  bool value;
  String text;
  Function(bool newValue) setValue;
  @override
  State<CheckBoxForLessCode> createState() => _CheckBoxForLessCodeState();
}

class _CheckBoxForLessCodeState extends State<CheckBoxForLessCode> {
  bool? val;
  @override
  void initState() {
    val = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color scendryColor = context.watch<ScreenInfo>().scendryColor;
    Color backGroundColor = context.watch<ScreenInfo>().backGroundColor;
    Color firstColor = context.watch<ScreenInfo>().firstColor;
    Color textColor = context.watch<ScreenInfo>().textColor;
    return ContainerForLessCode(
      height: 50,
      setHight: false,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: TextForLessCode(value: widget.text),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: GFCheckbox(
              inactiveBorderColor: scendryColor,
              inactiveBgColor: backGroundColor,
              activeBgColor: scendryColor,
              onChanged: (value) {
                widget.setValue(value);
                setState(() {
                  val = value;
                });
              },
              value: val!,
            ),
          ),
        ],
      ),
    );
  }
}
