import 'package:flutter/material.dart';
import 'package:flutter_desktop/components/applications/application_controller.dart';
import 'package:flutter_desktop/components/applications/application_entry.dart';
import 'package:flutter_desktop/components/desktop/desktop_controller.dart';
import 'package:provider/provider.dart';

import 'details.dart';
import 'my_computer_application.dart';

Widget myComputerBuilder(BuildContext ctx) {
  return ApplicationEntry(
      details: myComputerDetails,
      onDoubleClick: () {
        debugPrint(myComputerDetails.uuid);
        final exists =
            ctx.read<ApplicationController>().exists(myComputerDetails.uuid);

        if (!exists) {
          ctx.read<ApplicationController>().addDetail(myComputerDetails);
        }

        ctx
            .read<DesktopController>()
            .addApplication(myComputerApplication(), exists: exists);
      });
}
