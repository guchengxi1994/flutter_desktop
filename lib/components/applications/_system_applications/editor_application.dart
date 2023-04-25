// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:io';

import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_desktop/components/utils.dart';

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

  saveFile(String? name) {
    if (editorState.document.isEmpty) {
      return;
    }
    final s = editorState.document.toJson();

    if (name == null) {
      File f = File(
          "${DevUtils.cacheTxtPath}/${DateTime.now().millisecondsSinceEpoch}.json");
      f.writeAsStringSync(json.encode(s));
    } else {
      File f = File("${DevUtils.cacheTxtPath}/$name");
      f.writeAsStringSync(json.encode(s));
    }
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
