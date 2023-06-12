// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_desktop/components/applications/_system_applications/details.dart'
    show fileManagementDetails;
import 'package:flutter_desktop/components/applications/_system_applications/system_application_builder.dart';
import 'package:flutter_desktop/components/applications/application.dart';
import 'package:flutter_desktop/components/context_menu/file_context_menu.dart';
import 'package:provider/provider.dart';

import '../../../bridge/native.dart';
import '../../app_style.dart';
import '../file_management_controller.dart';
import 'widgets/menu_entry.dart';

Application fileManagementApplication() {
  return Application(
    uuid: fileManagementDetails.uuid,
    name: fileManagementDetails.name ?? fileManagementDetails.openWith,
    child: const FileManagementForm(),
  );
}

class FileManagementForm extends StatefulWidget {
  const FileManagementForm({super.key});

  @override
  State<FileManagementForm> createState() => _FileManagementFormState();
}

class _FileManagementFormState extends State<FileManagementForm>
    with FileContextMenuMixin {
  @override
  Widget build(BuildContext context) {
    final l = context.watch<FileManagementController>().l;

    return SizedBox(
      width: fileManagementDetails.xmax - fileManagementDetails.xmin,
      height: fileManagementDetails.ymax - fileManagementDetails.ymin,
      child: Column(
        children: [
          SizedBox(
            height: 30,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: MenuBar(
                  children: MenuEntry.build(_getMenus()),
                ))
              ],
            ),
          ),
          const Divider(
            thickness: 3,
          ),
          Expanded(
              child: Wrap(
            runSpacing: 20,
            spacing: 20,
            children: _buildChildren(l),
          ))
        ],
      ),
    );
  }

  List<Widget> _buildChildren(List<FileOrFolder> l) {
    List<Widget> w = [];
    for (final i in l) {
      final r = i.map(file: (f) {
        if (f.field0.isDeleted == 0) {
          switch (f.field0.openWith) {
            case SystemConfig.sEditor:
              return SystemApplicationBuilder.txtAppBuild(
                  context, f.field0.realPath, f.field0.virtualPath, (d) {
                showFileContextMenu(
                  d.globalPosition,
                  context,
                  onDelete: () async {
                    await api.deleteFile(id: f.field0.fileId);
                    await context.read<FileManagementController>().getEntries();
                  },
                );
              });

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

  List<MenuEntry> _getMenus() {
    final List<MenuEntry> result = [
      MenuEntry(
        label: '导入...',
        menuChildren: <MenuEntry>[
          MenuEntry(
            label: '从外部系统导入...',
            onPressed: () {},
          ),
          MenuEntry(
            label: '从URL导入...',
            onPressed: () {},
          ),
        ],
      ),
    ];

    return result;
  }
}
