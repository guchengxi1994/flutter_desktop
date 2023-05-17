// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_desktop/components/app_style.dart';
import 'package:flutter_desktop/components/applications/_system_applications/details.dart'
    show recycleDetails;
import 'package:flutter_desktop/components/applications/_system_applications/system_application_builder.dart';
import 'package:flutter_desktop/components/applications/application.dart';
import 'package:flutter_desktop/components/context_menu/recycle_context_menu.dart';
import 'package:provider/provider.dart';

import '../../../bridge/native.dart';
import '../file_management_controller.dart';

Application recycleApplication() {
  return Application(
    uuid: recycleDetails.uuid,
    name: recycleDetails.name ?? recycleDetails.openWith,
    child: const RecycleForm(),
  );
}

class RecycleForm extends StatefulWidget {
  const RecycleForm({super.key});

  @override
  State<RecycleForm> createState() => _RecycleFormState();
}

class _RecycleFormState extends State<RecycleForm>
    with RecycleContextMenuMixin {
  @override
  Widget build(BuildContext context) {
    final l = context.watch<FileManagementController>().l;
    return SizedBox(
      width: recycleDetails.xmax - recycleDetails.xmin,
      height: recycleDetails.ymax - recycleDetails.ymin,
      child: Wrap(
        runSpacing: 20,
        spacing: 20,
        children: _buildChildren(l),
      ),
    );
  }

  List<Widget> _buildChildren(List<FileOrFolder> l) {
    List<Widget> w = [];
    for (final i in l) {
      final r = i.map(file: (f) {
        if (f.field0.isDeleted == 1) {
          switch (f.field0.openWith) {
            case SystemConfig.sEditor:
              return SystemApplicationBuilder.txtAppBuild(
                  context, f.field0.realPath, f.field0.virtualPath, (d) {
                showRecycleContextMenu(
                  d.globalPosition,
                  context,
                  onRestore: () async {
                    await api.restoreFile(id: f.field0.fileId);
                    await context.read<FileManagementController>().getEntries();
                  },
                );
              }, enabled: false);

            default:
              return Container();
          }
        }
      }, folder: (f) {
        /// TODO
        ///
        /// complete `Folder`
        return Container();
      });
      if (r != null) {
        w.add(r);
      }
    }

    return w;
  }
}
