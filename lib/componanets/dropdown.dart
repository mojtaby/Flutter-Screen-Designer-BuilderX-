import 'package:builder/colors.dart';
import 'package:builder/componanets/button.dart';
import 'package:builder/componanets/text.dart';

import 'package:flutter/material.dart';

class Dropdown extends StatelessWidget {
  Dropdown(
      {super.key,
      this.size = const Size(280, 70),
      required this.items,
      this.valuee = "Screen Name",
      required this.onChanged});

  List<dynamic> items;
  Function(dynamic) onChanged;
  Size size;
  String valuee;
  dynamic value;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height,
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: 200,
            height: 70,
            child: DropdownButtonFormField(
                decoration: InputDecoration(
                  fillColor: backGroundColor,
                  filled: true,
                  labelStyle: TextStyle(
                    color: scendryColor,
                    fontFamily: "Tajawal",
                  ),
                  labelText: valuee,
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
                hint: TextForLessCode(value: "Screen Name"),
                items: items
                    .map((e) => DropdownMenuItem(
                        value: e, child: TextForLessCode(value: e.labele)))
                    .toList(),
                onChanged: (e) {
                  value = e;
                }),
          ),
          ButtonForRounded(
            size: Size(70, 30),
            text: "Save",
            onClick: () {
              onChanged(value);
            },
          )
        ],
      ),
    );
  }
}
