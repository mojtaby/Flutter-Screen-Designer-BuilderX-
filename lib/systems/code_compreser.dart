import 'package:builder/systems/widget.dart';
import 'package:device_frame/device_frame.dart';
import 'package:flutter/cupertino.dart';

// check widget type and set prop to widget for code Gnreator

class Compres {
  String cmpe(WidgetMoG e, BuildContext context, DeviceInfo device) {
    if (e.type == "container") {
      return ''' 
      //${e.widgetName}
     ${positioned(e, container(e, context, device))}''';
    } else if (e.type == "text") {
      return '''
 //${e.widgetName}
${positioned(e, text(e, context))}
''';
    } else if (e.type == "padding") {
      return '''
 //${e.widgetName}
${positioned(e, padding(e, context, device))}''';
    } else if (e.type == "center") {
      return '''
 //${e.widgetName}
 ${positioned(e, center(e, context, device))}
''';
    } else if (e.type == "icon") {
      return '''
 //${e.widgetName}
${positioned(e, icon(e, context, device))}''';
    } else if (e.type == "image") {
      return '''
 //${e.widgetName}
 ${positioned(e, image(e, context, device))}''';
    } else if (e.type == "button") {
      return '''
 //${e.widgetName}
 ${positioned(e, button(e, context, device))}''';
    } else if (e.type == "row") {
      return '''
 //${e.widgetName}
 ${positioned(e, row(e, context, device))}''';
    } else if (e.type == "column") {
      return '''
 //${e.widgetName}
  ${positioned(e, column(e, context, device))}''';
    } else if (e.type == "stack") {
      return '''
 //${e.widgetName}
 ${positioned(e, stack(e, context, device))}
''';
    } else if (e.type == "divider") {
      return '''
 //${e.widgetName}
 ${positioned(e, divider(e, context, device))}
''';
    } else if (e.type == "safeArea") {
      return '''
 //${e.widgetName}
${positioned(e, safeArea(e, context, device))}
      ''';
    } else if (e.type == "sizedBox") {
      return '''

 //${e.widgetName}
 ${positioned(e, sizedBox(e, context, device))}
''';
    } else {
      return sizedBox(e, context, device);
    }
  }

