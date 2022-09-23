// ignore_for_file: file_names, must_be_immutable

import 'package:builder/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../systems/screen.dart';

class AddActionBig extends StatefulWidget {
  AddActionBig(
      {Key? key,
      required this.addAction,
      required this.widgetName,
      required this.icon})
      : super(key: key);
  Function() addAction;
  String widgetName;
  IconData icon;
  @override
  State<AddActionBig> createState() => _AddActionBigState();
}

class _AddActionBigState extends State<AddActionBig> {
  @override
  Widget build(BuildContext context) {
    Color scendryColor = context.watch<ScreenInfo>().scendryColor;
    Color backGroundColor = context.watch<ScreenInfo>().backGroundColor;

    Color textColor = context.watch<ScreenInfo>().textColor;
    return GestureDetector(
      onTap: () {
        widget.addAction();
      },
      child: Container(
        decoration: BoxDecoration(
            color: scendryColor, borderRadius: BorderRadius.circular(10)),
        height: boxSize.height,
        width: boxSize.width,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.icon,
                color: textColor,
                size: 30,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(widget.widgetName,
                  style: TextStyle(
                      color: textColor,
                      fontSize: 20,
                      fontFamily: "Tajawal",
                      fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ),
    );
  }
}
