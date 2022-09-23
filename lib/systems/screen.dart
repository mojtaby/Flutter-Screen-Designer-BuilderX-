import 'package:builder/systems/canvas_controller.dart';
import 'package:builder/systems/widget.dart';
import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';

class ScreenInfo extends ChangeNotifier {
  bool _propertiesBar = false;
  bool _isSelectedIsScreen = false;
  bool _dragWidget = false;
  int _homeScreen = 0;
  int _screenIndex = 0;
  bool _unableOnClick = false;
  bool _restOverWidget = false;
  String _screenCode = "";
  dynamic _copy;
  final Color _backGroundColor = const Color.fromARGB(255, 42, 38, 52);
  final Color _textColor = Colors.white;
  final Color _scendryColor = const Color.fromARGB(255, 138, 92, 246);
  final Color _firstColor = const Color.fromARGB(255, 46, 45, 45);

  Color get backGroundColor => _backGroundColor;
  Color get textColor => _textColor;
  Color get scendryColor => _scendryColor;
  Color get firstColor => _firstColor;
  dynamic get copy => _copy;
  DeviceInfo _devaceName = Devices.windows.laptop;
  List<String> _console = ["Run app Worked"];
  var _screenVariables = [];
  WidgetMoG _selectedWidget = WidgetMoG(
      keye: "0",
      type: "",
      canHaveChild: false,
      onChildrenClicked: (r) {},
      childClick: (e) {},
      controllerNav: CanvasController(
        notifier: ([notify = false]) => false,
      ));
  MoGCanvasItem _screen = MoGCanvasItem();

  bool get isSelectedIsScreen => _isSelectedIsScreen;
  bool get dragWidget => _dragWidget;
  int get screenIndex => _screenIndex;
  int get homeScreen => _homeScreen;
  bool get unableOnClick => _unableOnClick;
  MoGCanvasItem get screen => _screen;
  get screenVariables => _screenVariables;
  get screenCode => _screenCode;
  WidgetMoG get selectedWidget => _selectedWidget;
  List<String> get console => _console;
  DeviceInfo get devaceName => _devaceName;
  bool get propertiesBar => _propertiesBar;

  bool get restOverWidget => _restOverWidget;

  void setCopy(dynamic cop) {
    _copy = cop;
  }

  void setrestOverWidget(bool s) {
    _restOverWidget = s;
    notifyListeners();
  }

  void setpropertiesBar(bool s) {
    _propertiesBar = s;
    notifyListeners();
  }

  void refresPropertiesBar() {
    _propertiesBar = false;
    notifyListeners();
    Future.delayed(Duration.zero, () {
      _propertiesBar = true;
      notifyListeners();
    });
  }

  void setSelectedIsScreen(bool s) {
    _isSelectedIsScreen = s;
    notifyListeners();
  }

  void setDragWidget(bool s) {
    _dragWidget = s;
    notifyListeners();
  }

  void setDevaceName(DeviceInfo s) {
    _devaceName = s;
    notifyListeners();
  }

  void setSelectedWdiget(WidgetMoG s) {
    _selectedWidget = s;
    notifyListeners();
  }

  void changeHomeScreen(int index) {
    _homeScreen = index;
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

  void setScreenCode(String code, var vars) {
    _screenCode = code;
    _screenVariables = vars;
    notifyListeners();
  }

  void setScreen(MoGCanvasItem screen) {
    _screen = screen;

    notifyListeners();
  }

  void restConsole() {
    _console = ["Run app Worked"];
    notifyListeners();
  }

  void consolee(String text) {
    _console.add(text);
    notifyListeners();
  }
}
