// ignore_for_file: must_be_immutable

import 'package:builder/componanets/on_top_of_widget.dart';
import 'package:builder/systems/context_menu.dart';

import 'package:builder/systems/screen.dart';

import 'package:builder/systems/widget.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:grid_paper/grid_paper.dart';
import 'package:provider/provider.dart';

import 'canvas_controller.dart';

class MoGCanvasView extends HookWidget {
  MoGCanvasView(
      {Key? key,
      required this.controller,
      this.maxZoom = 2.0,
      this.minZoom = 0.5,
      this.enableControls = true,
      this.backgroundColor,
      this.borderColor = Colors.blue,
      this.textColor = Colors.white,
      this.messageToolTip = "New Screen",
      required this.restSelector,
      required this.appBar,
      required this.drawer,
      required this.floatingActionButton,
      required this.onChilderClicked,
      required this.onSelect,
      required this.onDeviceChange,
      required this.onDrag,
      required this.alert,
      required this.onZoom,
      required this.onRemove,
      required this.settings,
      required this.onRotate,
      required this.refresh,
      required this.paste,
      required this.copy,
      required this.onError})
      : super(key: key);
  final double maxZoom;
  final double minZoom;
  final bool enableControls;
  final CanvasController controller;
  final TransformationController transformationController =
      TransformationController();

