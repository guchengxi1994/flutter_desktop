import 'package:flutter/material.dart';
import 'package:flutter_desktop/components/applications/application_entry.dart';
import 'package:flutter_desktop/components/desktop/desktop_controller.dart';
import 'package:provider/provider.dart';

import '../application_controller.dart';
import 'details.dart';
import 'recyle_application.dart';

Widget recycleBuilder(BuildContext ctx) {
  return ApplicationEntry(
      details: recycleDetails,
      onDoubleClick: () {
        final exists =
            ctx.read<ApplicationController>().exists(recycleDetails.uuid);

        if (!exists) {
          ctx.read<ApplicationController>().addDetail(recycleDetails);
        }

        ctx
            .read<DesktopController>()
            .addApplication(recycleApplication(), exists: exists);
      });
}
