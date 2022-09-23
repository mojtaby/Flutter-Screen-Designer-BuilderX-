import 'package:builder/colors.dart';
import 'package:builder/componanets/text.dart';
import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import 'package:provider/provider.dart';

import '../systems/screen.dart';

class NodeBlock {
  NodeBlock(
      {required this.blockMune,
      required this.nodeName,
      required this.a,
      this.selected,
      this.deletNode,
      this.node,
      this.dilog = false,
      this.openBlockEditor});
  bool dilog;
  int a;
  Node? node;
  Widget blockMune;
  String nodeName;
  Function(int id, String nodeName)? openBlockEditor;
  Function(Node id)? deletNode;
  bool? selected;

  Widget build(BuildContext context) {
    Color scendryColor = context.watch<ScreenInfo>().scendryColor;

    return GestureDetector(
      onTap: () {
        openBlockEditor!(a, nodeName);
      },
      child: Container(
        margin: dilog ? EdgeInsets.all(0) : EdgeInsets.all(25),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
              color: selected == true ? scendryColor : Colors.blue, width: 3),
          boxShadow: const [
            BoxShadow(color: Colors.blue, spreadRadius: 1),
          ],
        ),
        child: getNodeText(nodeName, context),
      ),
    );
  }

  Widget getNodeText(String name, BuildContext context) {
    return box(name, context);
  }

  Widget box(String value, BuildContext context) {
    Color scendryColor = context.watch<ScreenInfo>().scendryColor;
    Color backGroundColor = context.watch<ScreenInfo>().backGroundColor;
    Color firstColor = context.watch<ScreenInfo>().firstColor;
    Color textColor = context.watch<ScreenInfo>().textColor;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            deletNode!(node!);
          },
          child: const Icon(
            Icons.delete_outline,
            color: Colors.red,
            size: 20,
          ),
        ),
        GestureDetector(
          onTap: () {
            openBlockEditor!(a, nodeName);
          },
          child: TextForLessCode(
            value: value,
            color: Colors.white,
          ),
        ),
        GestureDetector(
          onTap: () {
            showDialog(
                context: context,
                builder: (context) {
                  return blockMune;
                });
          },
          child: Icon(
            Icons.add,
            color: scendryColor,
            size: 20,
          ),
        )
      ],
    );
  }
}
