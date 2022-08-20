import 'package:builder/componanets/button.dart';
import 'package:builder/componanets/text.dart';
import 'package:builder/componanets/widget_tree.dart';
import 'package:builder/systems/run_app.dart';
import 'package:builder/colors.dart';

import 'package:builder/componanets/properties_editr_bar.dart';

import 'package:builder/componanets/widgets_Bar.dart';
import 'package:builder/systems/code_panle.dart';
import 'package:builder/systems/screen.dart';

import 'package:builder/systems/canvas.dart';

import 'package:builder/systems/widget.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import 'componanets/widgets_Bar.dart';
import 'systems/canvas_controller.dart';

class BuilderWorkPage extends StatefulWidget {
  const BuilderWorkPage({Key? key}) : super(key: key);

  @override
  State<BuilderWorkPage> createState() => _BuilderWorkPageState();
}

class _BuilderWorkPageState extends State<BuilderWorkPage> {
  CanvasController controller =
      CanvasController(notifier: notifier, children: []);

  double top = 0.0;
  double left = 0.0;
  Color colore = Colors.red;
  bool screen = true;
  bool widgete = false;

  MoGCanvasItem? selectedScreen = MoGCanvasItem();
  WidgetMoG? selectedWidget;
  WidgetMoG? perent;
  int? wisgetKey;
  String propertiesbarType = "e";
  bool propertiesbar = false;
  String childType = "null";
  bool widgetBarvisiblety = true;
  TextEditingController textEditingController = TextEditingController();
  String appName = "My app";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Builder X ",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(40.0),
            child: AppBar(
              automaticallyImplyLeading: false,
              title: Center(
                  child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: TextForLessCode(value: appName))),
              backgroundColor: barsColor,
              flexibleSpace: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 180,
                      child: Wrap(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: widgetBarvisiblety
                                            ? textFieldColor
                                            : barsColor,
                                        width: 1))),
                            child: GestureDetector(
                              child: TextForLessCode(
                                value: "Widgets",
                                color: Colors.white,
                              ),
                              onTap: () {
                                widgetBarvisiblety = true;
                                setState(() {});
                              },
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: widgetBarvisiblety == false
                                              ? textFieldColor
                                              : barsColor,
                                          width: 1))),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: GestureDetector(
                                  child: TextForLessCode(
                                    value: "Widgets Tree",
                                    color: Colors.white,
                                  ),
                                  onTap: () {
                                    widgetBarvisiblety = false;
                                    setState(() {});
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 8, bottom: 8, left: 2, right: 3),
                        child: ButtonForLessCode(
                          size: const Size(150, 35),
                          color: textFieldColor,
                          child: TextForLessCode(
                            value: "Run",
                            color: Colors.white,
                          ),
                          onClick: () {
                            if (controller.children.length > 0) {
                              Provider.of<ScreenInfo>(context, listen: true)
                                  .changerUnableOnClick(true);
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return LivePreviwe(
                                        screens: controller.children,
                                        colosDiloge: () {
                                          Navigator.pop(context);
                                        });
                                  });
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: [
              MoGCanvasView(
                backgroundColor: backGroundColor,
                borderColor: boxTextColor,
                controller: controller,
                onSelect: (itme) {
                  widgete = false;
                  screen = true;
                  propertiesbar = false;
                  if (itme != null) {
                    selectedScreen = itme;

                    setState(() {});
                  }
                },
                onZoom: (itme) {
                  setState(() {});
                },
                onRemove: (itme) {
                  controller.children.remove(itme);
                  selectedScreen = MoGCanvasItem();
                  setState(() {});
                },
                settings: (itme) {
                  selectedScreen = itme;
                  propertiesbarType = "screen";
                  propertiesbar = true;
                  setState(() {});
                },
                onRotate: (itme) {
                  setState(() {});
                },
                onError: (itme) {
                  setState(() {});
                },
                onDeviceChange: (MoGCanvasItem item, Offset pos) {
                  selectedScreen = item;

                  setState(() {});
                },
                onDrag: (bool value, Offset delta, MoGCanvasItem? item,
                    List<MoGCanvasItem> overlaps) {
                  setState(() {});
                },
                onChilderClicked: (widget, keyg) {
                  screen = false;
                  widgete = true;
                  wisgetKey = keyg;
                  selectedWidget = widget;
                  propertiesbarType = widget.type;
                  propertiesbar = true;
                },
                floatingActionButton: FloatingActionButton(onPressed: () {
                  propertiesbarType = "floatingActionButton";
                  propertiesbar = true;
                }),
                appBar: AppBar(),
                drawer: const Drawer(),
                restSelector: () {
                  propertiesbarType = "screen";
                },
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Visibility(
                  replacement: WidgetTree(),
                  visible: widgetBarvisiblety,
                  child: LeftBars(
                      selectedScreen: selectedScreen,
                      add: (addName, widget, child) {
                        if (selectedScreen != MoGCanvasItem()) {
                          add(addName, widget, child);
                          setState(() {});
                        }

                        propertiesbar = false;
                      }),
                ),
              ),
              Visibility(
                visible: propertiesbar,
                child: Align(alignment: Alignment.topRight, child: widg()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void notifier([bool notify = true]) {}

  void add(String addName, String widget, String child) {
    // add widget void
    if (addName == "screen") {
      controller.children.add(
        MoGCanvasItem(
          rootKey: "rootKey",
          key: const Uuid().v1(),
          items: [],
          labele: "Screen${controller.children.length + 1}",
          childClicked: (child) {
            propertiesbar = true;
            propertiesbarType = child.type;
            selectedWidget = child;
            screen = false;
            widgete = true;

            setState(() {});
          },
          onChildrenInClicked: (widget) {
            propertiesbar = true;
            propertiesbarType = widget.type;
            selectedWidget = widget;
            screen = false;
            widgete = true;

            setState(() {});
          },
          drawerWidget: const Drawer(),
          appBarWidget: AppBar(),
          floatingActionButtonWidget: FloatingActionButton(
            onPressed: () {},
          ),
        ),
      );
    }
    // add widget to selected screen
    else if (addName == "widget" &&
        widgete == false &&
        selectedScreen != null) {
      selectedScreen!.addChildreToScreen(widget, controller);
    }
    // add child to to selected widget
    else if (addName == "widget" &&
        screen == false &&
        selectedWidget!.canHaveChild) {
      selectedScreen!.addChild(selectedWidget!, widget, controller, context);

      setState(() {});
    }
  }

  Widget widg() {
    return PropertesBar(
      selectedScreen: selectedScreen!,
      childType: childType,
      widget: selectedWidget,
      widgetType: propertiesbarType,
      updateUI: () {
        setState(() {});
      },
      setwidget: (e) {
        propertiesbar = false;
        selectedWidget = e;

        setState(() {});
      },
      deleteWidget: (e) {
        selectedScreen!.items.remove(e);
      },
      deleteScreen: (e) {
        controller.children.remove(e);
      },
      colosUi: () {
        propertiesbar = false;
        setState(() {});
      },
      openCodePanle: () {
        showDialog(
            context: context,
            builder: (context) {
              return codePanleUi();
            });
      },
    );
  }

  Widget codePanleUi() {
    return Dialog(
      child: Container(
        width: 604,
        decoration: BoxDecoration(
            border: Border.all(color: textFieldColor, width: 2),
            borderRadius: BorderRadius.circular(50)),
        child: CodePanle(
          controller: controller,
          jsonBlock: selectedWidget!.codeBlocks,
          jsonSeter: (jsonData, code) {
            selectedWidget!.codeBlocks["nodes"]!.add(jsonData);
          },
          edgeSeter: (edgeData) {
            selectedWidget!.codeBlocks["edges"]!.add(edgeData);
          },
          nodeDeleter: (node) {
            selectedWidget!.codeBlocks["nodes"]!.remove(node);
          },
          setAction: (e, type) {
            if (type == "nav") {
              selectedWidget!.onclick = () =>
                  Provider.of<ScreenInfo>(context, listen: true).changeScreen(
                      controller.children
                          .indexWhere((element) => element.labele == e));
            }
          },
        ),
      ),
    );
  }
}
