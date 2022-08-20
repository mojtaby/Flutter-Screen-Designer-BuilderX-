import 'package:builder/builder.dart';
import 'package:builder/colors.dart';
import 'package:builder/componanets/text.dart';
import 'package:builder/systems/canvas_controller.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'systems/screen.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => ScreenInfo(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Builder x',
      home: EasySplashScreen(
        loaderColor: textFieldColor,
        logoSize: 150,
        logo: Image.network('https://i.postimg.cc/BnSYYnzV/logo-1.png'),
        backgroundColor: Color.fromARGB(255, 13, 1, 102),
        showLoader: true,
        navigator: BuilderWorkPage(),
        durationInSeconds: 0,
      ),
    );
  }
}
