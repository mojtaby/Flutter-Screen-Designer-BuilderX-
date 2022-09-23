import 'package:builder/componanets/text.dart';
import 'package:builder/systems/canvas_controller.dart';
import 'package:builder/systems/context_menu.dart';
import 'package:builder/systems/screen.dart';
import 'package:device_frame/device_frame.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class WidgetMoG {
  WidgetMoG({
    this.fromData = false,
    required this.keye,
    required this.type,
    required this.canHaveChild,
    required this.onChildrenClicked,
    this.child,
    required this.childClick,
    this.actions = const [{}],
    required this.controllerNav,
    this.varName,
    this.valueFromVar = false,
    this.checkBoxClicked,
    this.onClickForCoder,
    this.left = 0,
    this.top = 0,
    this.widgetName = "WidgetName",
  });
  bool fromData;
  String widgetName;
  CanvasController? controllerNav;
  final String keye;
  final bool canHaveChild;
  final String type;
  Function(WidgetMoG)? onChildrenClicked;
  Function(WidgetMoG)? childClick;
  List<WidgetMoG> children = [];
  WidgetMoG? child;
  var onCllick = [{}];
  var actions = [];

  Function()? onClickForCoder;
  List<String> onClickCoder = [];
  void Function()? checkBoxClicked;
  List<WidgetMoG> get chidrn => children;
  bool valueFromVar = false;
  dynamic varName;
  double top;
  double left;
  Map get asMap => {
        'String': type,
        'key': keye,
        'left': left,
        'top': top,
        'child': child,
        'children': children.map((e) => e.asMap),
        'canHaveChild': canHaveChild,
        'widgetName': widgetName,
        "widget": widget,
      };
  Map<String, dynamic> widget = {
    "name": "widget",
    // text properties
    "letterSpacing": 0,
    "textValue": "Text",
    "font": "Tajawal",
    "fontWeight": FontWeight.normal,
    "textAlign": TextAlign.start,
    // SafeArea
    "SafeArealeft": false,
    "SafeAreatop": true,
    "SafeAreabottom": false,
    "SafeArearight": false,

    // any widget have this values
    "size": 20,
    "color": Color(0xFF113861),
    "height": 100,
    "width": 100,
    "havePadding": false,
    "haveMargin": false,
    "haveBorderRadius": false,
    "paddingLeft": 0,
    "paddingRight": 0,
    "paddingTop": 0,
    "paddingBottom": 0,
    "borderRadiusbottomRight": 0,
    "borderRadiustopLeft": 0,
    "borderRadiustopRight": 0,
    "borderRadiusbottomLeft": 0,
    "marginRight": 0,
    "marginLeft": 0,
    "marginTop": 0,
    "marginBottom": 0,
    "child": null,
    "imageUrl":
        "https://i.postimg.cc/bry3DVCm/efd89fda9fd543e792c1bae77ae100d5.png",
    "onPressed": null,
    "icon": Icons.add,

    "imageBoxFit": BoxFit.cover,
    "crossAxisAlignment": CrossAxisAlignment.start,
    "mainAxisAlignment": MainAxisAlignment.start,
    "checkboxValue": false,
  };

  Map<String, dynamic> get properties => widget;

  setproperties(Map<String, dynamic> prop) {
    widget = prop;
  }

  Map<String, List<dynamic>> codeBlocks = {
    "nodes": [
      {"id": 1, "label": 'On click'},
      {"id": 2, "label": 'Function{'},
    ],
    "edges": [
      {"from": 1, "to": 2},
    ]
  };

  Widget build(BuildContext context) {
    bool playMode = context.watch<ScreenInfo>().unableOnClick;

    if (fromData) {
      return WidgetMoG(
              keye: asMap["keye"],
              type: asMap["type"],
              canHaveChild: asMap["canHaveChild"],
              onChildrenClicked: asMap["onChildrenClicked"],
              childClick: asMap["childClick"],
              controllerNav: controllerNav)
          .build(context);
    } else {
      if (type == "text") {
        return text();
      } else if (type == "container") {
        return container(context, playMode);
      } else if (type == "image") {
        return image();
      } else if (type == "button") {
        return button(context, playMode);
      } else if (type == "icon") {
        return icon();
      } else if (type == "row") {
        return row(context, playMode, (e) {});
      } else if (type == "column") {
        return column(context, playMode);
      } else if (type == "stack") {
        return stack(context, playMode);
      } else if (type == "center") {
        return center(context, playMode);
      } else if (type == "padding") {
        return padding(context, playMode);
      } else if (type == "checkbox") {
        return checkbox(playMode);
      } else if (type == "divider") {
        return divider();
      } else if (type == "safeArea") {
        return safeArea(context);
      } else if (type == "sizedBox") {
        return sizedBox(context);
      } else {
        return const SizedBox();
      }
    }
  }

  Widget container(BuildContext context, bool playMode) {
    return Container(
      margin: EdgeInsets.only(
          left: widget["marginLeft"],
          right: widget["marginRight"],
          top: widget["marginTop"],
          bottom: widget["marginBottom"]),
      padding: EdgeInsets.only(
          left: widget["paddingLeft"],
          right: widget["paddingRight"],
          top: widget["paddingTop"],
          bottom: widget["paddingBottom"]),
      height: widget["height"],
      width: widget["width"],
      decoration: BoxDecoration(
          color: widget["color"],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(widget["borderRadiustopLeft"]),
              topRight: Radius.circular(widget["borderRadiustopRight"]),
              bottomLeft: Radius.circular(widget["borderRadiusbottomLeft"]),
              bottomRight: Radius.circular(widget["borderRadiusbottomRight"]))),
      child: child == null
          ? null
          : Tooltip(
              message: child != null ? child!.type : "",
              child: child!.build(context)),
    );
  }

  addOnClick(String type, dynamic value) {
    onCllick.add({"type": type, "value": value});
  }

  Widget button(BuildContext context, bool playMode) {
    return SizedBox(
      height: widget["height"],
      width: widget["width"],
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: widget["color"]),
        onPressed: playMode
            ? () {
                onCllick.forEach((element) {
                  if (element['type'] == "nav") {
                    Provider.of<ScreenInfo>(context, listen: true)
                        .changeScreen(element['value']);
                  } else if (element['type'] == "print") {
                    Provider.of<ScreenInfo>(context, listen: true)
                        .consolee(element['value']);
                  }
                });
              }
            : null,
        child: Tooltip(
          message: child != null ? child!.type : "",
          child: GestureDetector(
            onTap: child == null
                ? null
                : () {
                    childClick!(child!);
                  },
            child: child == null
                ? TextForLessCode(value: "Button")
                : child!.build(context),
          ),
        ),
      ),
    );
  }

  Widget text() {
    return SizedBox(
      height: widget["height"],
      width: widget["width"],
      child: Text(
        widget["textValue"],
        textAlign: widget["textAlign"],
        style: TextStyle(
            letterSpacing: widget["letterSpacing"],
            color: widget["color"],
            fontSize: widget["size"],
            fontWeight: widget["fontWeight"]),
      ),
    );
  }

  Widget image() {
    return ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(widget["borderRadiustopLeft"]),
            topRight: Radius.circular(widget["borderRadiustopRight"]),
            bottomLeft: Radius.circular(widget["borderRadiusbottomLeft"]),
            bottomRight: Radius.circular(widget["borderRadiusbottomRight"])),
        child: Image.network(
          widget["imageUrl"],
          fit: widget["imageBoxFit"],
          height: widget["height"],
          width: widget["width"],
        ));
  }

  Widget icon() {
    return SizedBox(
      height: widget["height"],
      width: widget["width"],
      child: Icon(
        widget["icon"],
        color: widget["color"],
        size: widget["size"],
      ),
    );
  }

  Widget row(BuildContext context, bool playMode, Function(WidgetMoG) paset) {
    // check if the play mode is of than set some efexts on widget

    if (playMode == false) {
      return Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
        height: widget["height"],
        width: widget["width"],
        child: Row(
            crossAxisAlignment: widget["crossAxisAlignment"],
            mainAxisAlignment: widget["mainAxisAlignment"],
            children: children
                .map((eg) => Tooltip(
                      message: eg.type,
                      child: GestureDetector(
                          onTap: () {
                            onChildrenClicked!(eg);
                          },
                          child: eg.build(context)),
                    ))
                .toList()),
      );
    } else {
      return SizedBox(
        height: widget["height"],
        width: widget["width"],
        child: Row(
            crossAxisAlignment: widget["crossAxisAlignment"],
            mainAxisAlignment: widget["mainAxisAlignment"],
            children: children.map((eg) => eg.build(context)).toList()),
      );
    }
  }

  Widget column(context, bool playMode) {
    if (playMode == false) {
      return Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
        height: widget["height"],
        width: widget["width"],
        child: Column(
            crossAxisAlignment: widget["crossAxisAlignment"],
            mainAxisAlignment: widget["mainAxisAlignment"],
            children: children
                .map((eg) => Tooltip(
                      message: eg.type,
                      child: GestureDetector(
                          onTap: () {
                            onChildrenClicked!(eg);
                          },
                          child: eg.build(context)),
                    ))
                .toList()),
      );
    } else {
      return SizedBox(
        height: widget["height"],
        width: widget["width"],
        child: Column(
            crossAxisAlignment: widget["crossAxisAlignment"],
            mainAxisAlignment: widget["mainAxisAlignment"],
            children: children.map((eg) => eg.build(context)).toList()),
      );
    }
  }

  Widget stack(context, bool playMode) {
    if (playMode == false) {
      return Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
        height: widget["height"],
        width: widget["width"],
        child: Stack(
            children: children
                .map(
                  (eg) => Tooltip(
                    message: eg.type,
                    child: GestureDetector(
                        onTap: () {
                          onChildrenClicked!(eg);
                        },
                        child: eg.build(context)),
                  ),
                )
                .toList()),
      );
    } else {
      return SizedBox(
          height: widget["height"],
          width: widget["width"],
          child: Stack(
              children: children.map((eg) => eg.build(context)).toList()));
    }
  }

  Widget center(context, bool playMode) {
    if (playMode == false) {
      return Center(
        child: Tooltip(
          message: child != null ? child!.type : "",
          child: GestureDetector(
            onTap: child == null
                ? null
                : () {
                    childClick!(child!);
                  },
            child: child == null
                ? TextForLessCode(value: "Center")
                : child!.build(context),
          ),
        ),
      );
    } else {
      return Center(
        child: child == null
            ? TextForLessCode(value: "Center")
            : child!.build(context),
      );
    }
  }

  Widget padding(BuildContext context, bool playMode) {
    if (playMode == false) {
      return SizedBox(
        height: widget["height"],
        width: widget["width"],
        child: Padding(
          padding: EdgeInsets.only(
              left: widget["paddingLeft"],
              right: widget["paddingRight"],
              top: widget["paddingTop"],
              bottom: widget["paddingBottom"]),
          child: Tooltip(
            message: child != null ? child!.type : "",
            child: GestureDetector(
              onTap: child == null
                  ? null
                  : () {
                      childClick!(child!);
                    },
              child: child == null
                  ? TextForLessCode(value: "Padding")
                  : child!.build(context),
            ),
          ),
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(
            left: widget["paddingLeft"],
            right: widget["paddingRight"],
            top: widget["paddingTop"],
            bottom: widget["paddingBottom"]),
        child: child == null
            ? TextForLessCode(value: "Padding")
            : child!.build(context),
      );
    }
  }

  Widget checkbox(bool playMode) {
    if (playMode) {
      return SizedBox(
        height: widget["height"],
        width: widget["width"],
        child: Checkbox(
            value: widget["checkboxValue"],
            onChanged: playMode
                ? (e) {
                    widget["checkboxValue"] = e;
                  }
                : null),
      );
    } else {
      return Checkbox(value: false, onChanged: null);
    }
  }

  Widget divider() {
    return SizedBox(
      height: widget["height"],
      width: widget["width"],
      child: FittedBox(
        child: Divider(
          color: widget["color"],
          height: widget["height"],
          thickness: widget["width"],
        ),
      ),
    );
  }

  Widget sizedBox(BuildContext context) {
    return SizedBox(
        height: widget["height"],
        width: widget["width"],
        child: child == null
            ? TextForLessCode(value: "SizedBox")
            : child!.build(context));
  }

  Widget safeArea(BuildContext context) {
    DeviceInfo screenSizes = context.watch<ScreenInfo>().devaceName;

    return SizedBox(
      height: widget["height"],
      width: widget["width"],
      child: FittedBox(
        child: Padding(
            padding: EdgeInsets.only(
              left: widget["SafeArealeft"] ? screenSizes.safeAreas.left : 0,
              top: widget["SafeAreatop"] ? screenSizes.safeAreas.top : 0,
              bottom:
                  widget["SafeAreabottom"] ? screenSizes.safeAreas.bottom : 0,
              right: widget["SafeArearight"] ? screenSizes.safeAreas.right : 0,
            ),
            child: child == null
                ? TextForLessCode(value: "SafeArea")
                : child!.build(context)),
      ),
    );
  }

  // children to row or stack or clumn
  void addToList(WidgetMoG widget, BuildContext context) {
    children.add(widget);
  }

  playModeSetr(BuildContext context) {
    Provider.of<ScreenInfo>(context, listen: true).changerUnableOnClick(true);
  }

  void removeFromList(WidgetMoG id) {
    children.remove(id);
  }

  void openCodePanle() {}
}
