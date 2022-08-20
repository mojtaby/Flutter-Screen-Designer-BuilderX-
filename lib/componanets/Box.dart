// ignore_for_file: file_names, must_be_immutable

import 'package:builder/colors.dart';
import 'package:flutter/material.dart';

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
    return GestureDetector(
      onTap: () {
        widget.addAction();
      },
      child: Container(
        decoration: BoxDecoration(
            color: boxColor, borderRadius: BorderRadius.circular(10)),
        height: boxSize.height,
        width: boxSize.width,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.icon,
                color: boxIconColor,
                size: 30,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(widget.widgetName,
                  style: TextStyle(
                      color: boxTextColor,
                      fontSize: 20,
                      fontFamily: "Tajawal",
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
