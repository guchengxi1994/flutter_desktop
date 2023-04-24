import 'package:flutter/material.dart';
import 'package:flutter_desktop/components/app_style.dart';
import 'package:flutter_desktop/components/applications/_system_applications/audio_player_application.dart';
import 'package:flutter_desktop/components/applications/_system_applications/editor_application.dart';
import 'package:flutter_desktop/components/applications/_system_applications/game_center_application.dart';
import 'package:flutter_desktop/components/applications/_system_applications/management_application.dart';
import 'package:flutter_desktop/components/applications/_system_applications/my_computer_application.dart';
import 'package:flutter_desktop/components/applications/_system_applications/recycle_application.dart';
import 'package:flutter_desktop/components/applications/_system_applications/video_player_application.dart';
import 'package:flutter_desktop/components/applications/application_entry.dart';
import 'package:flutter_desktop/components/desktop/desktop_controller.dart';
import 'package:flutter_desktop/components/minesweeper/mine_application.dart';
import 'package:flutter_desktop/components/taskbar/taskbar_controller.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../application_controller.dart';
import '../application_details.dart';

class SystemApplicationBuilder {
  SystemApplicationBuilder._();

  static Widget txtAppBuild(BuildContext ctx, String realPath, String name) {
    ApplicationDetails txtDetails = ApplicationDetails(
        uuid: const Uuid().v1(),
        xmax: 1100,
        ymax: 500,
        name: name,
        needsTaskbarDisplay: true,
        needsTrayDisplay: false,
        iconUrl: "assets/images/appicons/txt.png",
        deletable: true);
    return ApplicationEntry(
        details: txtDetails,
        onDoubleClick: () async {
          final exists =
              ctx.read<ApplicationController>().exists(txtDetails.uuid);
          if (!exists) {
            ctx.read<ApplicationController>().addDetail(txtDetails);
          }
        });
  }

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
            case SystemConfig.sAudioPlayer:
              ctx
                  .read<DesktopController>()
                  .addApplication(audioPlayerApplication(), exists: exists);
              break;
            case SystemConfig.sVideoPlayer:
              ctx
                  .read<DesktopController>()
                  .addApplication(videoPlayerApplication(), exists: exists);
              break;
            case SystemConfig.sEditor:
              ctx
                  .read<DesktopController>()
                  .addApplication(editorApplication(), exists: exists);
              break;
            case SystemConfig.sGameCenter:
              ctx
                  .read<DesktopController>()
                  .addApplication(gameCenterApplication(), exists: exists);
              break;
            case SystemConfig.sMinesweeper:
              ctx
                  .read<DesktopController>()
                  .addApplication(minesweeperApplication(), exists: exists);
              break;
            default:
              break;
          }
        });
  }
}
