import 'package:builder/systems/widget.dart';
import 'package:device_frame/device_frame.dart';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

enum Restack { top, up, down, bottom }

class MoGCanvasItem with ChangeNotifier {
  String key;
  String rootKey;
  String labele;
  int focusCount = 0;
  String sizeProfilee;
  Offset offsete;
  Size sizee;
  bool rotatee;
  bool appBar;
  bool floatingActionButton;
  bool drawer;
  PreferredSize? appBarWidget;
  PreferredSize? floatingActionButtonWidget;
  PreferredSize? drawerWidget;

  double? borderWhenSelected;
  bool? canHaveChild;
  Function(WidgetMoG)? onChildrenInClicked;
  Function(WidgetMoG)? childClicked;
  List<WidgetMoG> items;
  List<Widget> widgets = [];
  Color backGroundColor;

  DeviceInfo? deviceName = Devices.ios.iPhone13;

  MoGCanvasItem({
    this.deviceName,
    this.key = "",
    this.rootKey = "",
    this.items = const [],
    this.backGroundColor = Colors.white,
    this.appBarWidget,
    this.floatingActionButtonWidget,
    this.drawerWidget,
    this.labele = "Screen 1",
    this.sizee = const Size(360, 640),
    this.sizeProfilee = 'Android',
    this.rotatee = false,
    this.borderWhenSelected = 3,
    this.offsete = Offset.zero,
    this.drawer = false,
    this.floatingActionButton = false,
    this.appBar = false,
    this.canHaveChild = true,
    this.onChildrenInClicked,
    this.childClicked,
  });

  Offset get offset => offsete;
  Size get size => sizee;
  bool get rotate => rotatee;
  String get sizeProfile => sizeProfilee;

  var screenVariables = [];
  Map<dynamic, dynamic> widgetVar = {};

  setWidget(List<WidgetMoG> widgetLsit, BuildContext context) {
    widgets = widgetLsit.map((e) => e.build(context)).toList();
  }

  varMaker(String varName, String varType, bool isList, dynamic value) {
    screenVariables.add(
        {"type": varType, "name": varName, "isList": isList, "value": value});

    notifyListeners();
  }

  varEditor(
      var oldVar, String varName, String varType, bool isList, dynamic value) {
    screenVariables[
        screenVariables.indexWhere((element) => element == oldVar)] = {
      "type": varType,
      "name": varName,
      "isList": isList,
      "value": value
    };
    notifyListeners();
  }

  changeLabel(String value) {
    labele = value;
  }

  setOffset(Offset offset) {
    offsete = offset;
  }

  rotateSize() {
    rotatee = !rotatee;
    sizee = size.flipped;
  }

  setSize(String profile, Size size) {
    sizeProfilee = profile;
    sizee = size;
  }

  /// add child to selected widget
  addChild(WidgetMoG widget, String addType, CanvasController controller,
      BuildContext context) {
    if (widget.type == "row" ||
        widget.type == "stack" ||
        widget.type == "column") {
      widget.addToList(
          WidgetMoG(
              widgetName: "WidgetName",
              childClick: (child) {
                childClicked!(child);
              },
              controllerNav: controller,
              keye: Uuid().v1(),
              type: addType,
              canHaveChild: widget.canHaveChild,
              onChildrenClicked: (widgetMoG) {
                onChildrenInClicked!(widgetMoG);
              }),
          context);
    } else if (widget.type != "text" &&
        widget.type != "image" &&
        widget.type != "icon") {
      widget.child = WidgetMoG(
          widgetName: "WidgetName",
          childClick: (child) {
            childClicked!(child);
          },
          controllerNav: controller,
          keye: Uuid().v1(),
          type: addType,
          canHaveChild: false,
          onChildrenClicked: (widgetMoG) {
            onChildrenInClicked!(widgetMoG);
          });
    }
  }

  /// add child to selected screen
  addChildreToScreen(String type, CanvasController controller) {
    // set any widget to can Have child except thes under
    if (type != "text" && type != "image" && type != "icon") {
      adder(type, true, controller);
    } else {
      adder(type, false, controller);
    }
  }

  /// more about add widget to selected screen, made for less code
  adder(String type, bool canHaveChild, CanvasController controller) {
    items.add(WidgetMoG(
        widgetName: "WidgetName",
        controllerNav: controller,
        keye: Uuid().v1().toString(),
        type: type,
        canHaveChild: canHaveChild,
        childClick: (child) {
          childClicked!(child);
        },
        onChildrenClicked: (widgetMoG) {
          onChildrenInClicked!(widgetMoG);
        }));
  }

// add child to any widget can tack child
  addChildToWidget(String widgteType, BuildContext context,
      CanvasController controller, WidgetMoG widget) {
    childer(widgteType, context, controller, widget);
  }

// more about add child ,made for less code
  childer(String type, BuildContext context, CanvasController controller,
      WidgetMoG widget) {
    if (widget.type == "row" ||
        widget.type == "stack" ||
        widget.type == "column") {
      widget.addToList(
          WidgetMoG(
              widgetName: "WidgetName",
              childClick: (child) {
                childClicked!(child);
              },
              controllerNav: controller,
              keye: Uuid().v1(),
              type: type,
              canHaveChild: widget.canHaveChild,
              onChildrenClicked: (widgetMoG) {
                onChildrenInClicked!(widgetMoG);
              }),
          context);
    } else {
      widget.child = WidgetMoG(
          widgetName: "WidgetName",
          childClick: (child) {
            childClicked!(child);
          },
          controllerNav: controller,
          keye: Uuid().v1(),
          type: type,
          canHaveChild: widget.canHaveChild,
          onChildrenClicked: (widgetMoG) {
            onChildrenInClicked!(widgetMoG);
          });
    }
  }

  valueChanger(WidgetMoG widget, String changeName, dynamic changevalue) {
    widget.widget[changeName] = changevalue;
  }

  Map data = {};

  Map get asMap => {
        'key': key,
        'label': labele,
        'root': rootKey,
        'appBar': appBar,
        'drawer': drawer,
        'boder': borderWhenSelected,
        'flotingButton': floatingActionButton,
        'items': items.map((e) => e.asMap),
        'size': {'width': size.width, 'height': size.height},
        'sizeProfile': sizeProfilee,
        'rotate': rotatee,
        'offset': {'x': offsete.dx, 'y': offsete.dy},
      };
}

class CanvasController {
  late List<MoGCanvasItem> children;

  double _top = 0;
  double _left = 0;
  double _zoom = 1;

  final void Function([bool notify]) notifier;

  CanvasController({
    this.children = const [],
    required this.notifier,
  });

  double get zoom => _zoom;
  double get top => _top;
  double get lefy => _left;

  setChildern(List<MoGCanvasItem> childerne) {
    children = childerne;
  }

  setZoom(double zoom) {
    _zoom = zoom;
  }

  setOfess(double left, double top) {
    _left = left;
    _top = top;
  }

  List<MoGCanvasItem> restack(MoGCanvasItem item,
      [Restack mode = Restack.top]) {
    final i = children.indexWhere((el) => el.key == item.key);
    children.removeAt(i);
    switch (mode) {
      case Restack.top:
        children.add(item);
        break;
      case Restack.up:
        children.insert(i + 1, item);
        break;
      case Restack.down:
        children.insert(i == 0 ? 0 : i - 1, item);
        break;
      case Restack.bottom:
        children.insert(0, item);
        break;
    }
    return children;
  }

  List<Map> get asMap => children.map((e) => e.asMap).toList();
}
