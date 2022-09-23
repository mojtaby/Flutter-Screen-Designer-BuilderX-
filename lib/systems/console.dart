// ignore_for_file: must_be_immutable

import 'package:builder/colors.dart';
import 'package:builder/componanets/text.dart';
import 'package:builder/systems/screen.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Console extends StatefulWidget {
  Console(
      {super.key, required this.logs, required this.copy, required this.rest});
  List<String> logs;
  Function() copy;
  Function() rest;
  @override
  State<Console> createState() => _ConsoleState();
}

class _ConsoleState extends State<Console> {
  @override
  Widget build(BuildContext context) {
    Color backGroundColor = context.watch<ScreenInfo>().backGroundColor;
    Color scendryColor = context.watch<ScreenInfo>().scendryColor;
    return Container(
      height: 300,
      width: double.infinity,
      color: backGroundColor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextForLessCode(
                    value: "Debug Console",
                    color: scendryColor,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    width: 100,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            widget.copy();
                          },
                          child: Icon(
                            Icons.copy_outlined,
                            color: scendryColor,
                            size: 20,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            widget.rest();
                          },
                          child: Icon(
                            Icons.delete_outlined,
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
            Divider(
              indent: 5,
              endIndent: 5,
              color: scendryColor,
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                child: SingleChildScrollView(
                  controller: ScrollController(),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: context
                          .watch<ScreenInfo>()
                          .console
                          .map((e) => TextForLessCode(
                                value: e,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ))
                          .toList()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
