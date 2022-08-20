import 'package:builder/systems/canvas_controller.dart';
import 'package:flutter/widgets.dart';

class ScreenInfo extends ChangeNotifier {
  int _homeScreen = 0;
  int _screenIndex = 0;
  bool _unableOnClick = false;
  MoGCanvasItem _screen = MoGCanvasItem();
  var _screenVariables = [];

  int get screenIndex => _screenIndex;
  int get homeScreen => _homeScreen;
  bool get unableOnClick => _unableOnClick;
  MoGCanvasItem get screen => _screen;
  get screenVariables => _screenVariables;

  void changeHomeScreen(int index) {
    _homeScreen = homeScreen;
    notifyListeners();
  }

  void changeScreen(int index) {
    _screenIndex = index;
    notifyListeners();
  }

  void changerUnableOnClick(bool value) {
    _unableOnClick = value;
    notifyListeners();
  }

  void setScreen(MoGCanvasItem screen) {
    _screen = screen;
    notifyListeners();
  }
}
