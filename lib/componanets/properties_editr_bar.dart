// ignore_for_file: must_be_immutable, avoid_types_as_parameter_names

import 'package:builder/colors.dart';
import 'package:builder/componanets/button.dart';
import 'package:builder/componanets/check_box.dart';
import 'package:builder/componanets/container.dart';
import 'package:builder/componanets/device_frame.dart';
import 'package:builder/componanets/text.dart';
import 'package:builder/componanets/var_maker.dart';
import 'package:builder/systems/canvas_controller.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:builder/componanets/text_field.dart';
import 'package:builder/systems/screen.dart';
import 'package:modern_icon_picker/flutter_icon_picker.dart';
import 'package:builder/systems/widget.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:resizable_widget/resizable_widget.dart';

import 'package:select_form_field/select_form_field.dart';

class PropertesBar extends StatefulWidget {
  PropertesBar(
      {Key? key,
      this.widgetType = "null",
      this.childType = "null",
      this.widget,
      this.isItScreenchild = false,
      required this.selectedScreen,
      required this.changeStartScreen,
      required this.perintWidget,
      required this.restperintWidget,
      this.setwidget,
      this.deleteWidget,
      this.colosUi,
      this.deleteScreen,
      this.isItScreen = false,
      this.updateUI,
      this.openCodePanle})
      : super(key: key);
  String widgetType;
  String childType;
  bool isItScreen;
  WidgetMoG? widget;
  bool isItScreenchild;

  Function(WidgetMoG child)? setwidget;
  Function(WidgetMoG id)? deleteWidget;
  Function(MoGCanvasItem id)? deleteScreen;
  Function()? colosUi;
  Function()? updateUI;
  Function()? openCodePanle;
  Function() restperintWidget;
  Function(MoGCanvasItem)? changeStartScreen;
  MoGCanvasItem? selectedScreen;
  WidgetMoG perintWidget;

  @override
  State<PropertesBar> createState() => _PropertesBarState();
}

class _PropertesBarState extends State<PropertesBar> {
  List<String> devicesList = [
    "laptop",
    "wideMonitor",
    "iPad",
    "iPhone13",
    "samsungGalaxyS20",
    "largeTablet",
    "macBookPro"
  ];
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
    Color scendryColor = context.watch<ScreenInfo>().scendryColor;
    Color backGroundColor = context.watch<ScreenInfo>().backGroundColor;
    Color firstColor = context.watch<ScreenInfo>().firstColor;

