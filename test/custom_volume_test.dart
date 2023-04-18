import 'package:flutter/material.dart';
import 'package:flutter_desktop/components/applications/_system_applications/widgets/volume_slider.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: CustomVolumeSliderWidget(
        onSliderChanged: (p0) {
          debugPrint(p0.toString());
        },
      )),
    );
  }
}
