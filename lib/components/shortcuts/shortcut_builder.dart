import 'package:flutter/material.dart';
import 'package:flutter_desktop/components/shortcuts/shortcut_controller.dart';
import 'package:flutter_desktop/components/window_shortcut_types.dart';

class ShortcutBuilder extends StatelessWidget {
  const ShortcutBuilder({super.key, required this.builder, required this.type});
  final WidgetBuilder builder;
  final WindowShortcutTypes type;

  @override
  Widget build(BuildContext context) {
    return Focus(
        onKey: (node, event) {
          KeyEventResult result = KeyEventResult.ignored;
          final function = ShortcutController.accepts(event, type);
          if (function != null) {
            function.call();
          }
          return result;
        },
        autofocus: true,
        child: builder.call(context));
  }
}
