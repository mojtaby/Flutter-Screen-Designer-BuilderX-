// ignore_for_file: must_be_immutable, library_private_types_in_public_api

import 'package:builder/colors.dart';
import 'package:builder/componanets/button.dart';
import 'package:builder/componanets/text.dart';
import 'package:builder/systems/canvas_controller.dart';
import 'package:builder/systems/screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:select_form_field/select_form_field.dart';

class TextFieldInWithVar extends StatefulWidget {
  TextFieldInWithVar({
    Key? key,
    required this.value,
    required this.textFieldName,
    required this.varValue,
    this.valueFromSave,
    this.defaultValue = "0",
    this.type = "num",
    this.color,
    this.selectedScreen,
    this.canSetFromVar = true,
    this.width = 230,
    this.hight = 60,
    this.haveTextFiled = true,
    this.fromVar = true,
    this.haveSaveButton = false,
    this.itmes,
  }) : super(key: key);
  String textFieldName;
  String type;
  String defaultValue;
  bool fromVar;
  bool haveSaveButton;
  Color? color;
  List<String>? itmes;
  MoGCanvasItem? selectedScreen;
  bool canSetFromVar;
  bool haveTextFiled;
  double width;
  double hight;
  Function(dynamic) varValue;
  Function(String) value;
  Function(String)? valueFromSave;
  @override
  _TextFieldInWithVarState createState() => _TextFieldInWithVarState();
}

class _TextFieldInWithVarState extends State<TextFieldInWithVar> {
  String value = "";

  @override
  Widget build(BuildContext context) {
    Color scendryColor = context.watch<ScreenInfo>().scendryColor;
    Color backGroundColor = context.watch<ScreenInfo>().backGroundColor;
    Color firstColor = context.watch<ScreenInfo>().firstColor;
    Color textColor = context.watch<ScreenInfo>().textColor;
    return FittedBox(
        fit: BoxFit.fitWidth,
        child: Container(
          margin: widget.canSetFromVar != true
              ? const EdgeInsets.all(2)
              : const EdgeInsets.all(5),
          height: widget.canSetFromVar != true
              ? widget.hight
              : textFieldSize.height,
          width:
              widget.canSetFromVar != true ? widget.width : textFieldSize.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Visibility(
                visible: widget.canSetFromVar,
                child: SizedBox(
                  width: widget.haveTextFiled ? 55 : widget.width,
                  child: SelectFormField(
                    changeIcon: true,

                    decoration: InputDecoration(
                      fillColor: backGroundColor,
                      filled: true,
                      labelStyle: TextStyle(
                        color: scendryColor,
                        fontFamily: "Tajawal",
                      ),
                      labelText: "Vars",
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
                    initialValue: "",

                    labelText: 'Type',
                    items: widget.fromVar
                        ? widget.selectedScreen!.screenVariables
                            .map((e) =>
                                {"label": e["name"], "value": e["value"]})
                            .toList()
                        : widget.itmes!
                            .map((e) => {"label": e, "value": e})
                            .toList(),
                    onChanged: (val) {
                      widget.varValue(val);
                      value = val;
                    },
                    onSaved: (val) {
                      widget.varValue(val);
                      value = val!;
                    },
                  ),
                ),
              ),
              Visibility(
                visible: widget.haveTextFiled,
                child: SizedBox(
                  width: widget.canSetFromVar != true ? widget.width : 170,
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
                      value = value;
                    },
                    controller:
                        TextEditingController(text: widget.defaultValue),
                    decoration: InputDecoration(
                      fillColor: widget.color ?? backGroundColor,
                      filled: true,
                      labelStyle: TextStyle(
                        color: scendryColor,
                        fontFamily: "Tajawal",
                      ),
                      labelText: widget.textFieldName,
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
                  ),
                ),
              ),
              Visibility(
                visible: widget.haveSaveButton,
                child: ButtonForOutline(
                  buttonColor: scendryColor,
                  size: Size(55, 60),
                  onClick: () {
                    widget.valueFromSave!(value);
                  },
                  text: "Save",
                  textcolor: Colors.white,
                ),
              )
            ],
          ),
        ));
  }

  Widget text(scendryColor) {
    return Text(
      widget.textFieldName,
      style: TextStyle(
          fontFamily: "Tajawal",
          fontSize: textFieldTextSize,
          color: scendryColor),
    );
  }
}
