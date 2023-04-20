import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_desktop/components/applications/_system_applications/details.dart'
    show editorDetails;

import '../application.dart';

Application editorApplication() {
  return Application(
    uuid: editorDetails.uuid,
    name: editorDetails.name,
    resizable: false,
    child: const EditorForm(),
  );
}

class EditorForm extends StatefulWidget {
  const EditorForm({super.key});

  @override
  State<EditorForm> createState() => _EditorFormState();
}

class _EditorFormState extends State<EditorForm> {
  final editorState = EditorState.empty();

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
