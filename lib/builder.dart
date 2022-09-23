import 'package:builder/componanets/show_code_ui.dart';
import 'package:builder/systems/code_compreser.dart';
import 'package:builder/systems/code_genrater.dart';
import 'package:builder/componanets/button.dart';
import 'package:builder/componanets/container.dart';
import 'package:builder/componanets/text.dart';
import 'package:builder/componanets/widget_tree.dart';
import 'package:builder/systems/run_app.dart';

import 'package:builder/componanets/properties_editr_bar.dart';
import 'package:builder/componanets/widgets_Bar.dart';
import 'package:builder/systems/code_panle.dart';
import 'package:builder/systems/screen.dart';
import 'package:builder/systems/canvas.dart';
import 'package:builder/systems/widget.dart';

import 'package:device_frame/device_frame.dart';

import 'package:flutter/material.dart';
import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:flutter_dropdown_alert/dropdown_alert.dart';

import 'package:provider/provider.dart';

import 'package:uuid/uuid.dart';
import 'componanets/widgets_Bar.dart';
import 'systems/canvas_controller.dart';

class BuilderWorkPage extends StatefulWidget {
  BuilderWorkPage({Key? key}) : super(key: key);

  @override
  State<BuilderWorkPage> createState() => _BuilderWorkPageState();
}

class _BuilderWorkPageState extends State<BuilderWorkPage> {
  CanvasController controller =
      CanvasController(notifier: notifier, children: []);

  double top = 0.0;
  double left = 0.0;

  bool screen = true;
  bool widgete = false;
  bool canPlayAndSeeCode = false;
  bool isSelectedWidgetisScreenChild = true;
  MoGCanvasItem? selectedScreene = MoGCanvasItem();
  WidgetMoG? selectedWidget;

  int? wisgetKey;
  String propertiesbarType = " ";

  bool editAppName = false;
  String childType = "null";
  WidgetMoG? perent;
  TextEditingController textEditingController = TextEditingController();
  String appName = "My App";
  bool smallAppBar = true;
  bool widgetBarVisiblety = false;
  bool widgetTreeVisiblety = false;
  bool darkMode = false;
  Map<String, dynamic> copydata = const {};
  bool propbar = false;
  bool fromData = true;

  @override
  void initState() {
    List<MoGCanvasItem> screens = [];
    screens.forEach((element) {
      controller.children.add(
        MoGCanvasItem(
          rootKey: element.rootKey,
          key: element.key,
          items: element.items,
          deviceName: element.deviceName,
          sizee: element.sizee,
          sizeProfilee: element.sizeProfilee,
          labele: element.labele,
          childClicked: element.childClicked,
          onChildrenInClicked: element.onChildrenInClicked,
          drawerWidget: element.drawerWidget,
          appBarWidget: element.appBarWidget,
          floatingActionButtonWidget: element.floatingActionButtonWidget,
        ),
      );
    });
    setState(() {});

    super.initState();
  }

