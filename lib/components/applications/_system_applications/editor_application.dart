// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../application.dart';
import '../application_details.dart';

Application editorApplication(String text, ApplicationDetails details) {
  final GlobalKey<_EditorFormState> globalKey = GlobalKey();
  return Application(
    uuid: details.uuid,
    name: details.name ?? details.openWith,
    resizable: false,
    onClose: () {
      globalKey.currentState!.saveFile(details.name);
    },
    child: EditorForm(
      key: globalKey,
      text: text,
    ),
  );
}

class EditorForm extends StatefulWidget {
  const EditorForm({super.key, required this.text});
  final String text;

  @override
  State<EditorForm> createState() => _EditorFormState();
}

class _EditorFormState extends State<EditorForm> {
  final QuillController _controller = QuillController.basic();
  @override
  void initState() {
    super.initState();
  }

  saveFile(String? name) {
    // if (editorState.document.isEmpty) {
    //   return;
    // }
    // final s = editorState.document.toJson();

    // if (name == null) {
    //   File f = File(
    //       "${DevUtils.cacheTxtPath}/${DateTime.now().millisecondsSinceEpoch}.json");
    //   f.writeAsStringSync(json.encode(s));
    // } else {
    //   File f = File("${DevUtils.cacheTxtPath}/$name");
    //   f.writeAsStringSync(json.encode(s));
    // }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      width: 1100,
      child: QuillEditor.basic(
        configurations: QuillEditorConfigurations(
          controller: _controller,
          readOnly: false,
          sharedConfigurations: const QuillSharedConfigurations(
            locale: Locale('zh-CN'),
          ),
        ),
      ),
    );
  }
}
