import 'package:builder/builder.dart';
import 'package:builder/componanets/button.dart';

import 'package:builder/componanets/text.dart';

import 'package:nav/nav.dart';

import 'package:flutter/material.dart';

import 'package:builder/colors.dart';

import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'systems/screen.dart';

main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => ScreenInfo(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with Nav {
  @override
  void initState() {
    super.initState();
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey => MyApp.navigatorKey;
  @override
  Widget build(BuildContext context) {
    Color scendryColor = context.watch<ScreenInfo>().scendryColor;
    Color textColor = context.watch<ScreenInfo>().textColor;
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Builder x',
      home: Scaffold(
        backgroundColor: backGroundColor,
        body: Stack(
          children: [
            Image.network(
              "https://i.postimg.cc/mZzRbSJ8/Fundo-5.png",
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: SingleChildScrollView(
                controller: ScrollController(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    TextForLessCode(
                      value: "BETA",
                      fontWeight: FontWeight.w100,
                      size: 10,
                      color: textColor,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextForLessCode(
                          fontWeight: FontWeight.w500,
                          value: "Builder",
                          size: 70,
                          color: textColor,
                        ),
                        TextForLessCode(
                          fontWeight: FontWeight.bold,
                          value: " X",
                          size: 70,
                          color: scendryColor,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: TextForLessCode(
                          fontWeight: FontWeight.w300,
                          value:
                              'Build your mobile app within minutes or days, by select and',
                          size: 20,
                          color: textColor,
                        ),
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: TextForLessCode(
                          fontWeight: FontWeight.w300,
                          value:
                              '  drop you can explore opportunities you never thought of.',
                          size: 20,
                          color: textColor,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ButtonForRounded(
                          stander: false,
                          size: const Size(120, 35),
                          buttonColor: scendryColor,
                          onClick: () {
                            Nav.pushFromBottom(BuilderWorkPage());
                          },
                          text: "Start",
                          textcolor: Colors.white,
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        ButtonForOutline(
                          stander: false,
                          size: const Size(120, 35),
                          buttonColor: scendryColor,
                          onClick: () {
                            launchUrlString(
                                "https://github.com/mojtaby/Flutter-Screen-Designer",
                                mode: LaunchMode.platformDefault);
                          },
                          text: "Source",
                          textcolor: Colors.white,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      controller: ScrollController(),
                      child: Row(
                        children: [
                          Image.network(
                            "https://i.postimg.cc/SKwwq4Gy/Group-1-2.png",
                            height: 300,
                            width: 300,
                            fit: BoxFit.contain,
                          ),
                          Image.network(
                            "https://i.postimg.cc/MHY0s0GC/Group-186-2.png",
                            height: 300,
                            width: 300,
                            fit: BoxFit.contain,
                          ),
                          Image.network(
                            "https://i.postimg.cc/DZpn1HrH/Group-1-1.png",
                            height: 300,
                            width: 300,
                            fit: BoxFit.contain,
                          ),
                          Image.network(
                            "https://i.postimg.cc/fyf0vwb5/Group-8.png",
                            height: 300,
                            width: 300,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