    return SizedBox(
      height: bar2Size.height,
      width: width,
      child: ResizableWidget(
        isHorizontalSeparator: false,
        isDisabledSmartHide: false,
        separatorColor: scendryColor,
        separatorSize: barSpriterSize,
        percentages: const [0.1, 0.9],
        children: [
          const SizedBox(),
          Container(
            padding: const EdgeInsets.all(5),
            color: firstColor,
            child: SingleChildScrollView(
                child: Wrap(children: [
              ContainerForLessCode(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 130,
                        height: 200,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: EditableText(
                            onChanged: (e) {
                              if (widget.isItScreen) {
                                if (e.isEmpty) {
                                  widget.selectedScreen!.labele = "Widget Name";
                                } else {
                                  widget.selectedScreen!.labele = e;
                                  widget.updateUI!();
                                }
                              } else {
                                widget.widget!.widgetName = e;
                                widget.updateUI!();
                              }
                            },
                            backgroundCursorColor: scendryColor,
                            controller: TextEditingController(
                                text: widget.isItScreen
                                    ? widget.selectedScreen!.labele[0]
                                            .toUpperCase() +
                                        widget.selectedScreen!.labele
                                            .substring(1)
                                            .toLowerCase()
                                    : widget.widget!.widgetName[0]
                                            .toUpperCase() +
                                        widget.widget!.widgetName
                                            .substring(1)
                                            .toLowerCase()),
                            cursorColor: scendryColor,
                            focusNode: FocusNode(),
                            style: const TextStyle(
                                fontFamily: "Tajawal",
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 70,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: TextForLessCode(
                                  color: scendryColor,
                                  fontWeight: FontWeight.w600,
                                  size: 10,
                                  value: widget.widgetType[0].toUpperCase() +
                                      widget.widgetType
                                          .substring(1)
                                          .toLowerCase()),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (widget.widgetType == "screen") {
                                  widget.deleteScreen!(widget.selectedScreen!);
                                } else {
                                  if (widget.isItScreenchild == false) {
                                    if (widget.perintWidget.child != null) {
                                      widget.perintWidget.child = null;
                                      widget.restperintWidget();
                                    } else {
                                      widget.perintWidget.children
                                          .remove(widget.widget);
                                      widget.restperintWidget();
                                    }
                                  } else {
                                    widget.selectedScreen!.items
                                        .remove(widget.widget);
                                  }
                                }

                                widget.updateUI!();
                                widget.colosUi!();
                              },
                              child: const Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                                size: 20,
                              ),
                            ),
                          ],
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
    String typ,
    Color color,
    MoGCanvasItem screen,
    double height,
  ) {
    Color scendryColor = context.watch<ScreenInfo>().scendryColor;
    Color backGroundColor = context.watch<ScreenInfo>().backGroundColor;

    if (typ == "screen") {
      return [
        appBar(screen),
        flotingButton(screen),
        drawer(screen),
        ButtonForOutline(
          buttonColor: scendryColor,
          text: "Make Start Screen",
          textcolor: Colors.white,
          onClick: () {
            widget.changeStartScreen!(screen);
          },
        ),
        ButtonForOutline(
          buttonColor: scendryColor,
          text: "Screen Size",
          textcolor: Colors.white,
          onClick: () {
            showDialog(
                context: context,
                builder: (c) {
                  return Dialog(
                    backgroundColor: backGroundColor.withOpacity(0),
                    child: DeviceFrameSelecter(info: (e) {
                      screen.deviceName = e;
                      widget.selectedScreen!.sizee = e.screenSize;
                      widget.selectedScreen!.sizeProfilee = e.name;
                      Provider.of<ScreenInfo>(context, listen: true)
                          .setDevaceName(e);
                      widget.updateUI!();
                    }),
                  );
                });
          },
        ),
        colorPciker(context, (color) {
          screen.backGroundColor = color;
          widget.updateUI!();
        }, screen.backGroundColor, height),
        ButtonForOutline(
          buttonColor: scendryColor,
          text: "Create Var",
          textcolor: Colors.white,
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
        screenVars(),
      ];
    } else if (typ == "text") {
      return [
        stringfield(60, true, "widget", "textValue", "Value", Icons.text_format,
            color, screen, "null", 230),
        colorPciker(context, (color) {
          checkValueTypeAndSetIt(
            "string",
            "color",
            color,
          );
        }, widget.widget!.widget["color"], height),
        numfield(60, 230, true, "widget", "size", "Size",
            Icons.format_size_outlined, color, screen),
        dropDown(
            widget.widget!.widget["fontWeight"],
            [
              {"value": FontWeight.normal, "label": "Normal"},
              {"value": FontWeight.bold, "label": "Bold"},
              {"value": FontWeight.w100, "label": "W100"},
              {"value": FontWeight.w200, "label": "W200"},
              {"value": FontWeight.w300, "label": "W300"},
              {"value": FontWeight.w400, "label": "W400"},
              {"value": FontWeight.w500, "label": "W500"},
              {"value": FontWeight.w600, "label": "W600"},
              {"value": FontWeight.w700, "label": "W700"},
              {"value": FontWeight.w800, "label": "W800"},
              {"value": FontWeight.w900, "label": "W900"},
            ],
            "fontWeight",
            19,
            backGroundColor),
        numfield(60, 230, true, "widget", "letterSpacing", "Letter Spacing",
            Icons.format_size_outlined, color, screen),
      ];
    } else if (typ == "container") {
      return [
        colorPciker(context, (color) {
          checkValueTypeAndSetIt(
            "string",
            "color",
            color,
          );
        }, widget.widget!.widget["color"], height),
        numfield(60, 230, true, "widget", "height", "Height",
            Icons.height_outlined, color, screen),
        numfield(60, 230, true, "widget", "width", "Width",
            Icons.width_normal_outlined, color, screen),
        borderRadius(color, screen),
        ContainerForLessCode(
          setHight: false,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextForLessCode(value: "Margin"),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      numfield(47, 100, false, "widget", "marginLeft", "Left",
                          Icons.width_normal_outlined, color, screen),
                      numfield(48, 100, false, "widget", "marginRight", "Right",
                          Icons.width_normal_outlined, color, screen),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      numfield(47, 100, false, "widget", "marginTop", "Top",
                          Icons.width_normal_outlined, color, screen),
                      numfield(48, 100, false, "widget", "marginBottom",
                          "Bottom", Icons.width_normal_outlined, color, screen),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              )
            ],
          ),
        ),
        ContainerForLessCode(
          setHight: false,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextForLessCode(value: "Padding"),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      numfield(47, 100, false, "widget", "paddingLeft", "Left",
                          Icons.width_normal_outlined, color, screen),
                      numfield(48, 100, false, "widget", "paddingRight",
                          "Right", Icons.width_normal_outlined, color, screen),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      numfield(47, 100, false, "widget", "paddingTop", "Top",
                          Icons.width_normal_outlined, color, screen),
                      numfield(48, 100, false, "widget", "paddingBottom",
                          "Bottom", Icons.width_normal_outlined, color, screen),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              )
            ],
          ),
        ),
        childShower()
      ];
    } else if (typ == "row") {
      return [
        numfield(60, 230, true, "widget", "height", "Height",
            Icons.height_outlined, color, screen),
        numfield(60, 230, true, "widget", "width", "Width",
            Icons.width_normal_outlined, color, screen),
        dropDown(
            widget.widget!.widget["mainAxisAlignment"],
            [
              {
                "value": "Center",
              },
              {"value": "End"},
              {"value": "Start"},
              {"value": "SpaceAround"},
              {"value": "SpaceBetween"}
            ],
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
            "crossAxisAlignment",
            19,
            backGroundColor),
        childrenShowerUi(),
      ];
    } else if (typ == "column") {
      return [
        numfield(60, 230, true, "widget", "height", "Height",
            Icons.height_outlined, color, screen),
        numfield(60, 230, true, "widget", "width", "Width",
            Icons.width_normal_outlined, color, screen),
        dropDown(
            widget.widget!.widget["mainAxisAlignment"],
            [
              {"value": "Center"},
              {"value": "End"},
              {"value": "Start"},
              {"value": "SpaceAround"},
              {"value": "SpaceBetween"}
            ],
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
            "crossAxisAlignment",
            19,
            backGroundColor),
        childrenShowerUi(),
      ];
    } else if (typ == "image") {
      return [
        numfield(60, 230, true, "widget", "height", "Height",
            Icons.height_outlined, color, screen),
        numfield(60, 230, true, "widget", "width", "Width",
            Icons.width_normal_outlined, color, screen),
        stringfield(60, true, "widget", "imageUrl", "Url", Icons.http, color,
            screen, "null", 230),
        borderRadius(color, screen),
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
            "boxFit",
            7,
            backGroundColor)
      ];
    } else if (typ == "icon") {
      return [
        numfield(60, 230, true, "widget", "height", "Height",
            Icons.height_outlined, color, screen),
        numfield(60, 230, true, "widget", "width", "Width",
            Icons.width_normal_outlined, color, screen),
        iconPicker(context),
        colorPciker(context, (color) {
          checkValueTypeAndSetIt(
            "string",
            "color",
            color,
          );
        }, widget.widget!.widget["color"], height),
        numfield(60, 230, true, "widget", "size", "Size", Icons.height_sharp,
            color, screen),
      ];
    } else if (typ == "stack") {
      return [
        numfield(60, 230, true, "widget", "height", "Height",
            Icons.height_outlined, color, screen),
        numfield(60, 230, true, "widget", "width", "Width",
            Icons.width_normal_outlined, color, screen),
        childrenShowerUi(),
      ];
    } else if (typ == "button") {
      return [
        colorPciker(context, (color) {
          checkValueTypeAndSetIt(
            "string",
            "color",
            color,
          );
        }, widget.widget!.widget["color"], height),
        numfield(60, 230, true, "widget", "height", "Height",
            Icons.height_outlined, color, screen),
        numfield(60, 230, true, "widget", "width", "Width",
            Icons.width_normal_outlined, color, screen),
        ContainerForLessCode(
          setHight: false,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: ButtonForOutline(
              buttonColor: scendryColor,
              text: "OnClick",
              textcolor: Colors.white,
              onClick: () {
                widget.openCodePanle!();
              },
            ),
          ),
        ),
        childShower()
      ];
    } else if (typ == "padding") {
      return [
        ContainerForLessCode(
          setHight: false,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextForLessCode(value: "Padding"),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      numfield(47, 100, false, "widget", "paddingLeft", "Left",
                          Icons.width_normal_outlined, color, screen),
                      numfield(48, 100, false, "widget", "paddingRight",
                          "Right", Icons.width_normal_outlined, color, screen),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      numfield(47, 100, false, "widget", "paddingTop", "Top",
                          Icons.width_normal_outlined, color, screen),
                      numfield(48, 100, false, "widget", "paddingBottom",
                          "Bottom", Icons.width_normal_outlined, color, screen),
                    ],
                  ),
                ],
              ),
              childShower(),
              const SizedBox(
                height: 5,
              )
            ],
          ),
        ),
      ];
    } else if (typ == "divider") {
      return [
        colorPciker(context, (color) {
          checkValueTypeAndSetIt(
            "string",
            "color",
            color,
          );
        }, widget.widget!.widget["color"], height),
        numfield(60, 230, true, "widget", "height", "Height",
            Icons.height_outlined, color, screen),
        numfield(60, 230, true, "widget", "width", "Thickness",
            Icons.width_normal_outlined, color, screen),
      ];
    } else if (typ == "safeArea") {
      return [
        numfield(60, 230, true, "widget", "height", "Height",
            Icons.height_outlined, color, screen),
        numfield(60, 230, true, "widget", "width", "Width",
            Icons.width_normal_outlined, color, screen),
        CheckBoxForLessCode(
            text: "Top",
            setValue: (e) {
              widgete!.widget["SafeAreatop"] = e;
              widget.updateUI!();
            },
            value: widgete!.widget["SafeAreatop"]),
        CheckBoxForLessCode(
            text: "Bottom",
            setValue: (e) {
              widgete.widget["SafeAreabottom"] = e;
              widget.updateUI!();
            },
            value: widgete.widget["SafeAreabottom"]),
        CheckBoxForLessCode(
            text: "Left",
            setValue: (e) {
              widgete.widget["SafeArealeft"] = e;
              widget.updateUI!();
            },
            value: widgete.widget["SafeArealeft"]),
        CheckBoxForLessCode(
            text: "Right",
            setValue: (e) {
              widgete.widget["SafeArearight"] = e;
              widget.updateUI!();
            },
            value: widgete.widget["SafeArearight"]),
        childShower(),
      ];
    } else if (typ == "sizedBox") {
      return [
        numfield(60, 230, true, "widget", "height", "Height",
            Icons.height_outlined, color, screen),
        numfield(60, 230, true, "widget", "width", "Width",
            Icons.width_normal_outlined, color, screen),
        childShower(),
      ];
    } else if (typ == "checkbox") {
      return [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextFieldInWithVar(
                width: 50,
                haveTextFiled: false,
                selectedScreen: screen,
                canSetFromVar: true,
                value: (e) {},
                textFieldName: "Var",
                varValue: (e) {
                  widgete!.widget["checkboxValue"] = e;
                }),
            CheckBoxForLessCode(
                text: "Value",
                setValue: (e) {
                  widgete!.widget["checkboxValue"] = e;
                  widget.updateUI!();
                },
                value: widgete!.widget["checkboxValue"]),
          ],
        )
      ];
    } else {
      return [];
    }
  }

  Widget screenVars() {
    Color scendryColor = context.watch<ScreenInfo>().scendryColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextForLessCode(
            value: "Screen Vars List",
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        ContainerForLessCode(
          setHight: false,
          child: Column(
              children: widget.selectedScreen!.screenVariables
                  .map((e) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ContainerForLessCode(
                          setHight: false,
                          color: scendryColor,
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
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
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

  Widget borderRadius(Color color, MoGCanvasItem screen) {
    return ContainerForLessCode(
      setHight: false,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextForLessCode(value: "Border Radius"),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                numfield(47, 100, false, "widget", "borderRadiustopLeft",
                    "Top Left", Icons.width_normal_outlined, color, screen),
                numfield(48, 100, false, "widget", "borderRadiustopRight",
                    "Top Right", Icons.width_normal_outlined, color, screen),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                numfield(47, 100, false, "widget", "borderRadiusbottomLeft",
                    "Buttom Left", Icons.width_normal_outlined, color, screen),
                numfield(48, 100, false, "widget", "borderRadiusbottomRight",
                    "Buttom Right", Icons.width_normal_outlined, color, screen),
              ],
            ),
            const SizedBox(
              height: 5,
            )
          ],
        ),
      ),
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

  Widget dropDown(dynamic value, List<Map<String, dynamic>> itmes, String type,
      int skipNubmer, color) {
    Color scendryColor = context.watch<ScreenInfo>().scendryColor;
    Color backGroundColor = context.watch<ScreenInfo>().backGroundColor;

    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: SizedBox(
          height: 45,
          width: 210,
          child: SelectFormField(
            style: const TextStyle(fontSize: 13, color: Colors.white),
            decoration: InputDecoration(
              fillColor: backGroundColor,
              filled: true,
              labelStyle: TextStyle(
                color: scendryColor,
                fontFamily: "Tajawal",
              ),
              labelText: type,
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
            initialValue: value.toString(),

            items: itmes,
            onChanged: (val) {
              dropFun(val, type, widget.widget!);
            },
            onSaved: (val) {
              dropFun(val!, type, widget.widget!);
            },
          )),
    );
  }

  void dropFun(dynamic value, String type, WidgetMoG widgete) {
    if (value == "Contain" && type == "boxFit") {
      return checkValueTypeAndSetIt(
        "string",
        "imageBoxFit",
        BoxFit.contain,
      );
    } else if (value == "Cover" && type == "boxFit") {
      return checkValueTypeAndSetIt(
        "string",
        "imageBoxFit",
        BoxFit.cover,
      );
    } else if (value == "Fill" && type == "boxFit") {
      return checkValueTypeAndSetIt(
        "string",
        "imageBoxFit",
        BoxFit.fill,
      );
    } else if (value == "FitWidth" && type == "boxFit") {
      return checkValueTypeAndSetIt(
        "string",
        "imageBoxFit",
        BoxFit.fitWidth,
      );
    } else if (value == "FitHeight" && type == "boxFit") {
      return checkValueTypeAndSetIt(
        "string",
        "imageBoxFit",
        BoxFit.fitHeight,
      );
    } else if (value == "ScaleDown" && type == "boxFit") {
      return checkValueTypeAndSetIt(
        "string",
        "imageBoxFit",
        BoxFit.scaleDown,
      );
    } else if (value == "Center" && type == "mainAxisAlignment") {
      return checkValueTypeAndSetIt(
        "string",
        "mainAxisAlignment",
        MainAxisAlignment.center,
      );
    } else if (value == "End" && type == "mainAxisAlignment") {
      return checkValueTypeAndSetIt(
        "string",
        "mainAxisAlignment",
        MainAxisAlignment.end,
      );
    } else if (value == "Start" && type == "mainAxisAlignment") {
      return checkValueTypeAndSetIt(
        "string",
        "mainAxisAlignment",
        MainAxisAlignment.start,
      );
    } else if (value == "SpaceAround" && type == "mainAxisAlignment") {
      return checkValueTypeAndSetIt(
        "string",
        "mainAxisAlignment",
        MainAxisAlignment.spaceAround,
      );
    } else if (value == "SpaceBetween" && type == "mainAxisAlignment") {
      return checkValueTypeAndSetIt(
        "string",
        "mainAxisAlignment",
        MainAxisAlignment.spaceBetween,
      );
    } else if (value == "Center" && type == "crossAxisAlignment") {
      return checkValueTypeAndSetIt(
        "string",
        "crossAxisAlignment",
        CrossAxisAlignment.center,
      );
    } else if (value == "End" && type == "crossAxisAlignment") {
      return checkValueTypeAndSetIt(
        "string",
        "crossAxisAlignment",
        CrossAxisAlignment.end,
      );
    } else if (value == "Stretch" && type == "crossAxisAlignment") {
      return checkValueTypeAndSetIt(
        "string",
        "crossAxisAlignment",
        CrossAxisAlignment.stretch,
      );
    } else if (value == "Start" && type == "crossAxisAlignment") {
      return checkValueTypeAndSetIt(
        "string",
        "crossAxisAlignment",
        CrossAxisAlignment.start,
      );
    } else if (value == "FontWeight.normal" && type == "fontWeight") {
      widgete.widget["fontWeight"] = FontWeight.normal;
      widget.updateUI!();
    } else if (value == "FontWeight.bold" && type == "fontWeight") {
      widgete.widget["fontWeight"] = FontWeight.bold;
      widget.updateUI!();
    } else if (value == "FontWeight.w100" && type == "fontWeight") {
      widgete.widget["fontWeight"] = FontWeight.w100;
      widget.updateUI!();
    } else if (value == "FontWeight.w200" && type == "fontWeight") {
      widgete.widget["fontWeight"] = FontWeight.w200;
      widget.updateUI!();
    } else if (value == "FontWeight.w300" && type == "fontWeight") {
      widgete.widget["fontWeight"] = FontWeight.w300;
      widget.updateUI!();
    } else if (value == "FontWeight.w400" && type == "fontWeight") {
      widgete.widget["fontWeight"] = FontWeight.w400;
      widget.updateUI!();
    } else if (value == "FontWeight.w500" && type == "fontWeight") {
      widgete.widget["fontWeight"] = FontWeight.w500;
      widget.updateUI!();
    } else if (value == "FontWeight.w600" && type == "fontWeight") {
      widgete.widget["fontWeight"] = FontWeight.w600;
      widget.updateUI!();
    } else if (value == "FontWeight.w700" && type == "fontWeight") {
      widgete.widget["fontWeight"] = FontWeight.w700;
      widget.updateUI!();
    } else if (value == "FontWeight.w800" && type == "fontWeight") {
      widgete.widget["fontWeight"] = FontWeight.w800;
      widget.updateUI!();
    } else if (value == "FontWeight.w900" && type == "fontWeight") {
      widgete.widget["fontWeight"] = FontWeight.w900;
      widget.updateUI!();
    }
  }

// to set any string value only string
  Widget stringfield(
    double hight,
    bool haveVar,
    String widgetOrScreen,
    String changeName,
    String fieldName,
    IconData icon,
    Color? color,
    MoGCanvasItem screen,
    dynamic screenChangeName,
    double width,
  ) {
    return TextFieldInWithVar(
      hight: hight,
      width: width,
      canSetFromVar: haveVar,
      varValue: (e) {
        if (widgetOrScreen != "screen") {
          widget.widget!.widget[changeName] = e;
          widget.widget!.valueFromVar = true;

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
          checkValueTypeAndSetIt("string", changeName, e);
        } else {
          screenEditor(changeName, e, screen);
        }
      },
      type: "string",
      defaultValue: widgetOrScreen != "screen"
          ? widget.widget!.widget[changeName]
          : screenChangeName,
      textFieldName: fieldName,
      color: color,
    );
  }

  // to set any num value only num
  Widget numfield(
      double hight,
      double width,
      bool haveVar,
      String widgetOrScreen,
      String changeName,
      String fieldName,
      IconData icon,
      Color? color,
      MoGCanvasItem screen) {
    return TextFieldInWithVar(
      width: width,
      hight: hight,
      canSetFromVar: haveVar,
      varValue: (e) {
        if (widgetOrScreen != "screen") {
          widget.widget!.varName = e;
          widget.widget!.valueFromVar = true;

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
          checkValueTypeAndSetIt("num", changeName, e);
        } else {
          screenEditor(changeName, e, screen);
        }
      },
      type: "num",
      defaultValue: widget.widget!.widget[changeName].toString(),
      textFieldName: fieldName,
      color: color,
    );
  }

  // color picker
  Widget colorPciker(BuildContext context, Function(Color color) colore,
      Color pikcerColor, double height) {
    Color firstColor = context.watch<ScreenInfo>().firstColor;
    Color scendryColor = context.watch<ScreenInfo>().scendryColor;
    return ButtonForOutline(
      buttonColor: scendryColor,
      onClick: () {
        showDialog(
            context: context,
            builder: (e) {
              return Dialog(
                backgroundColor: firstColor,
                child: SizedBox(
                  width: 240,
                  height: 360,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ColorPicker(
                            pickerAreaHeightPercent: 0.7,
                            enableAlpha: true,
                            displayThumbColor: true,
                            paletteType: PaletteType.hsvWithHue,
                            pickerAreaBorderRadius: BorderRadius.circular(5),
                            portraitOnly: true,
                            colorPickerWidth: 200,
                            hexInputBar: true,
                            pickerColor: pikcerColor,
                            onColorChanged: (color) {
                              colore(color);
                            }),
                      ],
                    ),
                  ),
                ),
              );
            });
      },
      text: "Color",
      textcolor: Colors.white,
    );
  }

  // icon picker
  Widget iconPicker(BuildContext context) {
    Color scendryColor = context.watch<ScreenInfo>().scendryColor;
    Color backGroundColor = context.watch<ScreenInfo>().backGroundColor;
    return ButtonForOutline(
      buttonColor: scendryColor,
      onClick: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: backGroundColor,
            title: TextForLessCode(
              value: "Pick Icon",
              color: scendryColor,
            ),
            content: FlutterIconPicker(
              iconsPerRow: 7,
              color: Colors.white,
              randomIconColors: false,
              onChanged: (value) {
                widget.widget!.widget["icon"] = value["flutter_icon"];
                widget.updateUI!();
              },
            ),
          ),
        );
      },
      text: "Select Icon",
      textcolor: Colors.white,
    );
  }

  Widget chackBox(String text, bool value, Function(bool) onChange) {
    Color scendryColor = context.watch<ScreenInfo>().scendryColor;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextForLessCode(
            fontWeight: FontWeight.w500,
            value: text,
            color: Colors.white,
          ),
          Checkbox(
              activeColor: scendryColor,
              checkColor: Colors.white,
              value: value,
              onChanged: (boole) {
                onChange(boole!);
              })
        ],
      ),
    );
  }

  Widget childrenShowerUi() {
    return ContainerForLessCode(
      setHight: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextForLessCode(
            value: "Children",
            size: 15,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
          Column(
            children: childrenShower(),
          ),
        ],
      ),
    );
  }

  Widget childShower() {
    if (widget.widget!.child != null) {
      return ContainerForLessCode(
        setHight: false,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              TextForLessCode(value: "Child"),
              GestureDetector(
                onTap: () {
                  widget.setwidget!(widget.widget!.child!);
                },
                child: ContainerForLessCode(
                  setHight: false,
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextForLessCode(
                              value:
                                  widget.widget!.child!.type[0].toUpperCase() +
                                      widget.widget!.child!.type
                                          .substring(1)
                                          .toLowerCase()),
                          GestureDetector(
                            onTap: () {
                              widget.widget!.child = null;
                              widget.colosUi!();
                              widget.updateUI!();
                            },
                            child: const Icon(
                              Icons.delete_outline,
                              color: Colors.red,
                              size: 20,
                            ),
                          ),
                        ]),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  List<Widget> childrenShower() {
    return widget.widget!.children
        .map((e) => Padding(
              padding: const EdgeInsets.all(3.0),
              child: GestureDetector(
                onTap: () {
                  widget.setwidget!(e);
                },
                child: ContainerForLessCode(
                  setHight: false,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextForLessCode(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            value: e.type[0].toUpperCase() +
                                e.type.substring(1).toLowerCase()),
                        SizedBox(
                          width: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (widget.widget!.children.indexOf(e) > 0) {
                                    WidgetMoG upwidget = widget
                                            .widget!.children[
                                        widget.widget!.children.indexOf(e) - 1];
                                    WidgetMoG wdig = e;
                                    widget.widget!.children[
                                        widget.widget!.children.indexOf(e) -
                                            1] = e;
                                    widget.widget!.children.remove(e);
                                    widget.widget!.children.insert(
                                        widget.widget!.children.indexOf(e) + 1,
                                        upwidget);
                                    widget.colosUi!();
                                    widget.updateUI!();
                                  }
                                },
                                child: const Icon(
                                  Icons.keyboard_arrow_up_outlined,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  WidgetMoG downWidget = widget
                                          .widget!.children[
                                      widget.widget!.children.indexOf(e) + 1];
                                  WidgetMoG wdig = e;
                                  widget.widget!.children[
                                      widget.widget!.children.indexOf(e) +
                                          1] = e;
                                  widget.widget!.children.remove(e);
                                  widget.widget!.children.insert(
                                      widget.widget!.children.indexOf(e),
                                      downWidget);
                                  widget.colosUi!();
                                  widget.updateUI!();
                                },
                                child: const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
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
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ))
        .toList();
  }

  // set for th value
  void checkValueTypeAndSetIt(
      String valueType, String changeName, dynamic value) {
    if (valueType == "num") {
      widget.widget!.widget[changeName] = double.parse(value);
      Provider.of<ScreenInfo>(context, listen: true).setrestOverWidget(true);
      widget.updateUI!();
    } else if (valueType == "string") {
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
