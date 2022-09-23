// ignore_for_file: deprecated_member_use, must_be_immutable, prefer_typing_uninitialized_variables, must_call_super

import 'dart:math';

import 'package:builder/colors.dart';
import 'package:builder/componanets/button.dart';

import 'package:builder/componanets/code_box.dart';
import 'package:builder/componanets/container.dart';
import 'package:builder/componanets/dropdown.dart';
import 'package:builder/componanets/node.dart';
import 'package:builder/componanets/text.dart';

import 'package:builder/systems/canvas_controller.dart';
import 'package:builder/systems/screen.dart';

import 'package:graphview/GraphView.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    required this.screen,
    required this.edgetEditor,
  }) : super(key: key);
  var jsonBlock;
  MoGCanvasItem screen;
  Function(dynamic)? edgeSeter;
  Function(dynamic, dynamic, dynamic)? edgetEditor;
  Function(dynamic, dynamic)? jsonSeter;
  Function(dynamic)? nodeDeleter;
  Function(dynamic action, String type, bool fromVar)? setAction;
  List<MoGCanvasItem> controller;

  @override
  CodePanleState createState() => CodePanleState();
}

class CodePanleState extends State<CodePanle> {
  Random r = Random();
  String value = "";
  bool editeBar = false;
  int? selectedNodeId = 0;
  String? nodeType = "";
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    Color scendryColor = context.watch<ScreenInfo>().scendryColor;
    Color backGroundColor = context.watch<ScreenInfo>().backGroundColor;
    Color firstColor = context.watch<ScreenInfo>().firstColor;
    Color textColor = context.watch<ScreenInfo>().textColor;
    if (screenSize.width < 600) {
      return Material(
          child: Container(
        width: 600,
        height: 700,
        color: backGroundColor,
        child: graph(true, scendryColor, backGroundColor, firstColor),
      ));
    } else {
      return Material(
          child: Container(
              width: 400,
              height: 700,
              color: backGroundColor,
              child: Row(
                children: [
                  graph(false, scendryColor, backGroundColor, firstColor),
                  codeBlockEditor(
                      false, scendryColor, backGroundColor, firstColor)
                ],
              )));
    }
  }

  Widget graph(bool showDilg, scendryColor, backGroundColor, firstColor) {
    return Container(
      padding: showDilg
          ? EdgeInsets.only(top: 10, bottom: 10, right: 10)
          : EdgeInsets.only(left: 60, top: 10, bottom: 10, right: 10),
      width: 300,
      height: showDilg ? 500 : 800,
      child: SingleChildScrollView(
          controller: ScrollController(),
          child: GraphView(
            animated: true,
            graph: graphe,
            paint: Paint()
              ..color = scendryColor
              ..strokeWidth = 3
              ..style = PaintingStyle.stroke,
            algorithm:
                BuchheimWalkerAlgorithm(builder, TreeEdgeRenderer(builder)),
            builder: (Node node) {
              var a = node.key!.value as int;
              var nodes = widget.jsonBlock['nodes'];
              var nodeValue =
                  nodes!.firstWhere((element) => element['id'] == a);
              return NodeBlock(
                  selected: selectedNodeId == a ? true : false,
                  blockMune: blocksMune(a, context, backGroundColor),
                  a: a,
                  node: node,
                  nodeName: nodeValue["label"].toString(),
                  deletNode: (nodeId) {
                    if (nodeValue["label"] != "On click" &&
                        nodeValue["label"] != "Function{") {
                      if (graphe.nodes.length == a) {
                        graphe.removeNode(nodeId);
                        widget.nodeDeleter!(
                          nodeValue,
                        );
                      } else {
                        widget.edgetEditor!(nodeValue, a - 1, a + 1);
                        graphe.addEdgeS(Edge(graphe.getNodeUsingId(a - 1),
                            graphe.getNodeUsingId(a + 1)));
                        widget.edgetEditor!(
                            nodeValue,
                            graphe.getNodeUsingId(a - 1),
                            graphe.getNodeUsingId(a + 1));
                        graphe.removeNode(nodeId);
                        widget.nodeDeleter!(
                          nodeValue,
                        );
                      }

                      editeBar = false;
                      setState(() {});
                    }
                  },
                  openBlockEditor: (nodee, nodeName) {
                    if (nodeName != "On click" && nodeName != "Function{") {
                      if (showDilg) {
                        selectedNodeId = nodee;
                        nodeType = nodeName;
                        editeBar = true;
                        setState(() {});
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              backgroundColor: firstColor,
                              child: ContainerForLessCode(
                                setHight: false,
                                height: 500,
                                width: 400,
                                child: codeBlockEditor(
                                    true, firstColor, firstColor, firstColor),
                              ),
                            );
                          },
                        );
                      } else {
                        selectedNodeId = nodee;
                        nodeType = nodeName;
                        editeBar = !editeBar;
                        setState(() {});
                      }
                    }
                  }).build(context);
            },
          )),
    );
  }

  Widget codeBlockEditor(
      bool showDilg, Color scendryColor, Color backGroundColor, firstColor) {
    return Visibility(
      visible: editeBar,
      child: Container(
        padding: const EdgeInsets.all(10),
        color: firstColor,
        height: showDilg ? 400 : 800,
        width: 300,
        child: Wrap(
          runSpacing: 10,
          spacing: 10,
          direction: Axis.vertical,
          children: propertes(scendryColor, backGroundColor),
        ),
      ),
    );
  }

  List<Widget> propertes(Color scendryColor, Color backGroundColor) {
    if (nodeType == "Navigate") {
      return [
        Dropdown(
            items: widget.controller,
            onChanged: (e) {
              widget.setAction!(e, "nav", false);
            }),
      ];
    }
    if (nodeType == "Print") {
      return [
        SizedBox(
            height: 70,
            width: 280,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 200,
                  child: TextFormField(
                    onChanged: (e) {
                      value = e;
                    },
                    decoration: InputDecoration(
                      fillColor: backGroundColor,
                      filled: true,
                      labelStyle: TextStyle(
                        color: scendryColor,
                        fontFamily: "Tajawal",
                      ),
                      labelText: "Value",
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: scendryColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3.0),
                        borderSide: BorderSide(
                          color: scendryColor,
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: 70,
                  child: ButtonForOutline(
                    buttonColor: scendryColor,
                    onClick: () {
                      widget.setAction!(value, "print", false);
                    },
                    text: "Save",
                    textcolor: Colors.white,
                  ),
                ),
              ],
            )),
      ];
    } else {
      return [];
    }
  }

  final Graph graphe = Graph();
  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();

  @override
  void initState() {
    widget.jsonBlock["edges"]!.forEach((element) {
      var fromNodeId = element['from'];
      var toNodeId = element['to'];
      graphe.addEdge(Node.Id(fromNodeId), Node.Id(toNodeId));
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

    graphe.addEdge(Node.Id(a), Node.Id(a + 1));
    Navigator.pop(dialogContext);
    setState(() {});
  }

  Widget blocksMune(int a, dynamic dialogContext, Color backgroundColor) {
    return Dialog(
      backgroundColor: backgroundColor,
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
                      name: "Print",
                      add: () {
                        add(dialogContext, a, "Print");

                        setState(() {});
                      },
                    ),
                    CodeBox(
                      name: "Navigate",
                      add: () {
                        add(dialogContext, a, "Navigate");

                        setState(() {});
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
