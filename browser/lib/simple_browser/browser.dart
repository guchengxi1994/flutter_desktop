// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:browser/simple_browser/browser_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'package:webview_windows/webview_windows.dart';

final navigatorKey = GlobalKey<NavigatorState>();

typedef LoadIsFav = Future<bool> Function(String);
typedef SetAsFav = Function(String);

class BrowserWidget extends StatefulWidget {
  const BrowserWidget(
      {super.key,
      this.onError,
      this.loadIsFav,
      this.setAsFav,
      this.onUrlChanged,
      required this.onHistoryClicked});
  final VoidCallback? onError;
  final LoadIsFav? loadIsFav;
  final SetAsFav? setAsFav;
  final OnUrlChanged? onUrlChanged;
  final VoidCallback onHistoryClicked;

  @override
  State<BrowserWidget> createState() => _BrowserWidget();
}

class _BrowserWidget extends State<BrowserWidget> {
  late final BrowserController bc;
  final _textController = TextEditingController();
  late bool isFav = false;

  @override
  void initState() {
    super.initState();
    bc = BrowserController(
      onUrlChanged: (p0) async {
        _textController.text = p0;
        if (widget.onUrlChanged != null) {
          widget.onUrlChanged!(p0);
        }

        if (widget.loadIsFav != null) {
          isFav = await widget.loadIsFav!(p0);
          setState(() {});
        }
      },
    );
    initPlatformState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> initPlatformState() async {
    try {
      await bc.initPlatformState();
      if (!mounted) return;
      setState(() {});
    } on PlatformException catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (widget.onError == null) {
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                    title: const Text('Error'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Code: ${e.code}'),
                        Text('Message: ${e.message}'),
                      ],
                    ),
                    actions: [
                      TextButton(
                        child: const Text('Continue'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  ));
        } else {
          widget.onError!();
        }
      });
    }
  }

  Widget compositeView() {
    if (!bc.controller.value.isInitialized) {
      return const Text(
        'Not Initialized',
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Card(
              elevation: 0,
              child: SizedBox(
                height: 50,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.chevron_left),
                        splashRadius: 20,
                        onPressed: () {
                          bc.back();
                        },
                      ),
                      Expanded(
                        child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: TextField(
                            decoration: const InputDecoration(
                              hintText: 'URL',
                              contentPadding: EdgeInsets.only(
                                  left: 20, bottom: 16, right: 20),
                              border: InputBorder.none,
                            ),
                            textAlignVertical: TextAlignVertical.center,
                            controller: _textController,
                            onSubmitted: (val) {
                              bc.controller.loadUrl(val);
                            },
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.refresh),
                        splashRadius: 20,
                        onPressed: () {
                          bc.controller.reload();
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.favorite_border,
                          color: isFav ? Colors.redAccent : Colors.black,
                        ),
                        splashRadius: 20,
                        onPressed: () {
                          // bc.controller.reload();
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.history,
                        ),
                        splashRadius: 20,
                        onPressed: () {
                          widget.onHistoryClicked();
                        },
                      ),
                    ]),
              ),
            ),
            Expanded(
                child: Card(
                    color: Colors.transparent,
                    elevation: 0,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Stack(
                      children: [
                        Webview(
                          bc.controller,
                          permissionRequested: _onPermissionRequested,
                        ),
                        StreamBuilder<LoadingState>(
                            stream: bc.controller.loadingState,
                            builder: (context, snapshot) {
                              if (snapshot.hasData &&
                                  snapshot.data == LoadingState.loading) {
                                return const LinearProgressIndicator();
                              } else {
                                return const SizedBox();
                              }
                            }),
                      ],
                    ))),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: compositeView(),
      ),
    );
  }

  Future<WebviewPermissionDecision> _onPermissionRequested(
      String url, WebviewPermissionKind kind, bool isUserInitiated) async {
    final decision = await showDialog<WebviewPermissionDecision>(
      context: navigatorKey.currentContext!,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('WebView permission requested'),
        content: Text('WebView has requested permission \'$kind\''),
        actions: <Widget>[
          TextButton(
            onPressed: () =>
                Navigator.pop(context, WebviewPermissionDecision.deny),
            child: const Text('Deny'),
          ),
          TextButton(
            onPressed: () =>
                Navigator.pop(context, WebviewPermissionDecision.allow),
            child: const Text('Allow'),
          ),
        ],
      ),
    );

    return decision ?? WebviewPermissionDecision.none;
  }
}
