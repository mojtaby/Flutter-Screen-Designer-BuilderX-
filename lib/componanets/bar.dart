// ignore_for_file: must_be_immutable

import 'package:builder/componanets/container.dart';
import 'package:builder/systems/screen.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';

import '../colors.dart';

class Bar extends StatelessWidget {
  Bar({super.key, required this.child, required this.back});
  Widget child;
  Function() back;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width > 850
        ? MediaQuery.of(context).size.width / 7
        : MediaQuery.of(context).size.width / 4;
    Color scendryColor = context.watch<ScreenInfo>().scendryColor;
    Color firstColor = context.watch<ScreenInfo>().firstColor;
    Color textColor = context.watch<ScreenInfo>().textColor;
    return SizedBox(
      height: double.infinity,
      width: width,
      child: Stack(
        children: [
          Container(
              color: firstColor,
              height: double.infinity,
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                controller: ScrollController(),
                child: Column(
                  children: [
                    Container(
                      width: width,
                      child: GFButton(
                        textColor: textColor,
                        hoverColor: scendryColor,
                        size: GFSize.SMALL,
                        color: scendryColor,
                        onPressed: () {
                          back();
                        },
                        text: "Back",
                        type: GFButtonType.outline,
                      ),
                    ),
                    child,
                  ],
                ),
              )),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: 2.2,
              decoration: BoxDecoration(
                color: const Color(
                  4291085508,
                ),
                borderRadius: BorderRadius.circular(
                  0,
                ),
                boxShadow: const [],
                gradient: const LinearGradient(
                  colors: [
                    Color(
                      0xff9572fc,
                    ),
                    Color(
                      0xff43e7ad,
                    ),
                    Color(
                      0xffe2d45c,
                    ),
                    Color(
                      0xff9572fc,
                    )
                  ],
                  begin: Alignment(
                    0,
                    1,
                  ),
                  end: Alignment(
                    0,
                    -1,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