  final Function(WidgetMoG) onChilderClicked;
  final void Function(MoGCanvasItem? item) onSelect;
  final void Function(MoGCanvasItem item, Offset pos) onDeviceChange;
  final void Function(MoGCanvasItem item) onRemove;
  final void Function(MoGCanvasItem item) settings;
  final void Function(MoGCanvasItem item) onRotate;
  final void Function(double zoom) onZoom;
  final void Function(FlutterErrorDetails details) onError;
  final void Function(bool value, Offset delta, MoGCanvasItem? item,
      List<MoGCanvasItem> overlaps) onDrag;
  final Function(WidgetMoG) restSelector;
  final Function(String title, String message, TypeAlert typeAlert) alert;
  final Function refresh;
  final Function(dynamic copyData) copy;
  final Function() paste;
  final Color? backgroundColor;
  final Color borderColor;
  final Color? textColor;
  final String? messageToolTip;
  PreferredSize appBar;
  PreferredSize drawer;
  PreferredSize floatingActionButton;
  Offset panOffest = Offset.zero;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    List<MoGCanvasItem> overlaps = [];
    Color scendryColor = context.watch<ScreenInfo>().scendryColor;
    final selectedItem = useState<MoGCanvasItem?>(null);
    bool dragWidget = context.watch<ScreenInfo>().dragWidget;
    bool selectedIsScreen = context.watch<ScreenInfo>().isSelectedIsScreen;
    if (screenSize.width < 800) {
      return Listener(
          behavior: HitTestBehavior.translucent,
          onPointerDown: enableControls
              ? (_) {
                  overlaps = [];
                  selectedItem.value = null;
                  Future.delayed(const Duration(milliseconds: 0))
                      .then((value) => onSelect(selectedItem.value));
                  Provider.of<ScreenInfo>(context, listen: true)
                      .setSelectedIsScreen(true);

                  refresh();
                }
              : null,
          onPointerMove: enableControls
              ? (event) {
                  if (selectedIsScreen) {
                    Future.delayed(const Duration(milliseconds: 0)).then(
                        (value) => onDrag(true, event.delta, null, overlaps));
                    if (selectedItem.value == null) {
                      for (var e in controller.children) {
                        e.setOffset(event.delta / controller.zoom + e.offset);
                      }
                      controller.notifier();
                    }
                  }
                  refresh();
                }
              : null,
          onPointerUp: (_) {
            if (selectedIsScreen) {
              onDrag(false, Offset.zero, null, overlaps);
              refresh();
            }
          },
          child: InteractiveViewer(
              transformationController: transformationController,
              panEnabled: true,
              scaleEnabled: true,
              alignPanAxis: true,
              maxScale: 3,
              minScale: 0.1,
              child: canves(
                  context,
                  selectedItem,
                  overlaps,
                  (e) {
                    restSelector(e);
                  },
                  dragWidget,
                  selectedIsScreen,
                  (title, message, typeAlert) {
                    alert(title, message, typeAlert);
                  },
                  (data) {
                    copy(data);
                  },
                  () {
                    paste();
                  },
                  scendryColor)));
    } else {
      return Listener(
          behavior: HitTestBehavior.translucent,
          onPointerSignal: enableControls
              ? (PointerSignalEvent event) {
                  if (event is PointerScrollEvent) {
                    if (event.scrollDelta.dy > 0) {
                      if (controller.zoom < maxZoom) {
                        controller.setZoom(controller.zoom + 0.1);
                      }
                    } else {
                      if (controller.zoom > minZoom + 0.1) {
                        controller.setZoom(controller.zoom - 0.1);
                      }
                    }
                    onZoom(controller.zoom);
                    controller.notifier();
                  }
                  refresh();
                }
              : null,
          onPointerDown: enableControls
              ? (_) {
                  overlaps = [];
                  selectedItem.value = null;
                  Future.delayed(const Duration(milliseconds: 0))
                      .then((value) => onSelect(selectedItem.value));
                  Provider.of<ScreenInfo>(context, listen: true)
                      .setSelectedIsScreen(true);
                }
              : null,
          onPointerMove: enableControls
              ? (event) {
                  if (selectedIsScreen) {
                    Future.delayed(const Duration(milliseconds: 0)).then(
                        (value) => onDrag(true, event.delta, null, overlaps));
                    if (selectedItem.value == null) {
                      for (var e in controller.children) {
                        e.setOffset(event.delta / controller.zoom + e.offset);
                      }
                      controller.notifier();
                    }
                  }
                  refresh();
                }
              : null,
          onPointerUp: (_) {
            if (selectedIsScreen) {
              onDrag(false, Offset.zero, null, overlaps);
              refresh();
            }
          },
          child: canves(
              context,
              selectedItem,
              overlaps,
              (e) {
                restSelector(e);
                refresh();
              },
              dragWidget,
              selectedIsScreen,
              (title, message, typeAlert) {
                alert(title, message, typeAlert);
              },
              (data) {
                copy(data);
              },
              () {
                paste();
              },
              scendryColor));
    }
  }

  Widget canves(
      BuildContext context,
      dynamic selectedItem,
      dynamic overlaps,
      Function(WidgetMoG w) restSelector,
      bool dragWidget,
      bool selectedIsScreen,
      Function(
    String title,
    String message,
    TypeAlert typeAlert,
  )
          alert,
      Function(dynamic data) copy,
      Function() paste,
      scendryColor) {
    return FractionallySizedBox(
      widthFactor: 3,
      heightFactor: 3,
      child: Container(
        color: backgroundColor,
        child: Stack(
          children: [
            DotMatrixPaper(
              zoomPercent: controller.zoom,
              gridUnitSize: 80,
              originAlignment: Alignment.center,
              background: backgroundColor!,
              style: const DotMatrixStyle.standard().copyWith(
                  divider: DotMatrixDivider.biggerDot,
                  dividerColor: scendryColor),
            ),
            Stack(
              children: controller.children
                  .map(
                    (e) => Center(
                      child: Transform.scale(
                        scale: controller.zoom,
                        child: Transform.translate(
                          offset: e.offset +
                              Offset(0, MediaQuery.of(context).size.height),
                          child: GestureDetector(
                            onTap: () {
                              settings(e);
                            },
                            child: Column(
                              children: [
                                if (enableControls)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 3.0,
                                    ),
                                    child: SizedBox(
                                      width: e.size.width - 6,
                                      child: Listener(
                                        behavior: HitTestBehavior.translucent,
                                        onPointerDown: enableControls
                                            ? (_) {
                                                Future.delayed(const Duration(
                                                        milliseconds: 0))
                                                    .then((value) {
                                                  selectedItem.value = e;
                                                });
                                              }
                                            : null,
                                        onPointerMove: enableControls
                                            ? (event) {
                                                overlaps = controller.children
                                                    .where((el) =>
                                                        el != e &&
                                                        (el.offset & el.size)
                                                            .overlaps(e.offset &
                                                                e.size))
                                                    .toList();
                                                onDrag(true, event.delta, e,
                                                    overlaps);
                                                e.setOffset(event.delta /
                                                        controller.zoom +
                                                    e.offset);
                                                Provider.of<ScreenInfo>(context,
                                                        listen: true)
                                                    .setSelectedIsScreen(true);
                                                // controller.layoutCanvas(e, event.delta);
                                                controller.notifier(true);
                                              }
                                            : null,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Tooltip(
                                                  message: "Screen Name",
                                                  child: Text(
                                                    e.labele,
                                                    style: TextStyle(
                                                        color: textColor,
                                                        fontSize: 14),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    settings(e);
                                                  },
                                                  child: Tooltip(
                                                    message: 'Screen Settings',
                                                    child: Icon(
                                                      Icons.settings,
                                                      color: scendryColor,
                                                      size: 14,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                //  Rotate screen
                                                /*     InkWell(
                                                      onTap: () {
                                                        e.rotateSize();
                                                        onRotate(e);
                                                      },
                                                      child: Tooltip(
                                                        message: 'Rotate',
                                                        child: Icon(
                                                          Icons.crop_rotate_outlined,
                                                          color: textColor,
                                                          size: 14,
                                                        ),
                                                      ),
                                                  ),  */
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                Listener(
                                                  onPointerDown: (event) =>
                                                      onDeviceChange(
                                                          e, event.position),
                                                  child: Tooltip(
                                                    message: "Screen type",
                                                    child: Text(
                                                      e.sizeProfile,
                                                      style: TextStyle(
                                                          color: textColor,
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                InkWell(
                                                  onTap: () => onRemove(e),
                                                  child: const Tooltip(
                                                    message: 'Delete',
                                                    child: Icon(
                                                      Icons.cancel,
                                                      color: Colors.red,
                                                      size: 14,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                else
                                  const SizedBox(
                                    height: 19,
                                  ),
                                WidgetsApp(
                                  color: Colors.black,
                                  debugShowCheckedModeBanner: false,
                                  builder: (_, __) {
                                    ErrorWidget.builder =
                                        (FlutterErrorDetails errorDetails) {
                                      onError(errorDetails);
                                      return Center(
                                          child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(Icons.error,
                                              size: 20, color: Colors.red),
                                          Text(
                                            '${errorDetails.summary} !!',
                                            style: const TextStyle(
                                                color: Colors.red),
                                          ),
                                        ],
                                      ));
                                    };
                                    return Container(
                                        width: e.size.width,
                                        height: e.size.height,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(9),
                                          border: Border.all(
                                            color: borderColor.withOpacity(
                                                selectedItem.value?.key ==
                                                            e.key &&
                                                        enableControls
                                                    ? 1
                                                    : 0),
                                            width: 3,
                                          ),
                                        ),
                                        padding: const EdgeInsets.all(0.5),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: Stack(
                                            children: [
                                              MaterialApp(
                                                debugShowCheckedModeBanner:
                                                    false,
                                                home: Scaffold(
                                                  backgroundColor:
                                                      e.backGroundColor,
                                                  appBar: e.appBar == true
                                                      ? e.appBarWidget
                                                      : null,
                                                  drawer: e.drawer == true
                                                      ? e.drawerWidget
                                                      : null,
                                                  floatingActionButton:
                                                      e.floatingActionButton ==
                                                              true
                                                          ? e.floatingActionButtonWidget
                                                          : null,
                                                  body: Stack(
                                                    children: e.items
                                                        .map(
                                                          (eg) =>
                                                              ResizebleWidget(
                                                            selectWidget: () {
                                                              onChilderClicked(
                                                                eg,
                                                              );
                                                              Provider.of<ScreenInfo>(
                                                                      context,
                                                                      listen:
                                                                          true)
                                                                  .setSelectedIsScreen(
                                                                      false);
                                                            },
                                                            isSelected: context
                                                                    .watch<
                                                                        ScreenInfo>()
                                                                    .selectedWidget ==
                                                                eg,
                                                            size: Size(
                                                                eg.widget[
                                                                    "width"],
                                                                eg.widget[
                                                                    "height"]),
                                                            offset: Offset(
                                                                eg.left,
                                                                eg.top),
                                                            delelte: () {
                                                              Future.delayed(
                                                                  Duration.zero,
                                                                  () {
                                                                e.items
                                                                    .remove(eg);
                                                                Provider.of<ScreenInfo>(
                                                                        context,
                                                                        listen:
                                                                            true)
                                                                    .setrestOverWidget(
                                                                        true);
                                                                Provider.of<ScreenInfo>(
                                                                        context,
                                                                        listen:
                                                                            true)
                                                                    .setpropertiesBar(
                                                                        false);
                                                              });
                                                            },
                                                            copy: () {
                                                              Future.delayed(
                                                                  Duration.zero,
                                                                  () {
                                                                Provider.of<ScreenInfo>(
                                                                        context,
                                                                        listen:
                                                                            true)
                                                                    .setrestOverWidget(
                                                                        true);
                                                                copy(eg.widget);
                                                                Provider.of<ScreenInfo>(
                                                                        context,
                                                                        listen:
                                                                            true)
                                                                    .setrestOverWidget(
                                                                        true);
                                                                alert(
                                                                  "succeeded",
                                                                  "Copy Finshed Successfully Paste To Any Widget",
                                                                  TypeAlert
                                                                      .success,
                                                                );
                                                              });
                                                            },
                                                            paste: () {
                                                              paste();
                                                              Provider.of<ScreenInfo>(
                                                                      context,
                                                                      listen:
                                                                          true)
                                                                  .setrestOverWidget(
                                                                      true);
                                                              alert(
                                                                "succeeded",
                                                                "Paste Finshed Successfully",
                                                                TypeAlert
                                                                    .success,
                                                              );
                                                            },
                                                            cut: () {
                                                              Future.delayed(
                                                                  Duration.zero,
                                                                  () {
                                                                copy(eg.widget);
                                                                Provider.of<ScreenInfo>(
                                                                        context,
                                                                        listen:
                                                                            true)
                                                                    .setrestOverWidget(
                                                                        true);
                                                                alert(
                                                                  "Cut",
                                                                  "Cut Finshed Successfully Paste To Any Widget",
                                                                  TypeAlert
                                                                      .success,
                                                                );
                                                              });
                                                              e.items
                                                                  .remove(eg);
                                                              Provider.of<ScreenInfo>(
                                                                      context,
                                                                      listen:
                                                                          true)
                                                                  .setpropertiesBar(
                                                                      false);
                                                              Future.delayed(
                                                                  Duration.zero,
                                                                  () {
                                                                restSelector(
                                                                    eg);
                                                                onChilderClicked(
                                                                  eg,
                                                                );
                                                              });
                                                            },
                                                            onLeft: (left) {
                                                              Future.delayed(
                                                                  Duration.zero,
                                                                  () {
                                                                Provider.of<ScreenInfo>(
                                                                        context,
                                                                        listen:
                                                                            true)
                                                                    .setSelectedIsScreen(
                                                                        false);
                                                                eg.left = left;

                                                                restSelector(
                                                                    eg);
                                                                onChilderClicked(
                                                                  eg,
                                                                );
                                                              });
                                                            },
                                                            onTop: (top) {
                                                              Future.delayed(
                                                                  Duration.zero,
                                                                  () {
                                                                Provider.of<ScreenInfo>(
                                                                        context,
                                                                        listen:
                                                                            true)
                                                                    .setSelectedIsScreen(
                                                                        false);
                                                                eg.top = top;

                                                                restSelector(
                                                                    eg);
                                                                onChilderClicked(
                                                                  eg,
                                                                );
                                                              });
                                                            },
                                                            onHeight: (height) {
                                                              Future.delayed(
                                                                  Duration.zero,
                                                                  () {
                                                                Provider.of<ScreenInfo>(
                                                                        context,
                                                                        listen:
                                                                            true)
                                                                    .setSelectedIsScreen(
                                                                        false);

                                                                eg.widget[
                                                                        "height"] =
                                                                    height
                                                                        .round();
                                                                restSelector(
                                                                    eg);
                                                                onChilderClicked(
                                                                  eg,
                                                                );
                                                              });
                                                            },
                                                            onWidth: (width) {
                                                              Future.delayed(
                                                                  Duration.zero,
                                                                  () {
                                                                Provider.of<ScreenInfo>(
                                                                        context,
                                                                        listen:
                                                                            true)
                                                                    .setSelectedIsScreen(
                                                                        false);
                                                                eg.widget[
                                                                        "width"] =
                                                                    width
                                                                        .round();

                                                                restSelector(
                                                                    eg);
                                                                onChilderClicked(
                                                                  eg,
                                                                );
                                                              });
                                                            },
                                                            child: ContextMenu(
                                                              select: (e) {
                                                                onChilderClicked(
                                                                  eg,
                                                                );
                                                                Provider.of<ScreenInfo>(
                                                                        context,
                                                                        listen:
                                                                            true)
                                                                    .setSelectedIsScreen(
                                                                        false);
                                                              },
                                                              copy: (eef) {
                                                                Future.delayed(
                                                                    Duration
                                                                        .zero,
                                                                    () {
                                                                  copy(eg
                                                                      .widget);
                                                                  Provider.of<ScreenInfo>(
                                                                          context,
                                                                          listen:
                                                                              true)
                                                                      .setrestOverWidget(
                                                                          true);
                                                                  alert(
                                                                    "succeeded",
                                                                    "Copy Finshed Successfully Paste To Any Widget",
                                                                    TypeAlert
                                                                        .success,
                                                                  );
                                                                });
                                                              },
                                                              paste: (eef) {
                                                                Future.delayed(
                                                                    Duration
                                                                        .zero,
                                                                    () {
                                                                  paste();

                                                                  alert(
                                                                    "succeeded",
                                                                    "Paste Finshed Successfully",
                                                                    TypeAlert
                                                                        .success,
                                                                  );
                                                                });
                                                              },
                                                              delete: (eef) {
                                                                e.items
                                                                    .remove(eg);
                                                                Provider.of<ScreenInfo>(
                                                                        context,
                                                                        listen:
                                                                            true)
                                                                    .setrestOverWidget(
                                                                        true);
                                                                Provider.of<ScreenInfo>(
                                                                        context,
                                                                        listen:
                                                                            true)
                                                                    .setpropertiesBar(
                                                                        false);
                                                              },
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  onChilderClicked(
                                                                    eg,
                                                                  );
                                                                  Provider.of<ScreenInfo>(
                                                                          context,
                                                                          listen:
                                                                              true)
                                                                      .setSelectedIsScreen(
                                                                          false);
                                                                },
                                                                child: eg.build(
                                                                    context),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                        .toList(),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ));
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
