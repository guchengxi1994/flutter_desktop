import 'package:flutter_desktop/components/applications/application_details.dart';

import '../../app_style.dart';

ApplicationDetails typingGameDetails = ApplicationDetails(
    uuid: "system-typing-game",
    xmax: 1000,
    ymax: 600,
    name: SystemConfig.sTypingGame,
    needsTaskbarDisplay: true,
    needsTrayDisplay: false,
    iconUrl: "assets/images/appicons/typing.png",
    deletable: false,
    resizable: false,
    openWith: SystemConfig.sTypingGame);
