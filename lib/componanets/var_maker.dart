import 'dart:async';

import 'package:builder/colors.dart';
import 'package:builder/componanets/text.dart';

import 'package:flutter/material.dart';
import 'package:select_form_field/select_form_field.dart';

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
      'value': 'string',
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
    return SizedBox(
      height: 400,
      width: 300,
      child: Container(
        decoration: BoxDecoration(
            color: barsColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1, color: textFieldColor)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextForLessCode(value: "Create Var"),
            ),
            textField("Var name", (value) {
              varName = value;
              setState(() {});
            }, widget.name != null ? widget.name : ""),
            dropDown("Var type"),
            checkedBox("List ?"),
            textField("Value", (value) {
              varValue = value;
              setState(() {});
            }, widget.value != null ? widget.value : ""),
            Visibility(
                visible: error,
                child: TextForLessCode(
                  value: "You need to fill in all fields",
                  color: Colors.red,
                  size: 15,
                )),
            Align(
              alignment: Alignment.centerRight,
              child: button("Create"),
            )
          ],
        ),
      ),
    );
  }

  Widget textField(
      String name, Function(dynamic value) onChange, String value) {
    return SizedBox(
      height: 50,
      width: 220,
      child: Material(
        color: barsColor,
        type: MaterialType.card,
        child: TextFormField(
            initialValue: widget.edite == true ? value : "",
            onChanged: onChange,
            cursorColor: textFieldColor,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: "Tajawal",
            ),
            decoration: InputDecoration(
              fillColor: backGroundColor,
              filled: true,
              labelStyle: TextStyle(
                color: textFieldColor,
                fontFamily: "Tajawal",
              ),
              labelText: name,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                  color: textFieldColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(3.0),
                borderSide: BorderSide(
                  color: barSpriterColor,
                  width: 1.0,
                ),
              ),
            )),
      ),
    );
  }

  Widget checkedBox(String name) {
    return SizedBox(
      width: 400,
      child: Material(
        color: barsColor,
        type: MaterialType.card,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextForLessCode(value: name),
            Checkbox(
              fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                if (states.contains(MaterialState.disabled)) {
                  return textFieldColor;
                }
                return textFieldColor;
              }),
              checkColor: backGroundColor,
              tristate: true,
              activeColor: textFieldColor,
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

  Widget dropDown(
    String name,
  ) {
    return SizedBox(
        height: 53,
        width: 220,
        child: Material(
            color: barsColor,
            type: MaterialType.card,
            child: SelectFormField(
              decoration: InputDecoration(
                fillColor: backGroundColor,
                filled: true,
                labelStyle: TextStyle(
                  color: textFieldColor,
                  fontFamily: "Tajawal",
                ),
                labelText: name,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(
                    color: textFieldColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3.0),
                  borderSide: BorderSide(
                    color: barSpriterColor,
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

  Widget button(String name) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            primary: barSpriterColor, backgroundColor: textFieldColor),
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
