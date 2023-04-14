import 'dart:io';

class DevUtils {
  static Directory get executableDir =>
      File(Platform.resolvedExecutable).parent;
}
