import 'package:flutter_desktop/components/applications/application_details.dart';
import 'package:uuid/uuid.dart';

ApplicationDetails myComputerDetails = ApplicationDetails(
    uuid: const Uuid().v1(),
    xmax: 600,
    ymax: 400,
    name: "我的电脑",
    iconUrl: "assets/images/appicons/computer.png",
    deletable: false);

ApplicationDetails recycleDetails = ApplicationDetails(
    uuid: const Uuid().v1(),
    xmax: 700,
    ymax: 500,
    name: "回收站",
    iconUrl: "assets/images/appicons/recycle.png",
    deletable: false);
