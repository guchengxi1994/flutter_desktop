import 'package:flutter/material.dart';
import 'package:flutter_desktop/bridge/native.dart';

class FileManagementController extends ChangeNotifier {
  List<FileOrFolder> l = [];
  getEntries() async {
    l = await api.getChildrenById(i: 0);
    notifyListeners();
  }

  remove(String type, int id) {
    l.removeWhere((element) {
      final r = element.map(file: (f) {
        if (type == "file") {
          if (f.field0.fileId == id) {
            return true;
          }
          return false;
        }
      }, folder: (f) {
        if (type == "folder") {
          if (f.field0.folderId == id) {
            return true;
          }
          return false;
        }
      });

      if (r != null) {
        return r;
      }
      return false;
    });

    notifyListeners();
  }
}
