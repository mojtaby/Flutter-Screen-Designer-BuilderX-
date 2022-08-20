// ignore_for_file: must_be_immutable

import 'package:builder/componanets/text.dart';

import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';

import 'package:builder/componanets/bar.dart';

import 'package:builder/systems/screen.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class WidgetTree extends StatefulWidget {
  WidgetTree({super.key});
  TreeController treeViewController = TreeController();
  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return Bar(
        child: Column(
      children: [
        TreeView(
            indent: 5,
            nodes: context
                .watch<ScreenInfo>()
                .screen
                .items
                .map((e) => TreeNode(
                    content: TextForLessCode(
                        value: e.type[0].toUpperCase() +
                            e.type.substring(1).toLowerCase()),
                    children: e.type == "row" ||
                            e.type == "stack" ||
                            e.type == "column"
                        ? e.children
                            .map((e) => TreeNode(
                                content: TextForLessCode(
                                    value: e.type[0].toUpperCase() +
                                        e.type.substring(1).toLowerCase()),
                                children:
                                    e.children.map((e) => TreeNode()).toList()))
                            .toList()
                        : e.child != null
                            ? [
                                TreeNode(
                                    content: TextForLessCode(
                                      value: e.child!.type[0].toUpperCase() +
                                          e.child!.type
                                              .substring(1)
                                              .toLowerCase(),
                                    ),
                                    children: [])
                              ]
                            : []))
                .toList()),
      ],
    ));
  }
}
