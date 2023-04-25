import 'package:flutter/material.dart';

import 'dialog.dart';
import 'dialog_details.dart';

CustomDialog shutdownDialog(DialogDetails details) {
  return CustomDialog(
    uuid: details.uuid,
    name: details.name ?? details.openWith,
    child: ShutdownDialog(
      onCancel: details.onCancel,
      onSubmit: details.onSubmit,
    ),
  );
}

class ShutdownDialog extends StatelessWidget {
  const ShutdownDialog({super.key, this.onCancel, this.onSubmit});
  final OnSubmit? onSubmit;
  final OnCancel? onCancel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text("是否关机?"),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text("关机将导致未保存的内容丢失。"),
        ),
        const SizedBox(
          height: 40,
        ),
        Row(
          children: [
            const Expanded(child: SizedBox()),
            ElevatedButton(
                onPressed: () {
                  if (onCancel != null) {
                    onCancel!();
                  }
                },
                child: const Text("取消")),
            const SizedBox(
              width: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  if (onSubmit != null) {
                    onSubmit!();
                  }
                },
                child: const Text("确定")),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
      ],
    );
  }
}
