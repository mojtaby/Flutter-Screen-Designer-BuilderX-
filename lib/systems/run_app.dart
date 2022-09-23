// ignore_for_file: must_be_immutable

import 'dart:typed_data';

import 'package:screenshot/screenshot.dart';
import 'package:builder/systems/console.dart';
import 'package:device_frame/device_frame.dart';
import 'package:file_saver/file_saver.dart';
import 'package:builder/componanets/container.dart';
import 'package:builder/componanets/text.dart';

import 'package:builder/systems/canvas_controller.dart';

import 'package:builder/systems/screen.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../componanets/device_frame.dart';

class LivePreviwe extends StatefulWidget {
  LivePreviwe({
    super.key,
    required this.screens,
    required this.colosDiloge,
  });

  Function colosDiloge;

  List<MoGCanvasItem> screens;

  @override
  State<LivePreviwe> createState() => _LivePreviweState();
}

class _LivePreviweState extends State<LivePreviwe> {
  DeviceInfo? devaceName;
  ScreenshotController screenshotController = ScreenshotController();
  @override
  void initState() {
    devaceName =
        widget.screens[context.watch<ScreenInfo>().homeScreen].deviceName;
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int homeScreen = context.watch<ScreenInfo>().homeScreen;
    int screen = context.watch<ScreenInfo>().screenIndex;
    List<String> logs = context.watch<ScreenInfo>().console;
    Size size = MediaQuery.of(context).size;
    Color scendryColor = context.watch<ScreenInfo>().scendryColor;
    Color backGroundColor = context.watch<ScreenInfo>().backGroundColor;

    return MaterialApp(
      useInheritedMediaQuery: true,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: backGroundColor,
        body: Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            color: backGroundColor,
          ),
          child: Stack(
            children: [
              Center(
                child: SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: Center(
                    child: Stack(children: [
                      Align(
                        alignment: Alignment.center,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.all(20),
                              child: Screenshot(
                                controller: screenshotController,
                                child: DeviceFrame(
                                  device:
                                      context.watch<ScreenInfo>().devaceName,
                                  screen: MaterialApp(
                                    debugShowCheckedModeBanner: false,
                                    home: Scaffold(
                                      appBar: widget.screens[screen].appBar
                                          ? widget.screens[screen].appBarWidget
                                          : null,
                                      drawer: widget.screens[screen].drawer
                                          ? widget.screens[screen].drawerWidget
                                          : null,
                                      floatingActionButton: widget
                                              .screens[screen]
                                              .floatingActionButton
                                          ? widget.screens[screen]
                                              .floatingActionButtonWidget
                                          : null,
                                      backgroundColor: widget
                                          .screens[screen].backGroundColor,
                                      body: Stack(
                                          children: widget.screens[screen].items
                                              .map((e) {
                                        return Positioned(
                                            top: e.top,
                                            left: e.left,
                                            child: GestureDetector(
                                                onTap: () {
                                                  setState(() {});
                                                },
                                                child: e.build(context)));
                                      }).toList()),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 400,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Provider.of<ScreenInfo>(context, listen: true)
                                    .changerUnableOnClick(false);
                                Provider.of<ScreenInfo>(context, listen: true)
                                    .changeScreen(homeScreen);
                                Provider.of<ScreenInfo>(context, listen: true)
                                    .setDevaceName(
                                        widget.screens[homeScreen].deviceName!);
                                widget.colosDiloge();
                              },
                              child: ContainerForLessCode(
                                width: 75,
                                height: 40,
                                setHight: false,
                                color: scendryColor,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    TextForLessCode(
                                      value: "Back",
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                    const Icon(
                                      Icons.arrow_back_ios_new_outlined,
                                      color: Colors.white,
                                      size: 13,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => Dialog(
                                          insetPadding: EdgeInsets.all(200),
                                          backgroundColor: Colors.transparent,
                                          child: Console(
                                              logs: logs,
                                              copy: () {
                                                FlutterClipboard.copy(
                                                    logs.toString());
                                              },
                                              rest: () {
                                                Provider.of<ScreenInfo>(context,
                                                        listen: true)
                                                    .restConsole();
                                              }),
                                        ));
                              },
                              child: ContainerForLessCode(
                                width: 90,
                                height: 40,
                                setHight: false,
                                color: scendryColor,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    TextForLessCode(
                                      value: "Console",
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                    const Icon(
                                      Icons.code,
                                      color: Colors.white,
                                      size: 13,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (c) {
                                      return Dialog(
                                        backgroundColor: Colors.transparent,
                                        child: DeviceFrameSelecter(info: (e) {
                                          Provider.of<ScreenInfo>(context,
                                                  listen: true)
                                              .setDevaceName(e);
                                        }),
                                      );
                                    });
                              },
                              child: ContainerForLessCode(
                                width: 90,
                                height: 40,
                                setHight: false,
                                color: scendryColor,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    TextForLessCode(
                                      value: "Device",
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                    const Icon(
                                      Icons.code,
                                      color: Colors.white,
                                      size: 13,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                screenshotController.capture().then((value) {
                                  FileSaver.instance.saveFile(
                                      widget.screens[screen].labele,
                                      value!,
                                      "png",
                                      mimeType: MimeType.PNG);
                                });
                              },
                              child: ContainerForLessCode(
                                width: 90,
                                height: 40,
                                setHight: false,
                                color: scendryColor,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    TextForLessCode(
                                      value: "Screenshot",
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                    const Icon(
                                      Icons.screenshot_monitor_outlined,
                                      color: Colors.white,
                                      size: 13,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
