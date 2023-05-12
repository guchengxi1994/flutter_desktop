// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_desktop/components/applications/application_controller.dart';
import 'package:flutter_desktop/components/desktop/desktop_controller.dart';
import 'package:flutter_desktop/platform/operation_logger.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

import '../routers.dart';
import 'dialog_details.dart';
import 'new_txt_filedialog.dart';
import 'shutdown_dialog.dart';

enum DialogPosition {
  topLeft,
  topRight,
  topCenter,
  center,
  medianLeft,
  medianRight,
  bottomLeft,
  bottomCenter,
  bottomRight
}

extension DialogPositionExtension on DialogPosition {
  (double xmax, double xmin, double ymax, double min) getPosition(
      BuildContext ctx,
      {required Size defaultSize,
      Offset? custom}) {
    if (custom != null) {
      return (
        custom.dx + defaultSize.width,
        custom.dx,
        custom.dy + defaultSize.height,
        custom.dy
      );
    }

    RenderBox? box = ctx.findRenderObject() as RenderBox?;
    final Size size;

    if (box != null) {
      size = box.size;
    } else {
      size = const Size(1280, 720);
    }

    switch (this) {
      case DialogPosition.topLeft:
        return (defaultSize.width, 0, defaultSize.height, 0);
      case DialogPosition.topRight:
        return (
          size.width,
          size.width - defaultSize.width,
          defaultSize.height,
          0
        );
      case DialogPosition.topCenter:
        final center = 0.5 * (size.width + defaultSize.width);

        return (center, center - defaultSize.width, defaultSize.height, 0);
      case DialogPosition.center:
        final centerH = 0.5 * (size.width + defaultSize.width);
        final centerV = 0.5 * (size.height + defaultSize.height);
        return (
          centerH,
          centerH - defaultSize.width,
          centerV,
          centerV - defaultSize.height
        );
      case DialogPosition.medianLeft:
        final centerV = 0.5 * (size.height + defaultSize.height);
        return (defaultSize.width, 0, centerV, centerV - defaultSize.height);
      case DialogPosition.medianRight:
        final centerV = 0.5 * (size.height + defaultSize.height);
        return (
          size.width,
          size.width - defaultSize.width,
          centerV,
          centerV - defaultSize.height
        );
      case DialogPosition.bottomLeft:
        return (
          defaultSize.width,
          0,
          size.height,
          size.height - defaultSize.height
        );
      case DialogPosition.bottomCenter:
        final centerH = 0.5 * (size.width + defaultSize.width);
        return (
          centerH,
          centerH - defaultSize.width,
          size.height,
          size.height - defaultSize.height
        );
      case DialogPosition.bottomRight:
        return (
          size.width,
          size.width - defaultSize.width,
          size.height,
          size.height - defaultSize.height
        );
      default:
        return (defaultSize.width, 0, defaultSize.height, 0);
    }
  }
}

class DialogManager {
  DialogManager._();
  static const shutdownUuid = "shutdown-system-unique-uuid";
  static const newTxtUuid = "new-txt-system-unique-uuid";

  static showShutdownDialog(
    BuildContext ctx,
  ) {
    const p = DialogPosition.topRight;

    final r = p.getPosition(ctx, defaultSize: const Size(300, 150));

    double xmax = r.$1;
    double xmin = r.$2;
    double ymax = r.$3;
    double ymin = r.$4;

    DialogDetails shutdownDialogDetails = DialogDetails(
      uuid: shutdownUuid,
      name: "警告",
      openWith: "警告",
      xmax: xmax,
      xmin: xmin,
      ymax: ymax,
      ymin: ymin,
      multiple: false,
      icon: const Icon(
        Icons.warning,
        color: Colors.yellow,
      ),
      onSubmit: () async {
        try {
          await OperationLogger.logger(content: "关机");
          ctx.read<DesktopController>().removeWidget(shutdownUuid);
          ctx.read<ApplicationController>().removeDetail(shutdownUuid);
          Navigator.of(ctx).pop();
          await windowManager.destroy();
        } catch (_) {
          await OperationLogger.logger(content: "关机", result: "关机失败,无法获取ctx");
        }
      },
      onCancel: () async {
        try {
          await OperationLogger.logger(content: "取消关机");
          ctx.read<DesktopController>().removeWidget(shutdownUuid);
          ctx.read<ApplicationController>().removeDetail(shutdownUuid);
        } catch (_) {
          await OperationLogger.logger(
              content: "取消关机", result: "取消关机失败,无法获取ctx");
        }
      },
    );

    final exists =
        ctx.read<ApplicationController>().exists(shutdownDialogDetails.uuid);
    if (!exists) {
      ctx.read<ApplicationController>().addDetail(shutdownDialogDetails);
      ctx
          .read<DesktopController>()
          .addApplication(shutdownDialog(shutdownDialogDetails));
    }
  }

  static showCreateNewTxtFileDialog(BuildContext ctx) {
    const p = DialogPosition.center;
    final r = p.getPosition(ctx, defaultSize: const Size(350, 150));

    DialogDetails newTxtDetails = DialogDetails(
      uuid: newTxtUuid,
      name: "创建新的文本",
      openWith: "创建新的文本",
      xmax: r.$1,
      xmin: r.$2,
      ymax: r.$3,
      ymin: r.$4,
      multiple: false,
      icon: const Icon(
        Icons.file_present,
        color: Colors.yellow,
      ),
      onSubmit: () async {},
      onCancel: () async {},
    );
    var c = Routers.desktopKey.currentContext ?? ctx;
    final exists = c.read<ApplicationController>().exists(newTxtDetails.uuid);
    if (!exists) {
      c.read<ApplicationController>().addDetail(newTxtDetails);
      c
          .read<DesktopController>()
          .addApplication(newTxtFileDialog(newTxtDetails));
    }
  }
}
