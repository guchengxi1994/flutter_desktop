import 'package:flutter/material.dart';
import 'package:flutter_desktop/components/applications/_system_applications/details.dart'
    show myComputerDetails;
import 'package:flutter_desktop/components/applications/application.dart';

Application myComputerApplication() {
  return Application(
    uuid: myComputerDetails.uuid,
    name: myComputerDetails.name,
    child: const MyComputerForm(),
  );
}

class MyComputerForm extends StatefulWidget {
  const MyComputerForm({super.key});

  @override
  State<MyComputerForm> createState() => _MyComputerFormState();
}

class _MyComputerFormState extends State<MyComputerForm> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("这是我的电脑"),
    );
  }
}
