// ignore_for_file: file_names, must_be_immutable

import 'package:builder/componanets/Box.dart';
import 'package:builder/componanets/bar.dart';

import 'package:builder/systems/canvas_controller.dart';

import 'package:flutter/material.dart';

class LeftBars extends StatelessWidget {
  LeftBars(
      {Key? key,
      required this.back,
      required this.add,
      this.treenodewidget,
      this.selectedScreen,
      this.treeNodeVisibilety = true})
      : super(key: key);
  MoGCanvasItem? selectedScreen;
  Widget? treenodewidget;
  Function(String addName, String widget, String child) add;
  bool treeNodeVisibilety;
  Function() back;
  @override
  Widget build(BuildContext context) {
    return Bar(
      back: () {
        back();
      },
      child: SingleChildScrollView(
        controller: ScrollController(),
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
                    add("screen", "", "");
                  },
                ),
                AddActionBig(
                  icon: Icons.text_format,
                  widgetName: "Text",
                  addAction: () {
                    add("widget", "text", "text");
                  },
                ),
                AddActionBig(
                  icon: Icons.add_box,
                  widgetName: "Container",
                  addAction: () {
                    add("widget", "container", "container");
                  },
                ),
                AddActionBig(
                  icon: Icons.center_focus_strong,
                  widgetName: "Center",
                  addAction: () {
                    add("widget", "center", "center");
                  },
                ),
                AddActionBig(
                  icon: Icons.padding_outlined,
                  widgetName: "Padding",
                  addAction: () {
                    add("widget", "padding", "padding");
                  },
                ),
                AddActionBig(
                  icon: Icons.view_column_outlined,
                  widgetName: "Row",
                  addAction: () {
                    add("widget", "row", "row");
                  },
                ),
                AddActionBig(
                  icon: Icons.table_rows_outlined,
                  widgetName: "Column",
                  addAction: () {
                    add("widget", "column", "column");
                  },
                ),
                AddActionBig(
                  icon: Icons.add_box,
                  widgetName: "Stack",
                  addAction: () {
                    add("widget", "stack", "stack");
                  },
                ),
                AddActionBig(
                  icon: Icons.image,
                  widgetName: "Image",
                  addAction: () {
                    add("widget", "image", "image");
                  },
                ),
                AddActionBig(
                  icon: Icons.smart_button_outlined,
                  widgetName: "Button",
                  addAction: () {
                    add("widget", "button", "button");
                  },
                ),
                AddActionBig(
                  icon: Icons.yard,
                  widgetName: "Icon",
                  addAction: () {
                    add("widget", "icon", "icon");
                  },
                ),
                /*  AddActionBig(
                  icon: Icons.horizontal_rule_rounded,
                  widgetName: "Divider",
                  addAction: () {
                    add("widget", "divider", "divider");
                  },
                ),*/
                AddActionBig(
                  icon: Icons.crop_outlined,
                  widgetName: "SafeArea",
                  addAction: () {
                    add("widget", "safeArea", "safeArea");
                  },
                ),
                AddActionBig(
                  icon: Icons.crop_free,
                  widgetName: "SizedBox",
                  addAction: () {
                    add("widget", "sizedBox", "sizedBox");
                  },
                ),
                /* AddActionBig(
                  icon: Icons.check_box,
                  widgetName: "Checkbox",
                  addAction: () {
                    add("widget", "checkbox", "checkbox");
                  },
              ), */
              ], //
            ),
          ],
        ),
      ),
    );
  }
}
