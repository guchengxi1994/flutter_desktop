import 'package:flutter/material.dart';
import 'package:flutter_desktop/components/applications/_system_applications/details.dart'
    show myComputerDetails;
import 'package:flutter_desktop/components/applications/application.dart';
import 'package:package_info_plus/package_info_plus.dart';

Application myComputerApplication() {
  return Application(
    uuid: myComputerDetails.uuid,
    name: myComputerDetails.name ?? myComputerDetails.openWith,
    child: const MyComputerForm(),
  );
}

class MyComputerForm extends StatefulWidget {
  const MyComputerForm({super.key});

  @override
  State<MyComputerForm> createState() => _MyComputerFormState();
}

class _MyComputerFormState extends State<MyComputerForm> {
  String appName = "";
  String version = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      setState(() {
        appName = packageInfo.appName;
        version = packageInfo.version;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: myComputerDetails.xmax - myComputerDetails.xmin,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: const Text(
                "Flutter Desktop",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Text.rich(TextSpan(children: [
              const TextSpan(
                  text: "Version : ",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: version)
            ])),
            Image.asset("assets/changelog/changelog.png")
          ],
        ),
      ),
    );
  }
}
