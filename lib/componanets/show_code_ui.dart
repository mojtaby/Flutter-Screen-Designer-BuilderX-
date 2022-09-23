import 'package:builder/colors.dart';
import 'package:builder/componanets/container.dart';
import 'package:builder/componanets/text.dart';
import 'package:builder/systems/canvas_controller.dart';
import 'package:builder/systems/code_compreser.dart';
import 'package:builder/systems/screen.dart';
import 'package:clipboard/clipboard.dart';

import 'package:device_frame/device_frame.dart';
import 'package:download/download.dart';
import 'package:flutter/material.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';
import 'package:provider/provider.dart';

import '../systems/code_genrater.dart';

class CodeShowUi extends StatefulWidget {
  CodeShowUi({super.key, required this.controller, required this.getCode});
  CanvasController controller;

  Function(dynamic, dynamic) getCode;
  @override
  State<CodeShowUi> createState() => _CodeShowUiState();
}

class _CodeShowUiState extends State<CodeShowUi> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    String code = context.watch<ScreenInfo>().screenCode;

    DeviceInfo deviceInfo = context.watch<ScreenInfo>().devaceName;
    Color scendryColor = context.watch<ScreenInfo>().scendryColor;

    Color firstColor = context.watch<ScreenInfo>().firstColor;

    if (screenSize.width < 600) {
      return Dialog(
        backgroundColor: scendryColor.withOpacity(0),
        child: Container(
          decoration: BoxDecoration(
              color: scendryColor,
              border: Border.all(color: scendryColor, width: 1),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 600,
              width: 450,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                      height: 60,
                      child: screenUi(code, deviceInfo, scendryColor)),
                  Center(child: codeUi(code, const Size(260, 500), 400))
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return Dialog(
        backgroundColor: scendryColor.withOpacity(0),
        child: Container(
          decoration: BoxDecoration(
              color: firstColor,
              border: Border.all(color: scendryColor, width: 1),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 500,
              width: 700,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SingleChildScrollView(
                      controller: ScrollController(),
                      child: screenUi(code, deviceInfo, scendryColor)),
                  SizedBox(
                      width: 400,
                      height: 500,
                      child: codeUi(code, const Size(400, 500), 500)),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

  Widget screenUi(String code, DeviceInfo deviceInfo, scendryColor) {
    return SingleChildScrollView(
      controller: ScrollController(),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: widget.controller.children
              .map((e) => GestureDetector(
                    onTap: () {
                      widget.getCode(widget.controller.children.indexOf(e),
                          e.screenVariables);
                      Provider.of<ScreenInfo>(context, listen: true)
                          .setScreenCode(
                              CodeGenerator().generatorMain(
                                e.items
                                    .map((e) =>
                                        Compres().cmpe(e, context, deviceInfo))
                                    .toList(),
                                widget
                                    .controller
                                    .children[
                                        widget.controller.children.indexOf(e)]
                                    .screenVariables
                                    .isNotEmpty,
                                e,
                                e.screenVariables,
                              ),
                              e.screenVariables);
                    },
                    child: ContainerForLessCode(
                      setHight: false,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextForLessCode(
                              value: e.labele,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            width: 60,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    FlutterClipboard.copy(code);
                                  },
                                  child: Icon(
                                    Icons.copy_outlined,
                                    color: scendryColor,
                                    size: 20,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    download(
                                        Stream.fromIterable(code.codeUnits),
                                        '${e.labele.toString()}.dart');
                                  },
                                  child: Icon(
                                    Icons.file_download_outlined,
                                    color: scendryColor,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ))
              .toList()),
    );
  }

  Widget codeUi(String code, Size size, int pansize) {
    return ContainerForLessCode(
      setHight: false,
      width: size.width,
      height: size.height,
      child: SyntaxView(
        code: context.watch<ScreenInfo>().screenCode,
        // Code text
        syntax: Syntax.DART, // Language
        syntaxTheme: SyntaxTheme.vscodeDark(), // Theme
        fontSize: 15.0, // Font size
        withZoom: true, // Enable/Disable zoom icon controls
        withLinesCount: true, // Enable/Disable line number
        expanded: true,
      ),
    );
  }
}
