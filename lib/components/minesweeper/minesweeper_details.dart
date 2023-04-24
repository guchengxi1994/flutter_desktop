import 'package:flutter_desktop/components/applications/application_details.dart';

import '../app_style.dart';

ApplicationDetails mineEasyDetails = ApplicationDetails(
    uuid: "system-minesweeper",
    xmax: 300,
    ymax: 350,
    name: SystemConfig.sMinesweeper,
    needsTaskbarDisplay: true,
    needsTrayDisplay: true,
    iconUrl: "assets/images/appicons/mine.png",
    deletable: false,
    resizable: false,
    openWith: SystemConfig.sMinesweeper);
