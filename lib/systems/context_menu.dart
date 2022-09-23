import 'package:builder/systems/widget.dart';
import 'package:context_menu_macos/context_menu_macos.dart';
import 'package:flutter/material.dart';

class ContextMenu extends StatelessWidget {
  ContextMenu(
      {super.key,
      required this.child,
      required this.copy,
      required this.delete,
      required this.select,
      required this.paste});
  Function(dynamic) copy;
  Function(dynamic) paste;
  Function(dynamic) delete;
  Function(dynamic) select;
  Widget child;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onSecondaryTapDown: (details) {
        select(child);
        showMacosContextMenu(
          context: context,
          globalPosition: details.globalPosition,
          children: [
            MacosContextMenuItem(
              content: const Text('Delete'),
              onTap: () {
                delete(child);
              },
            ),
            MacosContextMenuItem(
              content: const Text('Copy'),
              onTap: () {
                copy(child);
              },
            ),
            MacosContextMenuItem(
              content: const Text('Paste'),
              onTap: () {
                paste(child);
              },
            ),
          ],
        );
      },
      child: child,
    );
  }
}
