import 'package:flutter_desktop/components/applications/application_details.dart';

import '../../app_style.dart';

ApplicationDetails typingGamePracticeDetails = ApplicationDetails(
    uuid: "system-typing-game-practice",
    xmax: 800,
    ymax: 500,
    name: SystemConfig.sTypingGameLearning,
    needsTaskbarDisplay: true,
    needsTrayDisplay: false,
    iconUrl: "assets/images/appicons/typing.png",
    deletable: false,
    resizable: false,
    openWith: SystemConfig.sTypingGameLearning);
