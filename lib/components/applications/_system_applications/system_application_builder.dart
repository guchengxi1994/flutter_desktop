import 'package:flutter/material.dart';
import 'package:flutter_desktop/components/app_style.dart';
import 'package:flutter_desktop/components/applications/_system_applications/management_application.dart';
import 'package:flutter_desktop/components/applications/_system_applications/my_computer_application.dart';
import 'package:flutter_desktop/components/applications/_system_applications/recycle_application.dart';
import 'package:flutter_desktop/components/applications/application_entry.dart';
import 'package:flutter_desktop/components/desktop/desktop_controller.dart';
import 'package:flutter_desktop/components/taskbar/taskbar_controller.dart';
import 'package:provider/provider.dart';

import '../application_controller.dart';
import '../application_details.dart';

class SystemApplicationBuilder {
  SystemApplicationBuilder._();

  static Widget build(BuildContext ctx, ApplicationDetails details) {
    return ApplicationEntry(
        details: details,
        onDoubleClick: () {
          final exists = ctx.read<ApplicationController>().exists(details.uuid);
          if (!exists) {
            ctx.read<ApplicationController>().addDetail(details);
          }

          if (details.needsTaskbarDisplay) {
            ctx.read<TaskbarController>().addDetails(details, exists: exists);
          }

          switch (details.name) {
            case SystemConfig.sRecycle:
              ctx
                  .read<DesktopController>()
                  .addApplication(recycleApplication(), exists: exists);

              break;
            case SystemConfig.sMyComputer:
              ctx
                  .read<DesktopController>()
                  .addApplication(myComputerApplication(), exists: exists);
              break;
            case SystemConfig.sAppManagement:
              ctx
                  .read<DesktopController>()
                  .addApplication(managementApplication(), exists: exists);
              break;
            default:
              break;
          }
        });
  }
}
