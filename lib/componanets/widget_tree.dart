// ignore_for_file: must_be_immutable

import 'package:builder/componanets/bar.dart';
import 'package:builder/systems/screen.dart';
import 'package:builder/systems/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_treeview/flutter_treeview.dart';
import 'package:provider/provider.dart';

class WidgetTree extends StatefulWidget {
  WidgetTree({super.key, required this.selectNode, required this.back});
  Function() back;
  Function(WidgetMoG? widget) selectNode;

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  TreeViewController _treeViewController = TreeViewController();
  @override
  Widget build(BuildContext context) {
    Color scendryColor = context.watch<ScreenInfo>().scendryColor;

    List<Node<WidgetMoG>> nodes =
        context.watch<ScreenInfo>().screen.items.map((e) => nodee(e)).toList();
    _treeViewController = TreeViewController(
      children: nodes,
    );
    TreeViewTheme treeViewTheme = TreeViewTheme(
      expanderTheme: ExpanderThemeData(
          type: ExpanderType.arrow,
          modifier: ExpanderModifier.circleFilled,
          position: ExpanderPosition.start,
          // color: Colors.grey.shade800,
          size: 16,
          color: scendryColor),
      labelStyle: TextStyle(
        color: scendryColor,
        fontSize: 12,
        letterSpacing: 0.3,
      ),
      parentLabelStyle: TextStyle(
        fontSize: 12,
        letterSpacing: 0.1,
        fontWeight: FontWeight.w800,
        color: scendryColor,
      ),
      iconTheme: IconThemeData(
        size: 15,
        color: scendryColor,
      ),
    );
    return Bar(
        back: () {
          widget.back();
        },
        child: SizedBox(
            height: 600,
            child: TreeView(
              theme: treeViewTheme,
              allowParentSelect: true,
              supportParentDoubleTap: true,
              controller: _treeViewController,
              onNodeTap: (key) {
                _treeViewController =
                    _treeViewController.copyWith(selectedKey: key);
                Node<WidgetMoG>? selected = _treeViewController.getNode(key);
                widget.selectNode(selected!.data);
              },
            )));
  }

  Node<WidgetMoG> nodee(WidgetMoG e) {
    if (e.children.isNotEmpty) {
      return Node(
          label: " ${e.widgetName}(${e.type})",
          data: e,
          key: e.keye.toString(),
          parent: true,
          children: e.children.map((e) => nodee(e)).toList());
    } else if (e.child != null) {
      return Node(
          label: " ${e.widgetName}(${e.type})",
          data: e,
          key: e.keye.toString(),
          parent: true,
          children: [nodee(e.child!)]);
    } else {
      return Node(
        label: " ${e.widgetName}(${e.type})",
        data: e,
        parent: false,
        key: e.keye.toString(),
      );
    }
  }
}
