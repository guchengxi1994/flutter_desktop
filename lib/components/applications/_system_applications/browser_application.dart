// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:browser/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_desktop/bridge/native.dart';

import '../application.dart';
import 'details.dart' show browserDetails;

Application browserApplication() {
  return Application(
    resizable: browserDetails.resizable,
    uuid: browserDetails.uuid,
    name: browserDetails.name ?? browserDetails.openWith,
    child: const _BrowserForm(),
  );
}

class _BrowserForm extends StatefulWidget {
  const _BrowserForm();

  @override
  State<_BrowserForm> createState() => __BrowserFormState();
}

class __BrowserFormState extends State<_BrowserForm> {
  var initial;

  @override
  void initState() {
    super.initState();
    initial = initialBrowser();
  }

  Future initialBrowser() async {
    await api.delete3DaysAgoHistory();
  }

  Navigator get buildNavigator {
    return Navigator(
      initialRoute: "/",
      onGenerateRoute: (settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case 'history':
            builder = (context) => BrowserHistoryWidget(
                  fetchData: (i) async {
                    print(i);
                    return [];
                  },
                );
            break;
          default:
            builder = (context) => FutureBuilder(
                  future: initial,
                  builder: (c, s) {
                    if (s.connectionState == ConnectionState.done) {
                      return BrowserWidget(
                        onHistoryClicked: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return BrowserHistoryWidget(
                              fetchData: (i) async {
                                // print(i);
                                final s = await api.fetchHistory(page: i);

                                return s
                                    .map((e) => "${e.createAt}===>${e.url}")
                                    .toList();
                              },
                            );
                          }));
                        },
                        onUrlChanged: (p0) async {
                          await api.newBrowserHistory(s: p0);
                        },
                      );
                    } else {
                      return const Center(
                        child: Text("loading"),
                      );
                    }
                  },
                );
            break;
        }

        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1100,
      height: 550,
      child: buildNavigator,
    );
  }
}
