import 'package:flutter/material.dart';
import 'package:flutter_desktop/components/short_cuts/shortcut_controller.dart';
import 'package:flutter_desktop/components/window_types.dart';

class ShortCutBuilder extends StatelessWidget {
  const ShortCutBuilder({super.key, required this.builder, required this.type});
  final WidgetBuilder builder;
  final WindowShortCutTypes type;

  @override
  Widget build(BuildContext context) {
    return Focus(
        onKey: (node, event) {
          KeyEventResult result = KeyEventResult.ignored;
          final function = ShortCutController.accepts(event, type);
          if (function != null) {
            function.call();
          }
          return result;
        },
        autofocus: true,
        child: builder.call(context));
  }
}