  @override
  build(BuildContext context) {
    Color scendryColor = context.watch<ScreenInfo>().scendryColor;
    Color backGroundColor = context.watch<ScreenInfo>().backGroundColor;
    Color firstColor = context.watch<ScreenInfo>().firstColor;
    Color textColor = context.watch<ScreenInfo>().textColor;
    Size size = MediaQuery.of(context).size;
    int homeScreenIndex = context.watch<ScreenInfo>().homeScreen;
    DeviceInfo deviceInfo = context.watch<ScreenInfo>().devaceName;
    propbar = context.watch<ScreenInfo>().propertiesBar;
    WidgetsFlutterBinding.ensureInitialized();
    return MaterialApp(
      builder: (context, child) => Stack(
        children: [
          child!,
          DropdownAlert(
            successBackground: scendryColor,
            titleStyle: TextStyle(color: Colors.white),
            contentStyle: TextStyle(color: Colors.white),
          )
        ],
      ),
      title: "Builder X ",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(40.0),
            child: AppBar(
              backgroundColor: backGroundColor,
              title: Stack(
                children: [
                  Center(
                    child: TextForLessCode(
                      value: appName,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              flexibleSpace: Container(
                padding: const EdgeInsets.all(8.0),
                color: backGroundColor,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: SizedBox(
                        width: 200,
                        child: Row(
                          children: [
                            ButtonForRounded(
                              size: const Size(80, 30),
                              text: "Run",
                              buttonColor: Colors.white,
                              textcolor: Colors.black,
                              onClick: () {
                                if (canPlayAndSeeCode &&
                                    controller.children.isNotEmpty) {
                                  Provider.of<ScreenInfo>(context, listen: true)
                                      .changerUnableOnClick(true);
                                  Provider.of<ScreenInfo>(context, listen: true)
                                      .setDevaceName(controller
                                          .children[homeScreenIndex]
                                          .deviceName!);
                                  Provider.of<ScreenInfo>(context, listen: true)
                                      .changeScreen(homeScreenIndex);
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return LivePreviwe(
                                          screens: controller.children,
                                          colosDiloge: () {
                                            Navigator.pop(context);
                                          });
                                    },
                                  );
                                }
                              },
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            ButtonForRounded(
                              size: const Size(80, 30),
                              text: "Code",
                              buttonColor: scendryColor,
                              textcolor: Colors.white,
                              onClick: () {
                                if (canPlayAndSeeCode &&
                                    controller.children.isNotEmpty) {
                                  code(deviceInfo);
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return CodeShowUi(
                                        getCode: (eg, vars) {
                                          code(deviceInfo);
                                          selectedScreene =
                                              controller.children[eg];
                                        },
                                        controller: controller,
                                      );
                                    },
                                  );
                                }
                              },
                            )
                          ],
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
              Stack(
                children: [
                  MoGCanvasView(
                    backgroundColor: backGroundColor,
                    borderColor: scendryColor,
                    controller: controller,
                    copy: (copyData) {
                      copydata = copyData;
                    },
                    paste: () {
                      copydata.forEach((key, value) {
                        selectedWidget!.widget[key] = value;
                      });
                      Provider.of<ScreenInfo>(context, listen: true)
                          .setrestOverWidget(true);
                      setState(() {});
                    },
                    alert: (title, message, typeAlert) =>
                        AlertController.show(title, message, typeAlert),
                    onSelect: (itme) {
                      editAppName = false;

                      if (itme != null) {
                        selectedScreene = itme;
                        canPlayAndSeeCode = true;
                        Provider.of<ScreenInfo>(context, listen: true)
                            .setScreen(itme);

                        widgete = false;
                        screen = true;
                        Provider.of<ScreenInfo>(context, listen: true)
                            .setpropertiesBar(false);

                        Provider.of<ScreenInfo>(context, listen: true)
                            .setSelectedWdiget(WidgetMoG(
                                keye: "0",
                                type: "ss",
                                canHaveChild: false,
                                onChildrenClicked: (r) {},
                                childClick: (e) {},
                                controllerNav: CanvasController(
                                  notifier: ([notify = false]) => false,
                                )));
                      }
                      setState(() {});
                    },
                    onZoom: (itme) {
                      setState(() {});
                    },
                    onRemove: (itme) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              backgroundColor: Colors.transparent,
                              child: ContainerForLessCode(
                                setHight: false,
                                child: SizedBox(
                                  height: 130,
                                  width: 200,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      TextForLessCode(
                                          size: 20,
                                          color: Colors.red,
                                          value:
                                              "Are you sure you want to delete the screen? ${selectedScreene!.labele}"),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          ButtonForOutline(
                                            buttonColor: Colors.white,
                                            size: const Size(100, 50),
                                            text: "No",
                                            textcolor: scendryColor,
                                            onClick: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          ButtonForOutline(
                                            buttonColor: Colors.white,
                                            size: const Size(100, 50),
                                            text: "Yes",
                                            textcolor: scendryColor,
                                            onClick: () {
                                              Provider.of<ScreenInfo>(context,
                                                      listen: true)
                                                  .setScreen(MoGCanvasItem());
                                              controller.children.remove(itme);
                                              selectedScreene = MoGCanvasItem();

                                              setState(() {});
                                              Navigator.pop(context);
                                              Provider.of<ScreenInfo>(context,
                                                      listen: true)
                                                  .setpropertiesBar(false);
                                            },
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    },
                    settings: (itme) {
                      selectedScreene = itme;
                      propertiesbarType = "screen";
                      Provider.of<ScreenInfo>(context, listen: true)
                          .setpropertiesBar(true);
                      setState(() {});
                    },
                    onRotate: (itme) {
                      setState(() {});
                    },
                    onError: (itme) {
                      Provider.of<ScreenInfo>(context, listen: true)
                          .consolee(itme.toString());
                      setState(() {});
                    },
                    onDeviceChange: (MoGCanvasItem item, Offset pos) {
                      selectedScreene = item;
                      setState(() {});
                    },
                    onDrag: (bool value, Offset delta, MoGCanvasItem? item,
                        List<MoGCanvasItem> overlaps) {},
                    onChilderClicked: (widget) {
                      screen = false;
                      widgete = true;
                      selectedWidget = widget;
                      propertiesbarType = selectedWidget!.type;
                      Provider.of<ScreenInfo>(context, listen: true)
                          .setSelectedWdiget(widget);
                      Provider.of<ScreenInfo>(context, listen: true)
                          .refresPropertiesBar();
                    },
                    floatingActionButton: const PreferredSize(
                        preferredSize: Size.fromHeight(40.0),
                        child: FloatingActionButton(onPressed: null)),
                    appBar: PreferredSize(
                        preferredSize: const Size.fromHeight(40.0),
                        child: GestureDetector(
                            onTap: () {},
                            child: AppBar(
                              title: const Text("data"),
                            ))),
                    drawer: const PreferredSize(
                        preferredSize: Size.fromHeight(40.0), child: Drawer()),
                    restSelector: (e) {},
                    refresh: () {
                      setState(() {});
                    },
                  ),
                  Visibility(
                    visible: smallAppBar,
                    child: Container(
                      width: 100,
                      height: double.infinity,
                      decoration: BoxDecoration(color: firstColor),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              height: MediaQuery.of(context).size.height,
                              width: 2.2,
                              decoration: BoxDecoration(
                                color: const Color(
                                  4291085508,
                                ),
                                borderRadius: BorderRadius.circular(
                                  0,
                                ),
                                boxShadow: const [],
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(
                                      0xff9572fc,
                                    ),
                                    Color(
                                      0xff43e7ad,
                                    ),
                                    Color(
                                      0xffe2d45c,
                                    ),
                                    Color(
                                      0xff9572fc,
                                    )
                                  ],
                                  begin: Alignment(
                                    0,
                                    1,
                                  ),
                                  end: Alignment(
                                    0,
                                    -1,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                TextForLessCode(
                                  size: 13,
                                  fontWeight: FontWeight.w200,
                                  value: "BETA",
                                  color: textColor,
                                ),
                                const SizedBox(
                                  height: 100,
                                ),
                                IconButton(
                                  icon: Icon(
                                    size: 35,
                                    Icons.highlight_alt,
                                    color: scendryColor,
                                  ),
                                  onPressed: () {
                                    smallAppBar = false;
                                    widgetTreeVisiblety = false;
                                    darkMode = false;
                                    widgetBarVisiblety = true;

                                    setState(() {});
                                  },
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                IconButton(
                                  icon: Icon(
                                    size: 35,
                                    Icons.account_tree,
                                    color: scendryColor,
                                  ),
                                  onPressed: () {
                                    smallAppBar = false;
                                    widgetBarVisiblety = false;
                                    darkMode = false;
                                    widgetTreeVisiblety = true;

                                    setState(() {});
                                  },
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                Visibility(
                                  visible: darkMode,
                                  replacement: IconButton(
                                    icon: Icon(
                                      size: 35,
                                      Icons.settings_applications,
                                      color: scendryColor,
                                    ),
                                    onPressed: () {
                                      darkMode = true;

                                      setState(() {});
                                    },
                                  ),
                                  child: IconButton(
                                    icon: Icon(
                                      size: 35,
                                      Icons.settings_applications,
                                      color: scendryColor,
                                    ),
                                    onPressed: () {
                                      darkMode = false;

                                      setState(() {});
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: size.height - 450,
                                ),
                                TextForLessCode(
                                  size: 13,
                                  fontWeight: FontWeight.w200,
                                  value: "v.0.1",
                                  color: textColor,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    child: Visibility(
                      visible: widgetBarVisiblety,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Visibility(
                          replacement: WidgetTree(
                            back: () {
                              smallAppBar = true;
                              widgetTreeVisiblety = false;
                              widgetBarVisiblety = false;
                              setState(() {});
                            },
                            selectNode: (e) {
                              widgete = true;
                              screen = false;

                              propertiesbarType = e!.type;
                              selectedWidget = e;
                              Provider.of<ScreenInfo>(context, listen: true)
                                  .setSelectedWdiget(e);
                              setState(() {});
                              Provider.of<ScreenInfo>(context, listen: true)
                                  .refresPropertiesBar();
                            },
                          ),
                          visible: widgetBarVisiblety,
                          child: LeftBars(
                              back: () {
                                smallAppBar = true;

                                widgetBarVisiblety = false;
                                setState(() {});
                              },
                              selectedScreen: selectedScreene,
                              add: (addName, widget, child) {
                                if (selectedScreene != MoGCanvasItem()) {
                                  add(addName, widget, child);
                                }
                              }),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Visibility(
                        visible: widgetTreeVisiblety,
                        child: WidgetTree(
                          back: () {
                            smallAppBar = true;
                            widgetTreeVisiblety = false;

                            setState(() {});
                          },
                          selectNode: (e) {
                            widgete = true;
                            screen = false;

                            propertiesbarType = e!.type;
                            selectedWidget = e;
                            Provider.of<ScreenInfo>(context, listen: true)
                                .setSelectedWdiget(e);
                            Provider.of<ScreenInfo>(context, listen: true)
                                .refresPropertiesBar();
                          },
                        )),
                  ),
                  Visibility(
                    visible: propbar,
                    child: Align(
                        alignment: Alignment.topRight,
                        child: propertesBar(scendryColor)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  code(DeviceInfo deviceInfo) {
    return Provider.of<ScreenInfo>(context, listen: true).setScreenCode(
        CodeGenerator().generatorMain(
            selectedScreene!.items
                .map((e) => Compres().cmpe(e, context, deviceInfo))
                .toList(),
            selectedScreene!.screenVariables.isNotEmpty,
            selectedScreene!,
            selectedScreene!.screenVariables),
        selectedScreene!.screenVariables);
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
          deviceName: Devices.ios.iPhone13,
          sizee: Devices.ios.iPhone13.screenSize,
          sizeProfilee: Devices.ios.iPhone13.name,
          labele: "Screen Name",
          childClicked: (childe) {
            perent = null;
            isSelectedWidgetisScreenChild = true;
            screen = false;
            widgete = true;
            selectedWidget = childe;
            propertiesbarType = selectedWidget!.type;
            Provider.of<ScreenInfo>(context, listen: true)
                .setSelectedWdiget(childe);
            Provider.of<ScreenInfo>(context, listen: true)
                .refresPropertiesBar();
          },
          onChildrenInClicked: (widget) {
            screen = false;
            widgete = true;
            isSelectedWidgetisScreenChild = false;
            selectedWidget = widget;
            propertiesbarType = selectedWidget!.type;

            Provider.of<ScreenInfo>(context, listen: true)
                .refresPropertiesBar();
          },
          drawerWidget: const PreferredSize(
            preferredSize: Size(double.infinity, 60),
            child: Drawer(),
          ),
          appBarWidget: PreferredSize(
              preferredSize: const Size(double.infinity, 60),
              child: GestureDetector(onTap: () {}, child: AppBar())),
          floatingActionButtonWidget: const PreferredSize(
              preferredSize: Size(double.infinity, 60),
              child: FloatingActionButton(
                onPressed: null,
              )),
        ),
      );
    }
    // add widget to selected screen
    else if (addName == "widget" &&
        widgete == false &&
        selectedScreene != null) {
      selectedScreene!.addChildreToScreen(widget, controller);
    }
    // add child to to selected widget
    else if (addName == "widget" && screen == false) {
      selectedScreene!.addChild(selectedWidget!, widget, controller, context);

      Provider.of<ScreenInfo>(context, listen: true).refresPropertiesBar();
    }
    setState(() {});
    perent = WidgetMoG(
        keye: "keye",
        type: "type",
        canHaveChild: false,
        onChildrenClicked: (e) {},
        childClick: (e) {},
        controllerNav: controller);
  }

  Widget propertesBar(scendryColor) {
    return PropertesBar(
      isItScreenchild: isSelectedWidgetisScreenChild,
      restperintWidget: () {
        isSelectedWidgetisScreenChild = true;
        perent = WidgetMoG(
            keye: "keye",
            type: "type",
            canHaveChild: false,
            onChildrenClicked: (e) {},
            childClick: (e) {},
            controllerNav: controller);
      },
      perintWidget: perent ??
          WidgetMoG(
              keye: "keye",
              type: "type",
              canHaveChild: false,
              onChildrenClicked: (e) {},
              childClick: (e) {},
              controllerNav: controller),
      isItScreen: screen,
      changeStartScreen: (e) {
        Provider.of<ScreenInfo>(context, listen: true)
            .changeHomeScreen(controller.children.indexOf(e));
      },
      selectedScreen: selectedScreene!,
      childType: childType,
      widget: selectedWidget,
      widgetType: propertiesbarType,
      updateUI: () {
        setState(() {});
      },
      setwidget: (e) {
        perent = selectedWidget!;
        propertiesbarType = e.type;
        selectedWidget = e;
        Provider.of<ScreenInfo>(context, listen: true).setSelectedWdiget(e);
        isSelectedWidgetisScreenChild = false;
        Provider.of<ScreenInfo>(context, listen: true).refresPropertiesBar();
      },
      deleteWidget: (e) {
        selectedScreene!.items.remove(e);

        Provider.of<ScreenInfo>(context, listen: true).setpropertiesBar(false);
        setState(() {});
      },
      deleteScreen: (e) {
        controller.children.remove(e);
        Provider.of<ScreenInfo>(context, listen: true).setpropertiesBar(false);
        setState(() {});
      },
      colosUi: () {
        Provider.of<ScreenInfo>(context, listen: true).setpropertiesBar(false);
      },
      openCodePanle: () {
        showDialog(
            context: context,
            builder: (context) {
              return codePanleUi(scendryColor);
            });
      },
    );
  }

  Widget codePanleUi(scendryColor) {
    return Dialog(
      child: Container(
        width: 604,
        decoration: BoxDecoration(
            border: Border.all(color: scendryColor, width: 2),
            borderRadius: BorderRadius.circular(50)),
        child: CodePanle(
          screen: selectedScreene!,
          controller: controller.children,
          jsonBlock: selectedWidget!.codeBlocks,
          jsonSeter: (jsonData, code) {
            selectedWidget!.codeBlocks["nodes"]!.add(jsonData);
          },
          edgeSeter: (edgeData) {
            selectedWidget!.codeBlocks["edges"]!.add(edgeData);
          },
          edgetEditor: (node, s, d) {},
          nodeDeleter: (nodee) {
            selectedWidget!.codeBlocks["nodes"]!
                .remove(selectedWidget!.codeBlocks["nodes"]![nodee["id"] - 1]);
            selectedWidget!.codeBlocks["edges"]!
                .remove(selectedWidget!.codeBlocks["edges"]![nodee["id"] - 2]);
          },
          setAction: (e, type, fromVar) {
            if (type == "nav") {
              selectedWidget!.onCllick.add(
                  {"type": "nav", "value": controller.children.indexOf(e)});
            } else if (type == "print") {
              selectedWidget!.onCllick.add({"type": "print", "value": e});
            }
          },
        ),
      ),
    );
  }
}
