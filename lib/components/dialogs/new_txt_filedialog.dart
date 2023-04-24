// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_desktop/bridge/native.dart';
import 'package:flutter_desktop/components/app_style.dart';
import 'package:flutter_desktop/platform/operation_logger.dart';
import 'package:provider/provider.dart';

import '../applications/application_controller.dart';
import '../desktop/desktop_controller.dart';
import 'dialog.dart';
import 'dialog_details.dart';

CustomDialog newTxtFileDialog(DialogDetails details) {
  return CustomDialog(
    uuid: details.uuid,
    name: details.name,
    child: NewTxtFileDialog(
      uuid: details.uuid,
    ),
  );
}

class NewTxtFileDialog extends StatelessWidget with OperationLoggerMixin {
  NewTxtFileDialog({super.key, required this.uuid});
  final String uuid;
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Material(
      child: BaseDialog(
          title: "新建文本",
          content: Container(
            height: 80,
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "名称",
                  style: TextStyle(
                      color: Color.fromARGB(255, 58, 58, 58), fontSize: 12),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 5),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 218, 223, 229)),
                      borderRadius: BorderRadius.circular(5)),
                  height: 21,
                  width: 280,
                  child: TextField(
                    style: const TextStyle(fontSize: 12),
                    controller: textController,
                    decoration: const InputDecoration(
                      hintText: "请输入文件名",
                      border: InputBorder.none,
                    ),
                  ),
                )
              ],
            ),
          ),
          buttons: [
            InkWell(
                onTap: () {
                  context.read<DesktopController>().removeWidget(uuid);
                  context.read<ApplicationController>().removeDetail(uuid);
                },
                child: Container(
                  width: 73,
                  height: 21,
                  padding: const EdgeInsets.only(bottom: 1),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: AppStyle.appBlue2),
                      borderRadius: BorderRadius.circular(7)),
                  child: Center(
                    child: Text(
                      "取消",
                      style: TextStyle(color: AppStyle.appBlue2, fontSize: 12),
                    ),
                  ),
                )),
            const SizedBox(
              width: 20,
            ),
            InkWell(
                onTap: () async {
                  if (textController.text == "") {
                    return;
                  }
                  await api.createNewTxt(
                      filename: textController.text,
                      openWith: SystemConfig.sEditor,
                      folderId: 0);
                  await log(content: "创建新文本");
                  await context.read<DesktopController>().getEntries();
                  context.read<DesktopController>().removeWidget(uuid);
                  context.read<ApplicationController>().removeDetail(uuid);
                },
                child: Container(
                  padding: const EdgeInsets.only(bottom: 1),
                  width: 73,
                  height: 21,
                  decoration: BoxDecoration(
                      color: AppStyle.appBlue2,
                      borderRadius: BorderRadius.circular(7)),
                  child: const Center(
                    child: Text(
                      "确定",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                )),
          ]),
    );
  }
}

class BaseDialog extends StatefulWidget {
  const BaseDialog(
      {Key? key,
      this.onCancelButtonClicked,
      this.onOkButtonClicked,
      required this.title,
      required this.content,
      required this.buttons})
      : super(key: key);
  final VoidCallback? onCancelButtonClicked;
  final VoidCallback? onOkButtonClicked;
  final String title;
  final Widget content;
  final List<Widget> buttons;

  @override
  State<BaseDialog> createState() => _BaseDialogState();
}

class _BaseDialogState extends State<BaseDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [widget.content, _buildButtons()],
      ),
    );
  }

  Widget _buildButtons() {
    return Container(
      padding: const EdgeInsets.only(right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: widget.buttons,
      ),
    );
  }
}
