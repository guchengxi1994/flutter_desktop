import 'package:flutter/material.dart';
import 'package:flutter_desktop/components/applications/_system_applications/details.dart'
    show appManagementDetails;
import 'package:flutter_desktop/components/applications/application.dart';

Widget managementApplication() {
  return Application(
    uuid: appManagementDetails.uuid,
    name: appManagementDetails.name,
    child: const ManagementForm(),
  );
}

class ManagementForm extends StatefulWidget {
  const ManagementForm({super.key});

  @override
  State<ManagementForm> createState() => _ManagementFormState();
}

class _ManagementFormState extends State<ManagementForm> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("管理模块"),
    );
  }
}
