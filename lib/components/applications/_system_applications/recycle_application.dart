import 'package:flutter/material.dart';
import 'package:flutter_desktop/components/applications/_system_applications/details.dart'
    show recycleDetails;
import 'package:flutter_desktop/components/applications/application.dart';

Widget recycleApplication() {
  return Application(
    uuid: recycleDetails.uuid,
    name: recycleDetails.name,
    child: const RecycleForm(),
  );
}

class RecycleForm extends StatefulWidget {
  const RecycleForm({super.key});

  @override
  State<RecycleForm> createState() => _RecycleFormState();
}

class _RecycleFormState extends State<RecycleForm> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("这是回收站"),
    );
  }
}
