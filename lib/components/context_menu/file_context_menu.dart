import 'package:flutter/material.dart';

typedef OnDelete = Future Function();

mixin FileContextMenuMixin {
  final ContextMenuController _contextMenuController = ContextMenuController();
  Widget _buildFileMenuContent(BuildContext context, Offset offset,
      {OnDelete? onDelete}) {
    return AdaptiveTextSelectionToolbar(
      anchors: TextSelectionToolbarAnchors(
        primaryAnchor: offset,
      ),
      children: _buildFileContextMenuItem(offset, context, onDelete: onDelete),
    );
  }

  List<Widget> _buildFileContextMenuItem(Offset position, BuildContext ctx,
      {OnDelete? onDelete}) {
    return [
      MenuItemButton(
        leadingIcon: const Icon(
          Icons.delete,
          color: Colors.red,
        ),
        child: const Text("删除"),
        onPressed: () async {
          if (onDelete != null) {
            await onDelete();
          }
          dismiss();
        },
      ),
    ];
  }

  void dismiss() {
    ContextMenuController.removeAny();
  }

  void showFileContextMenu(Offset position, BuildContext context,
      {OnDelete? onDelete}) {
    _contextMenuController.show(
      context: context,
      contextMenuBuilder: (ctx) =>
          _buildFileMenuContent(context, position, onDelete: onDelete),
    );
  }
}
