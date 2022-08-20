// ignore_for_file: must_be_immutable, avoid_types_as_parameter_names

import 'package:builder/colors.dart';
import 'package:builder/componanets/button.dart';
import 'package:builder/componanets/container.dart';
import 'package:builder/componanets/text.dart';
import 'package:builder/componanets/var_maker.dart';
import 'package:builder/systems/canvas_controller.dart';

import 'package:builder/componanets/text_field.dart';
import 'package:builder/systems/widget.dart';

import 'package:flutter/material.dart';

import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:modern_icon_picker/flutter_icon_picker.dart';

import 'package:provider/provider.dart';
import 'package:resizable_widget/resizable_widget.dart';
import 'package:select_form_field/select_form_field.dart';

class PropertesBar extends StatefulWidget {
  PropertesBar(
      {Key? key,
      this.widgetType = "null",
      this.childType = "null",
      this.widget,
      required this.selectedScreen,
      this.setwidget,
      this.deleteWidget,
      this.colosUi,
      this.deleteScreen,
      this.updateUI,
      this.openCodePanle})
      : super(key: key);
  String widgetType;
  String childType;

  WidgetMoG? widget;

  Function(WidgetMoG child)? setwidget;
  Function(WidgetMoG id)? deleteWidget;
  Function(MoGCanvasItem id)? deleteScreen;
  Function()? colosUi;
  Function()? updateUI;
  Function()? openCodePanle;
  MoGCanvasItem? selectedScreen;
  @override
  State<PropertesBar> createState() => _PropertesBarState();
}

class _PropertesBarState extends State<PropertesBar> {
  List<Widget> propertes = [];
  bool lightTheme = true;
  Color currentColor = Colors.amber;
  List<Color> currentColors = [Colors.yellow, Colors.green];
  List<Color> colorHistory = [];

  void changeColor(Color color) => currentColor = color;
  void changeColors(List<Color> colors) => currentColors = colors;

  bool visible = true;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width > 800
        ? MediaQuery.of(context).size.width / 6
        : MediaQuery.of(context).size.width / 3;

