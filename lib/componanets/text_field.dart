// ignore_for_file: must_be_immutable, library_private_types_in_public_api

import 'package:builder/colors.dart';
import 'package:builder/systems/canvas_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:select_form_field/select_form_field.dart';

class TextFieldInAppBar extends StatefulWidget {
  TextFieldInAppBar({
    Key? key,
    required this.value,
    required this.textFieldName,
    required this.iconFieldName,
    required this.varValue,
    this.defaultValue = "0",
    this.type = "num",
    this.color,
    this.selectedScreen,
  }) : super(key: key);
  String textFieldName;
  String type;
  String defaultValue;
  IconData iconFieldName;
  Color? color = backGroundColor;
  MoGCanvasItem? selectedScreen;
  Function(dynamic) varValue;
  Function(String) value;
  @override
  _TextFieldInAppBarState createState() => _TextFieldInAppBarState();
}

class _TextFieldInAppBarState extends State<TextFieldInAppBar> {
  @override
  Widget build(BuildContext context) {
    return FittedBox(
        fit: BoxFit.fitWidth,
        child: Container(
          margin: EdgeInsets.all(5),
          width: textFieldSize.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 55,
                child: SelectFormField(
                  changeIcon: true,

                  decoration: InputDecoration(
                    fillColor: backGroundColor,
                    filled: true,
                    labelStyle: TextStyle(
                      color: textFieldColor,
                      fontFamily: "Tajawal",
                    ),
                    labelText: "Vars",
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
                  initialValue: "",

                  labelText: 'Type',
                  items: widget.selectedScreen!.screenVariables
                      .map((e) => {"label": e["name"], "value": e["value"]})
                      .toList(),
                  onChanged: (val) => widget.varValue(val),
                  onSaved: (val) => widget.varValue(val),
                ),
              ),
              SizedBox(
                width: 170,
                child: TextFormField(
                  style: const TextStyle(color: Colors.white),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    widget.type == "num"
                        ? FilteringTextInputFormatter.digitsOnly
                        : FilteringTextInputFormatter.singleLineFormatter
                  ],
                  onChanged: (value) {
                    widget.value(value);
                  },
                  controller: TextEditingController(text: widget.defaultValue),
                  decoration: InputDecoration(
                    fillColor: widget.color ?? backGroundColor,
                    filled: true,
                    labelStyle: TextStyle(
                      color: textFieldColor,
                      fontFamily: "Tajawal",
                    ),
                    labelText: widget.textFieldName,
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
                ),
              ),
            ],
          ),
        ));
  }

  Widget text() {
    return Text(
      widget.textFieldName,
      style: TextStyle(
          fontFamily: "Tajawal",
          fontSize: textFieldTextSize,
          color: textfieldTextColor),
    );
  }
}
