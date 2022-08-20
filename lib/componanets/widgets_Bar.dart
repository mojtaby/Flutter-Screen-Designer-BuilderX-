// ignore_for_file: file_names, must_be_immutable

import 'package:builder/componanets/Box.dart';
import 'package:builder/componanets/bar.dart';

import 'package:builder/systems/canvas_controller.dart';

import 'package:flutter/material.dart';

class LeftBars extends StatefulWidget {
  LeftBars(
      {Key? key,
      required this.add,
      this.treenodewidget,
      this.selectedScreen,
      this.treeNodeVisibilety = true})
      : super(key: key);

  MoGCanvasItem? selectedScreen;
  Widget? treenodewidget;
  Function(String addName, String widget, String child) add;
  bool treeNodeVisibilety;

  @override
  State<LeftBars> createState() => _LeftBarsState();
}

class _LeftBarsState extends State<LeftBars> {
  @override
  Widget build(BuildContext context) {
    return Bar(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 10,
              runSpacing: 10,
              children: [
                AddActionBig(
                  icon: Icons.fit_screen,
                  widgetName: "Screen",
                  addAction: () {
                    widget.add("screen", "", "");
                    setState(() {});
                  },
                ),
                AddActionBig(
                  icon: Icons.text_format,
                  widgetName: "Text",
                  addAction: () {
                    widget.add("widget", "text", "text");
                    setState(() {});
                  },
                ),
                AddActionBig(
                  icon: Icons.add_box,
                  widgetName: "Container",
                  addAction: () {
                    widget.add("widget", "container", "container");
                    setState(() {});
                  },
                ),
                AddActionBig(
                  icon: Icons.center_focus_strong,
                  widgetName: "Center",
                  addAction: () {
                    widget.add("widget", "center", "center");
                    setState(() {});
                  },
                ),
                AddActionBig(
                  icon: Icons.view_column_outlined,
                  widgetName: "Row",
                  addAction: () {
                    widget.add("widget", "row", "row");
                    setState(() {});
                  },
                ),
                AddActionBig(
                  icon: Icons.table_rows_outlined,
                  widgetName: "Column",
                  addAction: () {
                    widget.add("widget", "column", "column");
                    setState(() {});
                  },
                ),
                AddActionBig(
                  icon: Icons.add_box,
                  widgetName: "Stack",
                  addAction: () {
                    widget.add("widget", "stack", "stack");
                    setState(() {});
                  },
                ),
                AddActionBig(
                  icon: Icons.image,
                  widgetName: "Image",
                  addAction: () {
                    widget.add("widget", "image", "image");
                    setState(() {});
                  },
                ),
                AddActionBig(
                  icon: Icons.smart_button_outlined,
                  widgetName: "Button",
                  addAction: () {
                    widget.add("widget", "button", "button");
                    setState(() {});
                  },
                ),
                AddActionBig(
                  icon: Icons.yard,
                  widgetName: "Icon",
                  addAction: () {
                    widget.add("widget", "icon", "icon");
                    setState(() {});
                  },
                ),
                AddActionBig(
                  icon: Icons.check_box,
                  widgetName: "Checkbox",
                  addAction: () {
                    widget.add("widget", "checkbox", "checkbox");
                    setState(() {});
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