  String container(WidgetMoG e, BuildContext context, DeviceInfo device) {
    return '''
Container(
      height: ${e.widget["height"]},
      width: ${e.widget["width"]},
       ${e.widget["havePadding"] == true ? '''
            padding: EdgeInsets.only(
            ${e.widget["paddingLeft"] > 0 ? 'left: ${e.widget["paddingLeft"]},' : ''}
            ${e.widget["paddingRight"] > 0 ? 'right: ${e.widget["paddingRight"]},' : ''}
            ${e.widget["paddingTop"] > 0 ? 'top: ${e.widget["paddingTop"]},' : ''}
            ${e.widget["paddingBottom"] > 0 ? 'bottom: ${e.widget["paddingBottom"]},' : ''}),
            ''' : ''}
      
        ${e.widget["haveMargin"] == true ? '''
            margin: EdgeInsets.only(
            ${e.widget["marginLeft"] > 0 ? 'left: ${e.widget["marginLeft"]},' : ''}
            ${e.widget["marginRight"] > 0 ? 'right: ${e.widget["marginRight"]},' : ''}
            ${e.widget["marginTop"] > 0 ? 'top: ${e.widget["marginTop"]},' : ''}
            ${e.widget["marginBottom"] > 0 ? 'bottom: ${e.widget["marginBottom"]},' : ''}),
            ''' : ''}

          decoration: BoxDecoration(
          color: ${e.widget["color"]},
            ${e.widget["haveBorderRadius"] == true ? '''
            borderRadius: BorderRadius.only(
            ${e.widget["borderRadiustopLeft"] > 0 ? 'topLeft:Radius.circular(${e.widget["borderRadiustopLeft"]}),' : ''}
            ${e.widget["borderRadiustopRight"] > 0 ? 'topRight: Radius.circular(${e.widget["borderRadiustopRight"]}),' : ''}
            ${e.widget["borderRadiusbottomLeft"] > 0 ? 'bottomLeft: Radius.circular(${e.widget["borderRadiusbottomLeft"]}),' : ''}
             ${e.widget["borderRadiusbottomRight"] > 0 ? 'bottomRight: Radius.circular(${e.widget["borderRadiusbottomRight"]}),' : ''}
          ),),
            ''' : ''}

       
         ${e.child != null ? 'child: ${cmpe(e.child!, context, device)}' : ''}
      ),)
''';
  }

  String padding(WidgetMoG e, BuildContext context, DeviceInfo device) {
    return '''
Padding(
         padding: EdgeInsets.only(
            ${e.widget["paddingLeft"] > 0 ? 'left: ${e.widget["paddingLeft"]},' : ''}
            ${e.widget["paddingRight"] > 0 ? 'right: ${e.widget["paddingRight"]},' : ''}
            ${e.widget["paddingTop"] > 0 ? 'top: ${e.widget["paddingTop"]},' : ''}
            ${e.widget["paddingBottom"] > 0 ? 'bottom: ${e.widget["paddingBottom"]},' : ''}),
      ${e.child != null ? 'child: ${cmpe(e.child!, context, device)}' : ''}    
        
    )
''';
  }

  String center(WidgetMoG e, BuildContext context, DeviceInfo device) {
    return '''
Center(
      ${e.child != null ? 'child: ${cmpe(e.child!, context, device)}' : ''}    
        
    )
''';
  }

  String icon(WidgetMoG e, BuildContext context, DeviceInfo device) {
    return '''
Icon(
      ${e.widget["icon"]},
      color: ${e.widget["color"]},
      size: ${e.widget["size"]},  
        
    )
''';
  }

  String image(WidgetMoG e, BuildContext context, DeviceInfo device) {
    return ''' Image.network(
          "${e.widget["imageUrl"]}",
          fit: ${e.widget["imageBoxFit"]},
          height:${e.widget["height"]},
          width:${e.widget["width"]},
        )''';
  }

  String button(WidgetMoG e, BuildContext context, DeviceInfo device) {
    return '''
ElevatedButton(
        style: ElevatedButton.styleFrom(primary: ${e.widget["color"]}),
        ${e.onClickCoder.isNotEmpty ? 'onPressed: (){${e.onClickForCoder};}' : 'onPressed:(){}'}
   ${e.child != null ? 'child: ${cmpe(e.child!, context, device)}' : ''}
      )
''';
  }

  String row(WidgetMoG e, BuildContext context, DeviceInfo device) {
    return '''
Row(
crossAxisAlignment: ${e.widget["crossAxisAlignment"]},
mainAxisAlignment: ${e.widget["mainAxisAlignment"]},
 ${e.children.isNotEmpty ? 'children: ${e.children.map((e) => cmpe(e, context, device)).toList()}' : 'children:[]'}
)
''';
  }

  String column(WidgetMoG e, BuildContext context, DeviceInfo device) {
    return '''
Column(
crossAxisAlignment: ${e.widget["crossAxisAlignment"]},
mainAxisAlignment: ${e.widget["mainAxisAlignment"]},
 ${e.children.isNotEmpty ? 'children: ${e.children.map((e) => cmpe(e, context, device)).toList()}' : 'children:[]'}
)
''';
  }

  String stack(WidgetMoG e, BuildContext context, DeviceInfo device) {
    return '''
Stack( 
${e.children.isNotEmpty ? 'children: ${e.children.map((e) => cmpe(e, context, device)).toList()}' : 'children:[]'})
''';
  }

  String divider(WidgetMoG e, BuildContext context, DeviceInfo device) {
    return '''
Divider(
      color:${e.widget["color"]},
      height: ${e.widget["height"]},
      thickness: ${e.widget["width"]},
    )
''';
  }

  String safeArea(WidgetMoG e, BuildContext context, DeviceInfo device) {
    return '''
SafeArea(
        left: ${e.widget["SafeArealeft"]},
        right:${e.widget["SafeArearight"]},
        top: ${e.widget["SafeAreatop"]},
        bottom: ${e.widget["SafeAreabottom"]},
        child:${e.child == null ? "null" : cmpe(e.child!, context, device)}
      )
''';
  }

  String sizedBox(WidgetMoG e, BuildContext context, DeviceInfo device) {
    return '''
SizedBox(
        height: ${e.widget["height"]},
        width: ${e.widget["width"]},
       child:${e.child == null ? "null" : cmpe(e.child!, context, device)}
      )
''';
  }

  String positioned(WidgetMoG e, String child) {
    return ''' 
    Positioned(
       height: ${e.widget["height"]},
        width: ${e.widget["width"]},
      top: ${e.top.round()},
      left: ${e.left.round()},
      child:$child
      )''';
  }

  String clipRRect(WidgetMoG e, String child) {
    return '''
ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(widget["borderRadiustopLeft"]),
            topRight: Radius.circular(widget["borderRadiustopRight"]),
            bottomLeft: Radius.circular(widget["borderRadiusbottomLeft"]),
            bottomRight: Radius.circular(widget["borderRadiusbottomRight"])),
        child: $child);
''';
  }

  String text(WidgetMoG e, BuildContext context) {
    return ''' 
     //${e.widgetName}
    Text(
     '${e.widget["textValue"]}',
      style: TextStyle(
        color:${e.widget["color"]},
        fontSize:${e.widget["size"]},
        fontWeight: ${e.widget["fontWeight"]},
        ${e.widget['letterSpacing'] > 0 ? 'letterSpacing: ${e.widget["letterSpacing"]},' : ''}      
        
    ),)''';
  }
}
