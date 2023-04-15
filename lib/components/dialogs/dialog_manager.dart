// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_desktop/components/applications/application_controller.dart';
import 'package:flutter_desktop/components/desktop/desktop_controller.dart';
import 'package:flutter_desktop/platform/operation_logger.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

import 'dialog_details.dart';
import 'shutdown_dialog.dart';

class DialogManager {
  DialogManager._();
  static const shutdownUuid = "shutdown-system-unique-uuid";

  static showShutdownDialog(BuildContext ctx) {
    DialogDetails shutdownDialogDetails = DialogDetails(
      uuid: shutdownUuid,
      name: "警告",
      xmax: 500,
      xmin: 200,
      ymax: 350,
      ymin: 200,
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
}
