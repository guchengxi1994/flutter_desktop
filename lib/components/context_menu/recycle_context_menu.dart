import 'package:flutter/material.dart';
import 'package:flutter_desktop/components/app_style.dart';

typedef OnRestore = Future Function();

mixin RecycleContextMenuMixin {
  final ContextMenuController _contextMenuController = ContextMenuController();
  Widget _buildRecycleMenuContent(BuildContext context, Offset offset,
      {OnRestore? onRestore}) {
    return AdaptiveTextSelectionToolbar(
      anchors: TextSelectionToolbarAnchors(
        primaryAnchor: offset,
      ),
      children:
          _buildRecycleContextMenuItem(offset, context, onRestore: onRestore),
    );
  }

  List<Widget> _buildRecycleContextMenuItem(Offset position, BuildContext ctx,
      {OnRestore? onRestore}) {
    return [
      MenuItemButton(
        leadingIcon: const Icon(
          Icons.restore,
          color: AppStyle.dark,
        ),
        child: const Text("还原"),
        onPressed: () async {
          if (onRestore != null) {
            await onRestore();
          }
          dismiss();
        },
      ),
    ];
  }

  void dismiss() {
    ContextMenuController.removeAny();
  }

  void showRecycleContextMenu(Offset position, BuildContext context,
      {OnRestore? onRestore}) {
    _contextMenuController.show(
      context: context,
      contextMenuBuilder: (ctx) =>
          _buildRecycleMenuContent(context, position, onRestore: onRestore),
    );
  }
}
