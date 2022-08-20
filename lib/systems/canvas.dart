// ignore_for_file: must_be_immutable

import 'package:builder/systems/widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
      required this.onZoom,
      required this.onRemove,
      required this.settings,
      required this.onRotate,
      required this.onError})
      : super(key: key);
  final double maxZoom;
  final double minZoom;
  final bool enableControls;
  final CanvasController controller;

  final Function(WidgetMoG, int) onChilderClicked;
  final void Function(MoGCanvasItem? item) onSelect;
  final void Function(MoGCanvasItem item, Offset pos) onDeviceChange;
  final void Function(MoGCanvasItem item) onRemove;
  final void Function(MoGCanvasItem item) settings;
  final void Function(MoGCanvasItem item) onRotate;
  final void Function(double zoom) onZoom;
  final void Function(FlutterErrorDetails details) onError;
  final void Function(bool value, Offset delta, MoGCanvasItem? item,
      List<MoGCanvasItem> overlaps) onDrag;
  final Function() restSelector;
  final Color? backgroundColor;
  final Color borderColor;
  final Color? textColor;
  final String? messageToolTip;
  dynamic appBar;
  Drawer drawer;
  FloatingActionButton floatingActionButton;

  @override
  Widget build(BuildContext context) {
    List<MoGCanvasItem> overlaps = [];
    final selectedItem = useState<MoGCanvasItem?>(null);
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
            }
          : null,
      onPointerDown: enableControls
          ? (_) {
              overlaps = [];
              selectedItem.value = null;
              Future.delayed(const Duration(milliseconds: 0))
                  .then((value) => onSelect(selectedItem.value));
            }
          : null,
      onPointerMove: enableControls
          ? (event) {
              Future.delayed(const Duration(milliseconds: 0))
                  .then((value) => onDrag(true, event.delta, null, overlaps));
              if (selectedItem.value == null) {
                for (var e in controller.children) {
                  e.setOffset(event.delta / controller.zoom + e.offset);
                }
                controller.notifier();
              }
            }
          : null,
      onPointerUp: (_) {
        onDrag(false, Offset.zero, null, overlaps);
      },
      child: FractionallySizedBox(
        widthFactor: 3,
        heightFactor: 3,
        child: Container(
          color: backgroundColor,
          child: Stack(
            children: controller.children
                .map(
                  (e) => Center(
                    child: Transform.scale(
                      scale: controller.zoom,
                      child: Transform.translate(
                        offset: e.offset +
                            Offset(0, MediaQuery.of(context).size.height),
                        child: Listener(
                          behavior: HitTestBehavior.translucent,
                          onPointerDown: enableControls
                              ? (_) {
                                  Future.delayed(
                                          const Duration(milliseconds: 0))
                                      .then((value) => selectedItem.value = e);
                                }
                              : null,
                          onPointerMove: enableControls
                              ? (event) {
                                  overlaps = controller.children
                                      .where((el) =>
                                          el != e &&
                                          (el.offset & el.size)
                                              .overlaps(e.offset & e.size))
                                      .toList();
                                  onDrag(true, event.delta, e, overlaps);
                                  e.setOffset(
                                      event.delta / controller.zoom + e.offset);
                                  // controller.layoutCanvas(e, event.delta);
                                  controller.notifier(true);
                                }
                              : null,
                          child: Column(
                            children: [
                              if (enableControls)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 3.0,
                                  ),
                                  child: SizedBox(
                                    width: e.size.width - 6,
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
                                              child: const Tooltip(
                                                message: 'Screen Settings',
                                                child: Icon(
                                                  Icons.settings,
                                                  color: Colors.white,
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
                                              child: Tooltip(
                                                message: 'Delete',
                                                child: Icon(
                                                  Icons.cancel,
                                                  color: textColor,
                                                  size: 14,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
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
                                      border: Border.all(
                                        color: borderColor.withOpacity(
                                            selectedItem.value?.key == e.key &&
                                                    enableControls
                                                ? 1
                                                : 0),
                                        width: 3,
                                      ),
                                    ),
                                    padding: const EdgeInsets.all(0.5),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: MaterialApp(
                                        debugShowCheckedModeBanner: false,
                                        home: Scaffold(
                                          backgroundColor: e.backGroundColor,
                                          appBar: e.appBar == true
                                              ? e.appBarWidget
                                              : null,
                                          drawer: e.drawer == true
                                              ? e.drawerWidget
                                              : null,
                                          floatingActionButton:
                                              e.floatingActionButton == true
                                                  ? e.floatingActionButtonWidget
                                                  : null,
                                          body: Stack(
                                            children: e.items
                                                .map((eg) => GestureDetector(
                                                    onTap: () {
                                                      onChilderClicked(
                                                        eg,
                                                        e.items[eg.keye].keye,
                                                      );
                                                    },
                                                    child: eg.build(context)))
                                                .toList(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
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
        ),
      ),
    );
  }
}
