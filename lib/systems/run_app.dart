// ignore_for_file: must_be_immutable

import 'package:builder/colors.dart';

import 'package:builder/componanets/container.dart';
import 'package:builder/componanets/text.dart';

import 'package:builder/systems/canvas_controller.dart';
import 'package:builder/systems/screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LivePreviwe extends StatefulWidget {
  LivePreviwe({super.key, required this.screens, required this.colosDiloge});

  Function colosDiloge;

  List<MoGCanvasItem> screens;
  @override
  State<LivePreviwe> createState() => _LivePreviweState();
}

class _LivePreviweState extends State<LivePreviwe> {
  @override
  Widget build(BuildContext context) {
    int homeScreen = context.watch<ScreenInfo>().homeScreen;
    int screen = context.watch<ScreenInfo>().screenIndex;
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: backGroundColor,
        body: Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            color: backGroundColor,
          ),
          child: Center(
            child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.network(
                          "https://i.postimg.cc/7YJpBY6w/Samsung-Galaxy-S10-Prism-White.png",
                          height: widget.screens[screen].size.height + 30,
                          width: widget.screens[screen].size.width + 40,
                          fit: BoxFit.fill,
                        ),
                        SizedBox(
                          height: widget.screens[screen].size.height,
                          width: widget.screens[screen].size.width,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Scaffold(
                              appBar: widget.screens[screen].appBar
                                  ? widget.screens[screen].appBarWidget
                                  : null,
                              drawer: widget.screens[screen].drawer
                                  ? widget.screens[screen].drawerWidget
                                  : null,
                              floatingActionButton:
                                  widget.screens[screen].floatingActionButton
                                      ? widget.screens[screen]
                                          .floatingActionButtonWidget
                                      : null,
                              backgroundColor:
                                  widget.screens[screen].backGroundColor,
                              body: Stack(
                                  children: widget.screens[screen].items
                                      .map((e) => e.build(context))
                                      .toList()),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: GestureDetector(
                      onTap: () {
                        Provider.of<ScreenInfo>(context)
                            .changerUnableOnClick(false);
                        Provider.of<ScreenInfo>(context)
                            .changeScreen(homeScreen);
                        widget.colosDiloge();
                      },
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: SizedBox(
                          height: 40,
                          child: ContainerForLessCode(
                            setHight: true,
                            color: codeBoxBoder,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextForLessCode(
                                  value: "Back",
                                  color: barsColor,
                                  size: 25,
                                ),
                                Icon(
                                  Icons.arrow_back_ios_new_outlined,
                                  color: barsColor,
                                  size: 30,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
