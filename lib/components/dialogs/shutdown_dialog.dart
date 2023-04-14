import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'dialog_details.dart';

DialogDetails shutdownDialogDetails = DialogDetails(
    uuid: const Uuid().v1(),
    name: "警告",
    icon: const Icon(
      Icons.warning,
      color: Colors.yellow,
    ),
    onWindowClose: () {
      return 0;
    });