    return SizedBox(
      height: bar2Size.height,
      width: width,
      child: ResizableWidget(
        isHorizontalSeparator: false,
        isDisabledSmartHide: false,
        separatorColor: barSpriterColor,
        separatorSize: barSpriterSize,
        percentages: const [0.1, 0.9],
        children: [
          const SizedBox(),
          Container(
            padding: const EdgeInsets.all(5),
            color: barsColor,
            child: SingleChildScrollView(
                child: Wrap(children: [
              Container(
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: backGroundColor,
                    borderRadius: BorderRadius.circular(5)),
                height: 50,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FittedBox(
                        fit: BoxFit.cover,
                        child: Center(
                          child: TextForLessCode(
                            value: widget.widgetType[0].toUpperCase() +
                                widget.widgetType.substring(1).toLowerCase(),
                            size: 20,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (widget.widgetType == "screen") {
                            widget.deleteScreen!(widget.selectedScreen!);
                          } else {
                            widget.deleteWidget!(widget.widget!);
                          }

                          widget.colosUi!();
                          widget.updateUI!();
                        },
                        child: const Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                          size: 20,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: visible,
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: properies(
                        widget.widgetType,
                        context,
                        widget.widget,
                        false,
                        widget.widgetType,
                        backGroundColor,
                        widget.selectedScreen!,
                        400),
                  ),
                ),
              ),
            ])),
          ),
        ],
      ),
    );
  }

  // check the widget and set fields
  List<Widget> properies(
    String type,
    BuildContext context,
    WidgetMoG? widgete,
    bool isItAchild,
    String typ,
    Color color,
    MoGCanvasItem screen,
    double height,
  ) {
    if (typ == "screen") {
      return [
        stringfields("screen", "labele", "Screen name", Icons.text_snippet,
            isItAchild, color, screen, screen.labele),
        appBar(screen),
        flotingButton(screen),
        drawer(screen),
        colorPciker(isItAchild, context, (color) {
          screen.backGroundColor = color.toColor();
          widget.updateUI!();
        }, screen.backGroundColor, height),
        ContainerForLessCode(
          setHight: false,
          child: Padding(
            padding: const EdgeInsets.all(7.0),
            child: ButtonForLessCode(
              color: textFieldColor,
              child: TextForLessCode(
                value: "Create Var",
                color: Colors.white,
              ),
              onClick: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        backgroundColor: Colors.transparent,
                        child: VarMaker(
                          edite: false,
                          createVar: (varName, varType, isList, value) {
                            widget.selectedScreen!
                                .varMaker(varName, varType, isList, value);
                            widget.updateUI!();
                            widget.colosUi!();
                          },
                        ),
                      );
                    });
              },
            ),
          ),
        ),
        screenVars(),
      ];
    } else if (typ == "text") {
      return [
        stringfields("widget", "textValue", "Value", Icons.text_format,
            isItAchild, color, screen, "null"),
        colorPciker(isItAchild, context, (color) {
          checkValueTypeAndSetIt(
              "string", "color", color.toColor(), isItAchild);
        }, widget.widget!.widget["color"], height),
        numfields("widget", "textFontsize", "Size", Icons.format_size_outlined,
            isItAchild, color, screen),
      ];
    } else if (typ == "container") {
      return [
        colorPciker(isItAchild, context, (color) {
          checkValueTypeAndSetIt(
              "string", "color", color.toColor(), isItAchild);
        }, widget.widget!.widget["color"], height),
        numfields("widget", "height", "Height", Icons.height_outlined,
            isItAchild, color, screen),
        numfields("widget", "width", "Width", Icons.width_normal_outlined,
            isItAchild, color, screen),
      ];
    } else if (typ == "row") {
      return [
        numfields("widget", "height", "Height", Icons.height_outlined, false,
            color, screen),
        numfields("widget", "width", "Width", Icons.width_normal_outlined,
            false, color, screen),
        dropDown(
            widget.widget!.widget["mainAxisAlignment"],
            [
              {"value": "Center"},
              {"value": "End"},
              {"value": "Start"},
              {"value": "SpaceAround"},
              {"value": "SpaceBetween"}
            ],
            isItAchild,
            "mainAxisAlignment",
            18,
            backGroundColor),
        dropDown(
            widget.widget!.widget["crossAxisAlignment"],
            [
              {"value": "Center"},
              {"value": "End"},
              {"value": "Start"},
              {"value": "Stretch"}
            ],
            isItAchild,
            "crossAxisAlignment",
            19,
            backGroundColor),
        childrenShowerUi(),
      ];
    } else if (typ == "column") {
      return [
        numfields("widget", "height", "Height", Icons.height_outlined, false,
            color, screen),
        numfields("widget", "width", "Width", Icons.width_normal_outlined,
            false, color, screen),
        dropDown(
            widget.widget!.widget["mainAxisAlignment"],
            [
              {"value": "Center"},
              {"value": "End"},
              {"value": "Start"},
              {"value": "SpaceAround"},
              {"value": "SpaceBetween"}
            ],
            isItAchild,
            "mainAxisAlignment",
            18,
            backGroundColor),
        dropDown(
            widget.widget!.widget["crossAxisAlignment"],
            [
              {"value": "Center"},
              {"value": "End"},
              {"value": "Start"},
              {"value": "Stretch"}
            ],
            isItAchild,
            "crossAxisAlignment",
            19,
            backGroundColor),
        childrenShowerUi(),
      ];
    } else if (typ == "image") {
      return [
        numfields("widget", "height", "Height", Icons.height_outlined, false,
            color, screen),
        numfields("widget", "width", "Width", Icons.width_normal_outlined,
            false, color, screen),
        stringfields("widget", "imageUrl", "Url", Icons.http, isItAchild, color,
            screen, "null"),
        dropDown(
            widget.widget!.widget["imageBoxFit"],
            [
              {"value": "Contain"},
              {"value": "Cover"},
              {"value": "Fill"},
              {"value": "FitWidth"},
              {"value": "FitHeight"},
              {"value": "ScaleDown"}
            ],
            isItAchild,
            "boxFit",
            7,
            backGroundColor)
      ];
    } else if (typ == "icon") {
      return [
        iconPicker(isItAchild, context),
        colorPciker(isItAchild, context, (color) {
          checkValueTypeAndSetIt(
              "string", "color", color.toColor(), isItAchild);
        }, widget.widget!.widget["color"], height),
        numfields("widget", "size", "Size", Icons.height_sharp, isItAchild,
            color, screen),
      ];
    } else if (typ == "stack") {
      return [
        numfields("widget", "height", "Height", Icons.height_outlined, false,
            color, screen),
        numfields("widget", "width", "Width", Icons.width_normal_outlined,
            false, color, screen),
        childrenShowerUi(),
      ];
    } else if (typ == "button") {
      return [
        colorPciker(isItAchild, context, (color) {
          checkValueTypeAndSetIt(
              "string", "color", color.toColor(), isItAchild);
        }, widget.widget!.widget["color"], height),
        numfields("widget", "height", "Height", Icons.height_outlined,
            isItAchild, color, screen),
        numfields("widget", "width", "Width", Icons.width_normal_outlined,
            isItAchild, color, screen),
        ContainerForLessCode(
          setHight: false,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: ButtonForLessCode(
              color: textFieldColor,
              child: TextForLessCode(
                value: "On click",
                color: Colors.white,
              ),
              onClick: () {
                widget.openCodePanle!();
              },
            ),
          ),
        )
      ];
    } else if (typ == "checkbox") {
      return [
        colorPciker(isItAchild, context, (color) {
          checkValueTypeAndSetIt(
              "string", "color", color.toColor(), isItAchild);
        }, widget.widget!.widget["color"], height),
        numfields("widget", "height", "Height", Icons.height_outlined,
            isItAchild, color, screen),
        numfields("widget", "width", "Width", Icons.width_normal_outlined,
            isItAchild, color, screen),
      ];
    } else {
      return [];
    }
  }

  Widget screenVars() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextForLessCode(value: "Screen Vars List"),
        ),
        ContainerForLessCode(
          setHight: false,
          child: Column(
              children: widget.selectedScreen!.screenVariables
                  .map((e) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ContainerForLessCode(
                          setHight: false,
                          color: barsColor,
                          child: SizedBox(
                            height: 40,
                            child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                          backgroundColor: Colors.transparent,
                                          child: VarMaker(
                                            type: e["type"],
                                            edite: true,
                                            name: e["name"],
                                            value: e["value"],
                                            isList: e["isList"],
                                            createVar: (varName, varType,
                                                isList, value) {
                                              widget.selectedScreen!.varEditor(
                                                  e,
                                                  varName,
                                                  varType,
                                                  isList,
                                                  value);

                                              widget.colosUi!();
                                              setState(() {});
                                            },
                                          ),
                                        );
                                      });
                                },
                                child: TextForLessCode(
                                  value:
                                      " ${e["name"]} (${e["type"]}) = ${e["value"]}",
                                )),
                          ),
                        ),
                      ))
                  .toList()),
        ),
      ],
    );
  }

  Widget appBar(MoGCanvasItem screen) {
    return ContainerForLessCode(
      child: chackBox("App Bar", screen.appBar, (bol) {
        screen.appBar = bol;
        widget.colosUi!();
        widget.updateUI!();
      }),
    );
  }

  Widget flotingButton(MoGCanvasItem screen) {
    return ContainerForLessCode(
      child:
          chackBox("FloatingActionButton", screen.floatingActionButton, (bol) {
        screen.floatingActionButton = bol;
        widget.colosUi!();
        widget.updateUI!();
      }),
    );
  }

  Widget drawer(MoGCanvasItem screen) {
    return ContainerForLessCode(
      child: chackBox("Drawer", screen.drawer, (bol) {
        screen.drawer = bol;
        widget.colosUi!();
        widget.updateUI!();
      }),
    );
  }

  Widget dropDown(dynamic value, List<Map<String, dynamic>> itmes,
      bool isItAchild, String type, int skipNubmer, color) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
          height: 53,
          width: 220,
          child: SelectFormField(
            decoration: InputDecoration(
              fillColor: backGroundColor,
              filled: true,
              labelStyle: TextStyle(
                color: textFieldColor,
                fontFamily: "Tajawal",
              ),
              labelText: type,
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
            initialValue: value.toString(),

            items: itmes,
            onChanged: (val) {
              dropFun(val, type, isItAchild);
            },
            onSaved: (val) {
              dropFun(val!, type, isItAchild);
            },
          )),
    );
  }

  void dropFun(String value, String type, bool isItAchild) {
    if (value == "Contain" && type == "boxFit") {
      return checkValueTypeAndSetIt(
          "string", "imageBoxFit", BoxFit.contain, isItAchild);
    } else if (value == "Cover" && type == "boxFit") {
      return checkValueTypeAndSetIt(
          "string", "imageBoxFit", BoxFit.cover, isItAchild);
    } else if (value == "Fill" && type == "boxFit") {
      return checkValueTypeAndSetIt(
          "string", "imageBoxFit", BoxFit.fill, isItAchild);
    } else if (value == "FitWidth" && type == "boxFit") {
      return checkValueTypeAndSetIt(
          "string", "imageBoxFit", BoxFit.fitWidth, isItAchild);
    } else if (value == "FitHeight" && type == "boxFit") {
      return checkValueTypeAndSetIt(
          "string", "imageBoxFit", BoxFit.fitHeight, isItAchild);
    } else if (value == "ScaleDown" && type == "boxFit") {
      return checkValueTypeAndSetIt(
          "string", "imageBoxFit", BoxFit.scaleDown, isItAchild);
    } else if (value == "Center" && type == "mainAxisAlignment") {
      return checkValueTypeAndSetIt(
          "string", "mainAxisAlignment", MainAxisAlignment.center, isItAchild);
    } else if (value == "End" && type == "mainAxisAlignment") {
      return checkValueTypeAndSetIt(
          "string", "mainAxisAlignment", MainAxisAlignment.end, isItAchild);
    } else if (value == "Start" && type == "mainAxisAlignment") {
      return checkValueTypeAndSetIt(
          "string", "mainAxisAlignment", MainAxisAlignment.start, isItAchild);
    } else if (value == "SpaceAround" && type == "mainAxisAlignment") {
      return checkValueTypeAndSetIt("string", "mainAxisAlignment",
          MainAxisAlignment.spaceAround, isItAchild);
    } else if (value == "SpaceBetween" && type == "mainAxisAlignment") {
      return checkValueTypeAndSetIt("string", "mainAxisAlignment",
          MainAxisAlignment.spaceBetween, isItAchild);
    } else if (value == "Center" && type == "crossAxisAlignment") {
      return checkValueTypeAndSetIt("string", "crossAxisAlignment",
          CrossAxisAlignment.center, isItAchild);
    } else if (value == "End" && type == "crossAxisAlignment") {
      return checkValueTypeAndSetIt(
          "string", "crossAxisAlignment", CrossAxisAlignment.end, isItAchild);
    } else if (value == "Stretch" && type == "crossAxisAlignment") {
      return checkValueTypeAndSetIt("string", "crossAxisAlignment",
          CrossAxisAlignment.stretch, isItAchild);
    } else if (value == "Start" && type == "crossAxisAlignment") {
      return checkValueTypeAndSetIt(
          "string", "crossAxisAlignment", CrossAxisAlignment.start, isItAchild);
    } else {
      return;
    }
  }

