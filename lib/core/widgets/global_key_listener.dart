import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GlobalKeyListener extends StatefulWidget {
  final Widget child;
  VoidCallback? f1Action;

  GlobalKeyListener({super.key, required this.child, this.f1Action});

  @override
  State<GlobalKeyListener> createState() => _GlobalKeyListenerState();
}

class _GlobalKeyListenerState extends State<GlobalKeyListener> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    _focusNode.requestFocus();
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
        focusNode: _focusNode,
        onKeyEvent: (event) {
          if (event is KeyDownEvent) {
            // print(event);
            // HardwareKeyboard.instance
            //         .isLogicalKeyPressed(LogicalKeyboardKey.altLeft)
            if (event.logicalKey == LogicalKeyboardKey.f1) {
              widget.f1Action!();
            }
            if (event.logicalKey == LogicalKeyboardKey.escape) {}
          }
        },
        child: widget.child);
  }
}
