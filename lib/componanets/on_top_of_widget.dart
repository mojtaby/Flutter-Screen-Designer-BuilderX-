import 'package:builder/colors.dart';
import 'package:builder/systems/screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResizebleWidget extends StatefulWidget {
  ResizebleWidget(
      {Key? key,
      required this.child,
      required this.onWidth,
      required this.onHeight,
      required this.onLeft,
      required this.onTop,
      required this.copy,
      required this.paste,
      required this.delelte,
      required this.cut,
      required this.selectWidget,
      required this.isSelected,
      this.size = const Size(100, 100),
      this.offset = const Offset(0, 0)})
      : super(key: key);

  final Widget child;
  Size size;
  Offset offset;
  Function(double newWidth) onWidth;
  Function(double newHeight) onHeight;
  Function(double newLeft) onLeft;
  Function(double newTop) onTop;
  Function selectWidget;
  Function delelte;
  Function copy;
  Function cut;
  Function paste;
  bool isSelected;

  @override
  _ResizebleWidgetState createState() => _ResizebleWidgetState();
}

const ballDiameter = 15.0;

class _ResizebleWidgetState extends State<ResizebleWidget> {
  double top = 0;
  double left = 0;
  double height = 0;
  double width = 0;
  @override
  void initState() {
    top = widget.offset.dy;
    left = widget.offset.dx;
    height = widget.size.height;
    width = widget.size.width;
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool canDrag = context.watch<ScreenInfo>().dragWidget;
    bool rest = context.watch<ScreenInfo>().restOverWidget;
    Color scendryColor = context.watch<ScreenInfo>().scendryColor;
    Color backGroundColor = context.watch<ScreenInfo>().backGroundColor;
    Color firstColor = context.watch<ScreenInfo>().firstColor;
    Color textColor = context.watch<ScreenInfo>().textColor;
    if (rest) {
      Future.delayed(Duration.zero, () {
        setState(() {
          top = widget.offset.dy;
          left = widget.offset.dx;
          height = widget.size.height;
          width = widget.size.width;
        });
        Provider.of<ScreenInfo>(context, listen: true).setrestOverWidget(false);
      });
    } else {
      setState(() {});
    }
    if (widget.isSelected) {
      return Stack(
        children: <Widget>[
          Positioned(
            top: top,
            left: left,
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: scendryColor, width: 2),
                ),
                height: height,
                width: width,
                child: widget.child),
          ),
          // top left
          Stack(
            children: [
              Positioned(
                top: top - ballDiameter / 2,
                left: left - ballDiameter / 2,
                child: ManipulatingBall(
                  onTap: () {
                    widget.cut();
                  },
                  message: "Cut Widget And Properties",
                  iconData: Icons.content_cut,
                  onDrag: (dx, dy) {
                    var mid = (dx + dy) / 2;
                    var newHeight = height - 2 * mid;
                    var newWidth = width - 2 * mid;

                    setState(() {
                      height = newHeight > 0 ? newHeight : 0;
                      width = newWidth > 0 ? newWidth : 0;
                      top = top + mid;
                      left = left + mid;
                    });
                    widget.onHeight(height);
                    widget.onWidth(width);
                    widget.onLeft(left);
                    widget.onTop(top);
                  },
                ),
              ),
              // top middle
              Positioned(
                top: top - ballDiameter / 2,
                left: left + width / 2 - ballDiameter / 2,
                child: ManipulatingBall(
                  onTap: () {},
                  message: "Size",
                  iconData: Icons.expand_less,
                  onDrag: (dx, dy) {
                    var newHeight = height - dy;

                    setState(() {
                      height = newHeight > 0 ? newHeight : 0;
                      top = top + dy;
                    });
                    widget.onLeft(left);
                    widget.onHeight(height);
                  },
                ),
              ),
              // top right
              Positioned(
                top: top - ballDiameter / 2,
                left: left + width - ballDiameter / 2,
                child: ManipulatingBall(
                  onTap: () {
                    widget.delelte();
                  },
                  message: "Delete",
                  iconData: Icons.clear,
                  onDrag: (dx, dy) {
                    var mid = (dx + (dy * -1)) / 2;

                    var newHeight = height + 2 * mid;
                    var newWidth = width + 2 * mid;

                    setState(() {
                      height = newHeight > 0 ? newHeight : 0;
                      width = newWidth > 0 ? newWidth : 0;
                      top = top - mid;
                      left = left - mid;
                    });
                    widget.onHeight(height);
                    widget.onWidth(width);
                    widget.onLeft(left);
                    widget.onTop(top);
                  },
                ),
              ),
              // center right
              Positioned(
                top: top + height / 2 - ballDiameter / 2,
                left: left + width - ballDiameter / 2,
                child: ManipulatingBall(
                  onTap: () {},
                  message: "Size",
                  iconData: Icons.keyboard_arrow_right,
                  onDrag: (dx, dy) {
                    var newWidth = width + dx;

                    setState(() {
                      width = newWidth > 0 ? newWidth : 0;
                    });

                    widget.onWidth(width);
                  },
                ),
              ),
              // bottom right
              Positioned(
                top: top + height - ballDiameter / 2,
                left: left + width - ballDiameter / 2,
                child: ManipulatingBall(
                  onTap: () {
                    widget.copy();
                  },
                  message: "Copy Properties",
                  iconData: Icons.layers,
                  onDrag: (dx, dy) {
                    var mid = (dx + dy) / 2;

                    var newHeight = height + 2 * mid;
                    var newWidth = width + 2 * mid;

                    setState(() {
                      height = newHeight > 0 ? newHeight : 0;
                      width = newWidth > 0 ? newWidth : 0;
                      top = top - mid;
                      left = left - mid;
                    });
                    widget.onHeight(height);
                    widget.onWidth(width);
                    widget.onLeft(left);
                    widget.onTop(top);
                  },
                ),
              ),
              // bottom center
              Positioned(
                top: top + height - ballDiameter / 2,
                left: left + width / 2 - ballDiameter / 2,
                child: ManipulatingBall(
                  onTap: () {},
                  message: "Size",
                  iconData: Icons.keyboard_arrow_down,
                  onDrag: (dx, dy) {
                    var newHeight = height + dy;

                    setState(() {
                      height = newHeight > 0 ? newHeight : 0;
                    });
                    widget.onHeight(height);
                  },
                ),
              ),
              // bottom left
              Positioned(
                top: top + height - ballDiameter / 2,
                left: left - ballDiameter / 2,
                child: ManipulatingBall(
                  onTap: () {
                    widget.paste();
                    Future.delayed(Duration.zero, () {
                      Provider.of<ScreenInfo>(context, listen: true)
                          .setrestOverWidget(true);
                    });
                  },
                  message: "Paste Properties",
                  iconData: Icons.content_paste,
                  onDrag: (dx, dy) {
                    var mid = ((dx * -1) + dy) / 2;

                    var newHeight = height + 2 * mid;
                    var newWidth = width + 2 * mid;

                    setState(() {
                      height = newHeight > 0 ? newHeight : 0;
                      width = newWidth > 0 ? newWidth : 0;
                      top = top - mid;
                      left = left - mid;
                    });
                    widget.onHeight(height);
                    widget.onWidth(width);
                    widget.onLeft(left);
                    widget.onTop(top);
                  },
                ),
              ),
              //left center
              Positioned(
                top: top + height / 2 - ballDiameter / 2,
                left: left - ballDiameter / 2,
                child: ManipulatingBall(
                  onTap: () {},
                  message: "Size",
                  iconData: Icons.navigate_before,
                  onDrag: (dx, dy) {
                    var newWidth = width - dx;

                    setState(() {
                      width = newWidth > 0 ? newWidth : 0;
                      left = left + dx;
                    });
                    widget.onLeft(left);

                    widget.onWidth(width);
                  },
                ),
              ),
              // center center

              Positioned(
                top: top + height / 2 - ballDiameter / 2,
                left: left + width / 2 - ballDiameter / 2,
                child: Visibility(
                  visible: canDrag,
                  child: ManipulatingBall(
                    onTap: () {},
                    message: "Drag",
                    iconData: Icons.back_hand_outlined,
                    onDrag: (dx, dy) {
                      setState(() {
                        top = top + dy;
                        left = left + dx;
                      });
                      widget.onLeft(left);
                      widget.onTop(top);
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    } else {
      return Positioned(left: left, top: top, child: widget.child);
    }
  }
}

class ManipulatingBall extends StatefulWidget {
  ManipulatingBall(
      {Key? key,
      required this.onDrag,
      required this.message,
      required this.iconData,
      required this.onTap})
      : super(key: key);

  final Function onDrag;
  final String message;
  final IconData iconData;
  Function onTap;
  @override
  _ManipulatingBallState createState() => _ManipulatingBallState();
}

class _ManipulatingBallState extends State<ManipulatingBall> {
  double initX = 0;
  double initY = 0;
  bool color = false;

  _handleDrag(details) {
    setState(() {
      initX = details.globalPosition.dx;
      initY = details.globalPosition.dy;
    });
  }

  _handleUpdate(details) {
    var dx = details.globalPosition.dx - initX;
    var dy = details.globalPosition.dy - initY;
    initX = details.globalPosition.dx;
    initY = details.globalPosition.dy;
    widget.onDrag(dx, dy);
  }

  @override
  Widget build(BuildContext context) {
    Color scendryColor = context.watch<ScreenInfo>().scendryColor;
    Color backGroundColor = context.watch<ScreenInfo>().backGroundColor;
    Color firstColor = context.watch<ScreenInfo>().firstColor;
    Color textColor = context.watch<ScreenInfo>().textColor;
    return Tooltip(
      message: widget.message,
      child: GestureDetector(
        onTap: () {
          widget.onTap();
        },
        onPanStart: _handleDrag,
        onPanUpdate: _handleUpdate,
        child: Container(
          width: ballDiameter,
          height: ballDiameter,
          decoration: BoxDecoration(
            color: color ? scendryColor : scendryColor,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              widget.iconData,
              color: backGroundColor,
              size: 13,
            ),
          ),
        ),
      ),
    );
  }
}
