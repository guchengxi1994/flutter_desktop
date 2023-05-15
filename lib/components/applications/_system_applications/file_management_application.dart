import 'package:flutter/material.dart';
import 'package:flutter_desktop/components/applications/_system_applications/details.dart'
    show fileManagementDetails;
import 'package:flutter_desktop/components/applications/_system_applications/system_application_builder.dart';
import 'package:flutter_desktop/components/applications/application.dart';
import 'package:provider/provider.dart';

import '../../../bridge/native.dart';
import '../../app_style.dart';

class FileManagementController extends ChangeNotifier {
  List<FileOrFolder> l = [];
  getEntries() async {
    l = await api.getChildrenById(i: 0);
    notifyListeners();
  }
}

Application fileManagementApplication() {
  return Application(
    uuid: fileManagementDetails.uuid,
    name: fileManagementDetails.name ?? fileManagementDetails.openWith,
    child: ChangeNotifierProvider(
      create: (_) => FileManagementController()..getEntries(),
      builder: (context, child) {
        return const FileManagementForm();
      },
    ),
  );
}

class FileManagementForm extends StatefulWidget {
  const FileManagementForm({super.key});

  @override
  State<FileManagementForm> createState() => _FileManagementFormState();
}

class _FileManagementFormState extends State<FileManagementForm> {
  @override
  Widget build(BuildContext context) {
    final l = context.watch<FileManagementController>().l;

    return Wrap(
      runSpacing: 20,
      spacing: 20,
      children: l.map((e) {
        return e.map(file: (f) {
          switch (f.field0.openWith) {
            case SystemConfig.sEditor:
              return SystemApplicationBuilder.txtAppBuild(
                  context, f.field0.realPath, f.field0.virtualPath);

            default:
              return Container();
          }
        }, folder: (f) {
          return Container();
        });
      }).toList(),
    );
  }
}
