// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_desktop/isar/browser_history.dart';
import 'package:flutter_desktop/isar/operation.dart';
import 'package:flutter_desktop/isar/practice.dart';
import 'package:flutter_desktop/platform/logger.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarDatabase {
  // ignore: avoid_init_to_null
  late Isar? isar = null;

  static final _instance = IsarDatabase._init();

  factory IsarDatabase() => _instance;

  IsarDatabase._init();

  late List<CollectionSchema<Object>> schemas = [
    BrowserHistorySchema,
    OperationSchema,
    PracticeSchema
  ];

  Future initialDatabase() async {
    if (isar != null && isar!.isOpen) {
      return;
    }
    final dir = await getApplicationSupportDirectory();
    logger.info("create database in ${dir.path}");

    isar = await Isar.open(
      schemas,
      name: "system",
      directory: dir.path,
    );
  }

  Future newLog(String content, String? result) async {
    await isar!.writeTxn(() async {
      await isar!.operations.put(Operation()
        ..content = content
        ..result = result);
    });
  }

  Future newBrowserHistory(String url) async {
    await isar!.writeTxn(() async {
      await isar!.browserHistorys.put(BrowserHistory()..url = url);
    });
  }

  Future<List<BrowserHistory>> fetchHistory(int pageId) async {
    return await isar!.browserHistorys
        .where()
        .offset((pageId - 1) * 10)
        .limit(10)
        .findAll();
  }

  Future delete3DaysAgoHistory() async {
    final now = DateTime.now();

    return await isar!.browserHistorys
        .filter()
        .createAtLessThan(
            now.subtract(const Duration(days: 3)).millisecondsSinceEpoch)
        .deleteAll();
  }

  Future<Practice?> getLastPractice() async {
    return await isar!.practices.where().sortByCreateAtDesc().findFirst();
  }

  Future updatePractice(int hit, int index, int id) async {
    final practice = await isar!.practices.where().idEqualTo(id).findFirst();
    if (practice != null) {
      practice.hit = hit;
      practice.current = index;
      await isar!.writeTxn(() async {
        await isar!.practices.put(practice);
      });
    }
  }

  Future newPractice() async {
    await isar!.writeTxn(() async {
      await isar!.practices.put(Practice());
    });
  }
}
