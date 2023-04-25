import 'package:flutter_desktop/components/app_style.dart';
import 'package:flutter_desktop/components/applications/application_details.dart';
import 'package:uuid/uuid.dart';

ApplicationDetails myComputerDetails = ApplicationDetails(
    uuid: const Uuid().v1(),
    xmax: 600,
    ymax: 400,
    name: SystemConfig.sMyComputer,
    iconUrl: "assets/images/appicons/computer.png",
    needsTaskbarDisplay: true,
    deletable: false,
    openWith: SystemConfig.sMyComputer);

ApplicationDetails recycleDetails = ApplicationDetails(
    uuid: const Uuid().v1(),
    xmax: 700,
    ymax: 500,
    name: SystemConfig.sRecycle,
    needsTaskbarDisplay: true,
    iconUrl: "assets/images/appicons/recycle.png",
    deletable: false,
    openWith: SystemConfig.sRecycle);

ApplicationDetails appManagementDetails = ApplicationDetails(
    uuid: const Uuid().v1(),
    xmax: 700,
    ymax: 500,
    name: SystemConfig.sAppManagement,
    needsTaskbarDisplay: false,
    needsTrayDisplay: true,
    iconUrl: "assets/images/appicons/management.png",
    deletable: false,
    openWith: SystemConfig.sAppManagement);

ApplicationDetails editorDetails = ApplicationDetails(
  uuid: const Uuid().v1(),
  xmax: 1100,
  ymax: 500,
  name: null,
  needsTaskbarDisplay: true,
  needsTrayDisplay: false,
  iconUrl: "assets/images/appicons/editor.png",
  deletable: false,
  openWith: SystemConfig.sEditor,
);

ApplicationDetails audioPlayerDetails = ApplicationDetails(
    uuid: const Uuid().v1(),
    xmax: 300,
    ymax: 400,
    name: SystemConfig.sAudioPlayer,
    needsTaskbarDisplay: true,
    needsTrayDisplay: true,
    iconUrl: "assets/images/appicons/player.png",
    deletable: false,
    resizable: false,
    openWith: SystemConfig.sAudioPlayer);

ApplicationDetails videoPlayerDetails = ApplicationDetails(
    uuid: const Uuid().v1(),
    xmax: 800,
    ymax: 600,
    name: SystemConfig.sVideoPlayer,
    needsTaskbarDisplay: true,
    needsTrayDisplay: true,
    iconUrl: "assets/images/appicons/video_player.png",
    deletable: false,
    resizable: false,
    openWith: SystemConfig.sVideoPlayer);

ApplicationDetails gameCenterDetails = ApplicationDetails(
    uuid: const Uuid().v1(),
    xmax: 800,
    ymax: 600,
    name: SystemConfig.sGameCenter,
    needsTaskbarDisplay: true,
    needsTrayDisplay: true,
    iconUrl: "assets/images/appicons/game.png",
    deletable: false,
    resizable: false,
    openWith: SystemConfig.sGameCenter);
