// ignore_for_file: deprecated_member_use, must_be_immutable, prefer_typing_uninitialized_variables, must_call_super

import 'dart:math';

import 'package:builder/colors.dart';

import 'package:builder/componanets/code_box.dart';
import 'package:builder/componanets/container.dart';
import 'package:builder/componanets/node.dart';
import 'package:builder/componanets/text.dart';
import 'package:builder/systems/canvas_controller.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:graphview/GraphView.dart';

import 'package:flutter/material.dart';

import '../componanets/code_box.dart';

class CodePanle extends StatefulWidget {
  CodePanle({
    Key? key,
    this.jsonBlock = const {},
    required this.jsonSeter,
    required this.edgeSeter,
    required this.nodeDeleter,
    required this.setAction,
    required this.controller,
  }) : super(key: key);
  var jsonBlock;
  Function(dynamic)? edgeSeter;
  Function(dynamic, dynamic)? jsonSeter;
  Function(dynamic)? nodeDeleter;
  Function(dynamic action, String type)? setAction;
  CanvasController controller;

  @override
  CodePanleState createState() => CodePanleState();
}

class CodePanleState extends State<CodePanle> {
  Random r = Random();

  bool editeBar = false;
  int? selectedNodeId = 0;
  String? nodeType = "";
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
      width: 600,
      color: backGroundColor,
      child: Row(
        children: [
          Container(
            padding:
                const EdgeInsets.only(left: 60, top: 10, bottom: 10, right: 10),
            height: double.infinity,
            width: 300,
            child: InteractiveViewer(
                constrained: false,
                scaleEnabled: false,
                child: GraphView(
                  animated: true,
                  graph: graph,
                  paint: Paint()
                    ..color = textFieldColor
                    ..strokeWidth = 3
                    ..style = PaintingStyle.stroke,
                  algorithm: BuchheimWalkerAlgorithm(
                      builder, TreeEdgeRenderer(builder)),
                  builder: (Node node) {
                    var a = node.key!.value as int;

                    var nodes = widget.jsonBlock['nodes'];

                    var nodeValue =
                        nodes!.firstWhere((element) => element['id'] == a);
                    return NodeBlock(
                        selected: selectedNodeId == a ? true : false,
                        blockMune: blocksMune(a, context),
                        a: a,
                        node: node,
                        nodeName: nodeValue["label"].toString(),
                        deletNode: (nodeId) {
                          if (nodeValue["label"] != "On click" &&
                              nodeValue["label"] != "Function{") {
                            graph.removeNode(nodeId);
                            widget.nodeDeleter!(
                              {"id": a, "label": nodeValue["label"].toString()},
                            );
                            setState(() {});
                          }
                        },
                        openBlockEditor: (nodee, nodeName) {
                          if (nodeName != "On click" &&
                              nodeName != "Function{") {
                            selectedNodeId = nodee;
                            nodeType = nodeName;
                            editeBar = !editeBar;
                            setState(() {});
                          }
                        }).build(context);
                  },
                )),
          ),
          Visibility(
            visible: editeBar,
            child: codeBlockEditor(),
          ),
        ],
      ),
    ));
  }

  Widget codeBlockEditor() {
    return Container(
      padding: const EdgeInsets.all(10),
      color: barsColor,
      height: double.infinity,
      width: 300,
      child: Wrap(
        runSpacing: 10,
        spacing: 10,
        direction: Axis.vertical,
        children: propertes(),
      ),
    );
  }

  List<Widget> propertes() {
    if (nodeType == "Navigate") {
      return [
        ContainerForLessCode(
          child: DropDown(
              dropDownType: DropDownType.Button,
              icon: Icon(
                Icons.arrow_drop_down,
                color: textFieldColor,
                size: 30,
              ),
              showUnderline: false,
              hint: TextForLessCode(
                value: "Screen name",
              ),
              isExpanded: true,
              items: widget.controller.children.map((e) => e.labele).toList(),
              onChanged: (e) {
                widget.setAction!(e, "nav");
              }),
        ),
      ];
    } else {
      return [];
    }
  }

  final Graph graph = Graph();
  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();

  @override
  void initState() {
    widget.jsonBlock["edges"]!.forEach((element) {
      var fromNodeId = element['from'];
      var toNodeId = element['to'];
      graph.addEdge(Node.Id(fromNodeId), Node.Id(toNodeId));
    });

    builder
      ..siblingSeparation = (100)
      ..levelSeparation = (100)
      ..subtreeSeparation = (100)
      ..orientation = (BuchheimWalkerConfiguration.DEFAULT_ORIENTATION);
  }

  void add(dynamic dialogContext, int a, String actionName) {
    widget.jsonSeter!({"id": a + 1, "label": actionName}, a);
    widget.edgeSeter!({"from": a, "to": a + 1});

    graph.addEdge(Node.Id(a), Node.Id(a + 1));
    Navigator.pop(dialogContext);
    setState(() {});
  }

  Widget blocksMune(int a, dynamic dialogContext) {
    return Dialog(
      backgroundColor: barsColor,
      child: SizedBox(
        height: 450,
        width: 450,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CodeBox(
                      name: "Navigate",
                      add: () {
                        add(dialogContext, a, "Navigate");

                        setState(() {});
                      },
                    ),
                    CodeBox(
                      name: "Open App Bar",
                      add: () {
                        add(dialogContext, a, "App Bar");
                      },
                    ),
                  ]),
            ],
          ),
        ),
      ),
    );
  }
}
