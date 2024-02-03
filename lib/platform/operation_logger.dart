import 'package:flutter_desktop/src/rust/api/simple.dart' as api;

class OperationLogger {
  OperationLogger._();

  static Future logger({required String content, String? result}) async {
    api.newLog(content: content, result: result);
  }
}

mixin OperationLoggerMixin {
  Future log({required String content, String? result}) async {
    OperationLogger.logger(content: content, result: result);
  }
}
