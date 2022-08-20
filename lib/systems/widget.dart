import 'package:builder/componanets/text.dart';
import 'package:builder/systems/canvas_controller.dart';
import 'package:builder/systems/screen.dart';

import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WidgetMoG {
  WidgetMoG(
      {required this.keye,
      required this.type,
      required this.canHaveChild,
      required this.onChildrenClicked,
      this.child,
      required this.childClick,
      this.onclick,
      required this.controllerNav,
      this.varName,
      this.valueFromVar = false,
      this.checkBoxClicked});

  CanvasController? controllerNav;
  final int keye;
  final bool canHaveChild;
  final String type;
  Function(WidgetMoG)? onChildrenClicked;
  Function(WidgetMoG)? childClick;
  List<WidgetMoG> children = [];
  WidgetMoG? child;
  void Function()? onclick;
  void Function()? checkBoxClicked;
  bool valueFromVar = false;
  dynamic varName;

  Map<String, dynamic> widget = {
    "textValue": "Text",
    "color": Colors.red,
    "textFontsize": 20,
    "height": 100,
    "width": 100,
    "child": null,
    "imageUrl":
        "https://i.postimg.cc/bry3DVCm/efd89fda9fd543e792c1bae77ae100d5.png",
    "onPressed": null,
    "icon": Icons.add,
    "size": 20,
    "font": "Tajawal",
    "imageBoxFit": BoxFit.cover,
    "crossAxisAlignment": CrossAxisAlignment.start,
    "mainAxisAlignment": MainAxisAlignment.start,
    "checkboxValue": false,
  };

  var codeBlocks = {
    "nodes": [
      {"id": 1, "label": 'On click'},
      {"id": 2, "label": 'Function{'},
    ],
    "code": [],
    "edges": [
      {"from": 1, "to": 2},
    ]
  };

  Widget build(BuildContext context) {
    bool unableOnclick = context.watch<ScreenInfo>().unableOnClick;
    if (type == "text") {
      return text();
    } else if (type == "container") {
      return container(context);
    } else if (type == "image") {
      return image();
    } else if (type == "button") {
      return button(context, unableOnclick);
    } else if (type == "icon") {
      return icon();
    } else if (type == "row") {
      return row(context);
    } else if (type == "column") {
      return column(context);
    } else if (type == "stack") {
      return stack(context);
    } else if (type == "center") {
      return center(context);
    } else if (type == "checkbox") {
      return checkbox(unableOnclick);
    } else {
      return const SizedBox();
    }
  }

  Widget container(BuildContext context) {
    return CustomContainer(
      color: widget["color"],
      height: widget["height"],
      width: widget["width"],
      child: GestureDetector(
        onDoubleTap: child == null
            ? null
            : () {
                childClick!(child!);
              },
        child: child == null ? null : child!.build(context),
      ),
    );
  }

  Widget button(BuildContext context, bool unableOnclick) {
    return SizedBox(
      height: widget["height"],
      width: widget["width"],
      child: CustomButton(
        onPressed: unableOnclick ? onclick : null,
        color: widget["color"],
        child: GestureDetector(
          onDoubleTap: child == null
              ? null
              : () {
                  childClick!(child!);
                },
          child: child == null
              ? TextForLessCode(value: "Button")
              : child!.build(context),
        ),
      ),
    );
  }

  Widget text() {
    return Text(
      valueFromVar == false ? widget["textValue"] : varName.toString(),
      style: TextStyle(
          color: widget["color"],
          fontSize: widget["textFontsize"],
          fontFamily: widget["font"]),
    );
  }

  Widget image() {
    return Image(
      fit: widget["imageBoxFit"],
      height: widget["height"],
      width: widget["width"],
      image: NetworkImage(widget["imageUrl"]),
    );
  }

  Widget icon() {
    return Icon(
      widget["icon"],
      color: widget["color"],
      size: widget["size"],
    );
  }

  Widget row(context) {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(color: Colors.grey, width: 1)),
      height: widget["height"],
      width: widget["width"],
      child: Row(
        crossAxisAlignment: widget["crossAxisAlignment"],
        mainAxisAlignment: widget["mainAxisAlignment"],
        children: children
            .map((eg) => GestureDetector(
                onTap: () {
                  onChildrenClicked!(eg);
                },
                child: eg.build(context)))
            .toList(),
      ),
    );
  }

  Widget column(context) {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(color: Colors.grey, width: 1)),
      height: widget["height"],
      width: widget["width"],
      child: Column(
          crossAxisAlignment: widget["crossAxisAlignment"],
          mainAxisAlignment: widget["mainAxisAlignment"],
          children: children
              .map((eg) => GestureDetector(
                  onTap: () {
                    onChildrenClicked!(eg);
                  },
                  child: eg.build(context)))
              .toList()),
    );
  }

  Widget stack(context) {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(color: Colors.grey, width: 1)),
      height: widget["height"],
      width: widget["width"],
      child: Stack(
        children: children
            .map((eg) => GestureDetector(
                onTap: () {
                  onChildrenClicked!(eg);
                },
                child: eg.build(context)))
            .toList(),
      ),
    );
  }

  Widget center(context) {
    return Center(
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
    );
  }

  Widget checkbox(bool unableOnclick) {
    return Checkbox(
        value: widget["checkboxValue"],
        onChanged: unableOnclick
            ? (e) {
                widget["checkboxValue"] = e;
              }
            : null);
  }

  // children to row or stack or clumn
  void addToList(WidgetMoG widget, BuildContext context) {
    children.add(widget);
  }

  void removeFromList(WidgetMoG id) {
    children.remove(id);
  }

  void openCodePanle() {}
}