// to set any string value only string
  Widget stringfields(
    String widgetOrScreen,
    String changeName,
    String fieldName,
    IconData icon,
    bool isItAchild,
    Color? color,
    MoGCanvasItem screen,
    dynamic screenChangeName,
  ) {
    return TextFieldInAppBar(
      varValue: (e) {
        if (widgetOrScreen != "screen") {
          widget.widget!.varName = e;
          widget.widget!.valueFromVar = true;
          print(widget.widget!.type);
          widget.updateUI!();
        } else {
          screenEditor(changeName,
              context.watch<MoGCanvasItem>().screenVariables[e], screen);
          setState(() {});
        }
      },
      selectedScreen: screen,
      value: (e) {
        if (widgetOrScreen != "screen") {
          checkValueTypeAndSetIt("string", changeName, e, isItAchild);
        } else {
          screenEditor(changeName, e, screen);
        }
      },
      type: "string",
      defaultValue: widgetOrScreen != "screen"
          ? widget.widget!.widget[changeName]
          : screenChangeName,
      textFieldName: fieldName,
      iconFieldName: icon,
      color: color,
    );
  }

  // to set any num value only num
  Widget numfields(String widgetOrScreen, String changeName, String fieldName,
      IconData icon, bool isItAchild, Color? color, MoGCanvasItem screen) {
    return TextFieldInAppBar(
      varValue: (e) {
        print(e);
      },
      selectedScreen: screen,
      value: (e) {
        checkValueTypeAndSetIt("num", changeName, e, isItAchild);
      },
      type: "num",
      defaultValue: widget.widget!.widget[changeName].toString(),
      textFieldName: fieldName,
      iconFieldName: icon,
      color: color,
    );
  }

  // color picker
  Widget colorPciker(bool isItAchild, BuildContext context,
      Function(HSVColor color) color, Color pikcerColor, double height) {
    return ContainerForLessCode(
      setHight: false,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ButtonForLessCode(
          color: textFieldColor,
          child: TextForLessCode(
            color: Colors.white,
            value: "Select Color",
          ),
          onClick: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: barsColor,
                title: TextForLessCode(
                  value: "Select Color",
                  size: 20,
                ),
                content: SizedBox(
                  height: height,
                  width: 650,
                  child: ColorPicker(
                    onHsvColorChanged: (colore) {
                      color(colore);
                      widget.updateUI;
                    },
                    paletteType: PaletteType.hsvWithHue,
                    hexInputBar: true,
                    pickerColor: pikcerColor,
                    onColorChanged: changeColor,
                    colorHistory: colorHistory,
                    onHistoryChanged: (List<Color> colors) =>
                        colorHistory = colors,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // icon picker
  Widget iconPicker(bool isItAchild, BuildContext context) {
    return ContainerForLessCode(
      child: ButtonForLessCode(
        size: const Size(200, 35),
        color: textFieldColor,
        onClick: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    backgroundColor: barsColor,
                    title: TextForLessCode(
                      value: "Choose an icon",
                      size: 20,
                    ),
                    content: FlutterIconPicker(
                      randomIconColors: false,
                      color: textFieldColor,
                      onChanged: (icone) {
                        checkValueTypeAndSetIt("string", "icon",
                            icone["flutter_icon"], isItAchild);
                      },
                    ),
                  ));
        },
        child: TextForLessCode(
          color: Colors.white,
          value: "Click to Select icon",
          size: 15,
        ),
      ),
    );
  }

  Widget chackBox(String text, bool value, Function(bool) onChange) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextForLessCode(value: text),
          Checkbox(
              value: value,
              onChanged: (boole) {
                onChange(boole!);
              })
        ],
      ),
    );
  }

  Widget childrenShowerUi() {
    return Column(
      children: childrenShower(),
    );
  }

  List<Widget> childrenShower() {
    return widget.widget!.children
        .map((e) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: ContainerForLessCode(
                setHight: false,
                child: Row(
                  children: [
                    TextForLessCode(
                        value: e.type[0].toUpperCase() +
                            e.type.substring(1).toLowerCase()),
                    GestureDetector(
                      onTap: () {
                        widget.widget!.removeFromList(e);
                        widget.colosUi!();
                        widget.updateUI!();
                      },
                      child: const Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                        size: 20,
                      ),
                    )
                  ],
                ),
              ),
            ))
        .toList();
  }

  // check for the widget to see if it have child
  String childCheck() {
    if (widget.childType == "null") {
      return "Select  child from widgets menu to edit it";
    } else {
      return " child : ${widget.childType[0].toUpperCase()}${widget.childType.substring(1).toLowerCase()}";
    }
  }

  // set for th value
  void checkValueTypeAndSetIt(
      String valueType, String changeName, dynamic value, bool isItAchild) {
    if (valueType == "num" && isItAchild == false) {
      widget.widget!.widget[changeName] = double.parse(value);
      widget.updateUI!();
    } else if (valueType == "string" && isItAchild == false) {
      widget.widget!.widget[changeName] = value;
      widget.updateUI!();
    } else if (valueType == "num" && isItAchild == true) {
      widget.widget!.widget[changeName] = double.parse(value);
      widget.updateUI!();
    } else if (valueType == "string" && isItAchild == true) {
      widget.widget!.widget[changeName] = value;
      widget.updateUI!();
    }
  }

  void screenEditor(String changeName, dynamic value, MoGCanvasItem screen) {
    if (changeName == "labele") {
      widget.selectedScreen!.labele = value;
      widget.updateUI!();
    }
  }
}
