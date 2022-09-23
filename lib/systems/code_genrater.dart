import 'package:builder/systems/canvas_controller.dart';

class CodeGenerator {
  // var generator  {"type": "", "name": "", "value": ""},

  dynamic generatorMain(List<String> widgets, bool haveVar,
      MoGCanvasItem screen, var varGeneratore) {
    return '''
import 'package:flutter/material.dart';

void main() {
  runApp(
     ${screen.labele.replaceAll(" ", "")}(),
  );
}

class ${screen.labele.replaceAll(" ", "")} extends StatefulWidget {
  
   ${screen.labele.replaceAll(" ", "")}({super.key});

  @override
  State<${screen.labele.replaceAll(" ", "")}> createState() => _${screen.labele.replaceAll(" ", "")}State();
}

class _${screen.labele.replaceAll(" ", "")}State extends State<${screen.labele.replaceAll(" ", "")}> {
  ${screen.screenVariables.isNotEmpty ? screen.screenVariables.map((e) {
              if (e["isList"] == true) {
                if (e["type"] == "String") {
                  return "List<${e["type"]}> ${e["name"]} =[${e["value"]}];";
                } else {}
                return "List<${e["type"]}> ${e["name"]} =[${e["value"]}];";
              } else {
                if (e["type"] == "String") {
                  return " ${e["type"]} ${e["name"]} = '${e["value"]}';";
                } else {
                  return " ${e["type"]} ${e["name"]} = ${e["value"]};";
                }
              }
            }).toString().replaceAll("(", "").replaceAll(")", "").replaceAll(";,", ";") : ''} 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '${screen.labele.toString()}',
      home: Scaffold(
        ${screen.appBar ? 'appBar:${screen.appBarWidget},' : ''}
        ${screen.floatingActionButton ? 'floatingActionButton:${screen.floatingActionButtonWidget},' : ''}
        ${screen.drawer ? 'drawer:${screen.drawerWidget},' : ''}
        ${screen.items.isNotEmpty ? 'body: Stack(children: $widgets,)' : ''}
        )
    );
  }
}


''';
  }
}
