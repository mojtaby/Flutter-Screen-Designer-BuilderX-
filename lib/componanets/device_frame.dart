import 'package:builder/colors.dart';
import 'package:builder/componanets/container.dart';
import 'package:builder/componanets/text.dart';
import 'package:builder/systems/screen.dart';
import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeviceFrameSelecter extends StatelessWidget {
  DeviceFrameSelecter({super.key, required this.info});
  Function(DeviceInfo info) info;
  List<String> devicesList = [
    "laptop",
    "wideMonitor",
    "iPad",
    "iPhone13",
    "samsungGalaxyS20",
    "largeTablet",
    "macBookPro"
  ];

  @override
  Widget build(BuildContext context) {
    Color scendryColor = context.watch<ScreenInfo>().scendryColor;
    Color backGroundColor = context.watch<ScreenInfo>().backGroundColor;
    Color firstColor = context.watch<ScreenInfo>().firstColor;
    Color textColor = context.watch<ScreenInfo>().textColor;
    return ContainerForLessCode(
      color: backGroundColor,
      setHight: false,
      width: 600,
      child: Column(
        children: devicesList
            .map((e) => GestureDetector(
                  onTap: () {
                    if (e == "laptop") {
                      info(Devices.windows.laptop);
                    } else if (e == "wideMonitor") {
                      info(Devices.windows.wideMonitor);
                    } else if (e == "iPad") {
                      info(Devices.ios.iPad);
                    } else if (e == "iPhone13") {
                      info(Devices.ios.iPhone13);
                    } else if (e == "samsungGalaxyS20") {
                      info(Devices.android.samsungGalaxyS20);
                    } else if (e == "largeTablet") {
                      info(Devices.android.largeTablet);
                    } else if (e == "macBookPro") {
                      info(Devices.macOS.macBookPro);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ContainerForLessCode(
                        color: scendryColor,
                        child: TextForLessCode(
                          value: e,
                          color: Colors.white,
                        )),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
