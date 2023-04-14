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
    deletable: false);

ApplicationDetails recycleDetails = ApplicationDetails(
    uuid: const Uuid().v1(),
    xmax: 700,
    ymax: 500,
    name: SystemConfig.sRecycle,
    needsTaskbarDisplay: true,
    iconUrl: "assets/images/appicons/recycle.png",
    deletable: false);

ApplicationDetails appManagementDetails = ApplicationDetails(
    uuid: const Uuid().v1(),
    xmax: 700,
    ymax: 500,
    name: SystemConfig.sAppManagement,
    needsTaskbarDisplay: false,
    needsTrayDisplay: true,
    iconUrl: "assets/images/appicons/management.png",
    deletable: false);
