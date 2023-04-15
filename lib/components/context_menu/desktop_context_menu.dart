import 'package:flutter/material.dart';
import 'package:flutter_desktop/components/app_style.dart';

mixin DesktopContextMenuMixin {
  final ContextMenuController _contextMenuController = ContextMenuController();
  Widget _buildContent(BuildContext context, Offset offset) {
    return AdaptiveTextSelectionToolbar(
      anchors: TextSelectionToolbarAnchors(
        primaryAnchor: offset,
      ),
      children:
          _buildDesktopContextMenuItem(offset, MediaQuery.of(context).size),
    );
  }

  void showContextMenu(Offset position, BuildContext context) {
    _contextMenuController.show(
      context: context,
      contextMenuBuilder: (ctx) => _buildContent(ctx, position),
    );
  }

  void dismiss() {
    ContextMenuController.removeAny();
  }

  final double _types = 1;

  List<Widget> _buildDesktopContextMenuItem(Offset position, Size size) {
    double dx = 0;
    double dy = 0;
    if ((position.dx - size.width).abs() < 250) {
      dx = -130;
    } else {
      dx = 220;
    }

    if ((position.dy - size.height).abs() < 200) {
      dy = -(_types * 40);
    } else {
      dy = -40;
    }

    return [
      MenuItemButton(
        leadingIcon: const Icon(
          Icons.refresh,
          color: AppStyle.dark,
        ),
        child: const Text("刷新"),
        onPressed: () {
          dismiss();
        },
      ),
      const Divider(
        height: 1,
        color: AppStyle.grey,
      ),
      MenuItemButton(
          leadingIcon: const Icon(
            Icons.skip_next,
            color: AppStyle.dark,
          ),
          child: const Text("下一张壁纸"),
          onPressed: () {
            dismiss();
          }),
      SubmenuButton(
        alignmentOffset: Offset(dx, dy),
        leadingIcon: const Icon(
          Icons.new_releases,
          color: AppStyle.dark,
        ),
        trailingIcon: const Icon(
          Icons.chevron_right,
          color: AppStyle.dark,
        ),
        menuChildren: [
          MenuItemButton(
            leadingIcon: const Icon(
              Icons.code,
              color: AppStyle.dark,
            ),
            child: const Text("新建代码文件"),
            onPressed: () {
              dismiss();
            },
          )
        ],
        child: const Text("新建"),
      ),
    ];
  }
}
