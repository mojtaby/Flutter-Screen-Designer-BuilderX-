import 'package:builder/systems/widget.dart';
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
  AppBar? appBarWidget;
  FloatingActionButton? floatingActionButtonWidget;
  Drawer? drawerWidget;

  double? borderWhenSelected;
  bool? canHaveChild;
  Function(WidgetMoG)? onChildrenInClicked;
  Function(WidgetMoG)? childClicked;
  List<WidgetMoG> items;
  Color backGroundColor;

  MoGCanvasItem({
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

// add child to selected widget
  addChild(WidgetMoG widget, String addType, CanvasController controller,
      BuildContext context) {
    if (widget.type == "row" ||
        widget.type == "stack" ||
        widget.type == "column") {
      widget.addToList(
          WidgetMoG(
              childClick: (child) {
                childClicked!(child);
              },
              controllerNav: controller,
              keye: items.length + 1,
              type: addType,
              canHaveChild: widget.canHaveChild,
              onChildrenClicked: (widgetMoG) {
                onChildrenInClicked!(widgetMoG);
              }),
          context);
    } else {
      widget.child = WidgetMoG(
          childClick: (child) {
            childClicked!(child);
          },
          controllerNav: controller,
          keye: items.length + 1,
          type: addType,
          canHaveChild: false,
          onChildrenClicked: (widgetMoG) {
            onChildrenInClicked!(widgetMoG);
          });
    }
  }

// add child to selected screen
  addChildreToScreen(String type, CanvasController controller) {
    Uuid id = const Uuid();
    // set any widget to can Have child except thes under
    if (type != "text" && type != "image" && type != "icon") {
      adder(id, type, true, controller);
    } else {
      adder(id, type, false, controller);
    }
  }

// more about add child to selected screen, made for less code
  adder(Uuid id, String type, bool canHaveChild, CanvasController controller) {
    items.add(WidgetMoG(
        controllerNav: controller,
        keye: items.length,
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
              childClick: (child) {
                childClicked!(child);
              },
              controllerNav: controller,
              keye: items.length + 1,
              type: type,
              canHaveChild: widget.canHaveChild,
              onChildrenClicked: (widgetMoG) {
                onChildrenInClicked!(widgetMoG);
              }),
          context);
    } else {
      widget.child = WidgetMoG(
          childClick: (child) {
            childClicked!(child);
          },
          controllerNav: controller,
          keye: items.length + 1,
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

  Map get asMap => {
        'key': key,
        'label': labele,
        'root': rootKey,
        'appBar': appBar,
        'drawer': drawer,
        'boder': borderWhenSelected,
        'flotingButton': floatingActionButton,
        'items': items,
        'size': {'width': size.width, 'height': size.height},
        'sizeProfile': sizeProfilee,
        'rotate': rotatee,
        'offset': {'x': offsete.dx, 'y': offsete.dy},
      };
}

class CanvasController with ChangeNotifier {
  final List<MoGCanvasItem> children;
  int _screen = 0;

  double _zoom = 1;
  final void Function([bool notify]) notifier;

  CanvasController({
    this.children = const [],
    required this.notifier,
  });

  double get zoom => _zoom;
  int get screen => _screen;
  setZoom(double zoom) {
    _zoom = zoom;
  }

  setscreen(int screene) {
    _screen = screene;
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
