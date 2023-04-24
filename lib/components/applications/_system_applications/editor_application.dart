// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:io';

import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_desktop/components/applications/_system_applications/details.dart'
    show editorDetails;
import 'package:flutter_desktop/components/utils.dart';

import '../application.dart';

Application editorApplication() {
  final GlobalKey<_EditorFormState> globalKey = GlobalKey();
  return Application(
    uuid: editorDetails.uuid,
    name: editorDetails.name,
    resizable: false,
    onClose: () {
      globalKey.currentState!.saveFile();
    },
    child: EditorForm(
      key: globalKey,
      text: "",
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
  late final EditorState editorState;
  @override
  void initState() {
    super.initState();
    if (widget.text == "") {
      editorState = EditorState(
          document: Document.fromJson({
        'document': {
          "type": "editor",
          "children": [
            {"type": "text", "delta": []}
          ]
        }
      }));
    } else {
      editorState =
          EditorState(document: Document.fromJson(jsonDecode(widget.text)));
    }
  }

  saveFile() {
    final s = editorState.document.toJson();
    File f = File(
        "${DevUtils.cacheTxtPath}/${DateTime.now().millisecondsSinceEpoch}.json");
    f.writeAsStringSync(json.encode(s));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      width: 1100,
      child: AppFlowyEditor(
        editorState: editorState,
      ),
    );
  }
}
