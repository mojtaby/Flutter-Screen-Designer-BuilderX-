import 'dart:async';

import 'package:builder/colors.dart';
import 'package:builder/componanets/text.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:select_form_field/select_form_field.dart';

import '../systems/screen.dart';

// ignore: must_be_immutable
class VarMaker extends StatefulWidget {
  VarMaker(
      {super.key,
      required this.createVar,
      this.name = "gg",
      this.edite = false,
      this.isList = false,
      this.type = "Strings",
      this.value});

  Function(String varName, String varType, bool isList, dynamic value)
      createVar;

  bool edite = false;
  String type;
  String name;
  dynamic value;
  bool isList;
  @override
  State<VarMaker> createState() => _VarMakerState();
}

class _VarMakerState extends State<VarMaker> {
  final List<Map<String, dynamic>> _items = [
    {
      'value': 'String',
    },
    {
      'value': 'int',
    },
    {
      'value': 'bool',
    },
    {
      'value': 'dynamic',
    },
    {
      'value': 'double',
    },
    {
      'value': 'dynamic',
    },
  ];
  String varName = "";
  String varType = "";
  bool isList = false;
  dynamic varValue;
  bool error = false;
  void initState() {
    if (widget.edite == true) {
      varName = widget.name;
      varType = widget.type;
      isList = widget.isList;
      varValue = widget.value;

      setState(() {});
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color scendryColor = context.watch<ScreenInfo>().scendryColor;
    Color backGroundColor = context.watch<ScreenInfo>().backGroundColor;
    Color firstColor = context.watch<ScreenInfo>().firstColor;
    return SizedBox(
      height: 400,
      width: 300,
      child: Container(
        decoration: BoxDecoration(
            color: firstColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1, color: firstColor)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextForLessCode(
                value: "Create Var",
                color: scendryColor,
              ),
            ),
            textField("Var name", (value) {
              varName = value;
              setState(() {});
            }, widget.name != null ? widget.name : "", scendryColor,
                backGroundColor),
            dropDown("Var type", scendryColor, backGroundColor),
            checkedBox("List ?", scendryColor, firstColor),
            textField("Value", (value) {
              varValue = value;
              setState(() {});
            }, widget.value != null ? widget.value : "", scendryColor,
                backGroundColor),
            Visibility(
                visible: error,
                child: TextForLessCode(
                  value: "You need to fill in all fields",
                  color: Colors.red,
                  size: 15,
                )),
            Align(
              alignment: Alignment.centerRight,
              child: button("Create", scendryColor, backGroundColor),
            )
          ],
        ),
      ),
    );
  }

  Widget textField(String name, Function(dynamic value) onChange, String value,
      scendryColor, backGroundColor) {
    return SizedBox(
      height: 50,
      width: 220,
      child: Material(
        color: scendryColor,
        type: MaterialType.card,
        child: TextFormField(
            initialValue: widget.edite == true ? value : "",
            onChanged: onChange,
            cursorColor: scendryColor,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: "Tajawal",
            ),
            decoration: InputDecoration(
              fillColor: backGroundColor,
              filled: true,
              labelStyle: TextStyle(
                color: scendryColor,
                fontFamily: "Tajawal",
              ),
              labelText: name,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                  color: scendryColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(3.0),
                borderSide: BorderSide(
                  color: scendryColor,
                  width: 1.0,
                ),
              ),
            )),
      ),
    );
  }

  Widget checkedBox(String name, scendryColor, backGroundColor) {
    return SizedBox(
      width: 400,
      child: Material(
        color: backGroundColor,
        type: MaterialType.card,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextForLessCode(
              value: name,
              color: scendryColor,
            ),
            Checkbox(
              fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                if (states.contains(MaterialState.disabled)) {
                  return scendryColor;
                }
                return scendryColor;
              }),
              checkColor: backGroundColor,
              tristate: true,
              activeColor: scendryColor,
              onChanged: (e) {
                isList = !isList;
                setState(() {});
              },
              value: isList,
            ),
          ],
        ),
      ),
    );
  }

  Widget dropDown(String name, scendryColor, backGroundColor) {
    return SizedBox(
        height: 53,
        width: 220,
        child: Material(
            color: backGroundColor,
            type: MaterialType.card,
            child: SelectFormField(
              decoration: InputDecoration(
                fillColor: backGroundColor,
                filled: true,
                labelStyle: TextStyle(
                  color: scendryColor,
                  fontFamily: "Tajawal",
                ),
                labelText: name,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(
                    color: scendryColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3.0),
                  borderSide: BorderSide(
                    color: scendryColor,
                    width: 1.0,
                  ),
                ),
              ),
              type: SelectFormFieldType.dropdown, // or can be dialog
              initialValue: widget.edite == true ? widget.type : "",

              labelText: 'Type',
              items: _items,
              onChanged: (val) => varType = val,
              onSaved: (val) => varType = val!,
            )));
  }

  Widget button(String name, scendryColor, backGroundColor) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            primary: scendryColor, backgroundColor: scendryColor),
        onPressed: () {
          if (varValue != null) {
            widget.createVar(varName, varType, isList, varValue);
            Navigator.pop(context);
          } else {
            error = true;
            Timer.periodic(const Duration(seconds: 5), (timter) {
              error = false;
              setState(() {});
            });
            setState(() {});
          }
        },
        child: TextForLessCode(
          value: name,
          color: backGroundColor,
        ),
      ),
    );
  }
}
