// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_desktop/components/app_style.dart';
import 'package:flutter_desktop/components/applications/application_controller.dart';
import 'package:flutter_desktop/components/desktop/desktop_controller.dart';
import 'package:provider/provider.dart';

import 'application_details.dart';

const double pointSize = 20;

class Application extends StatelessWidget {
  Application(
      {super.key,
      required this.child,
      this.needsTaskbarDisplay = false,
      this.needsTrayDisplay = false,
      required this.uuid,
      this.name = "窗口"});
  final Widget child;

  final String uuid;
  final String name;

  final bool needsTaskbarDisplay;

  final bool needsTrayDisplay;

  late ApplicationDetails appDetails;

  @override
  Widget build(BuildContext context) {
    appDetails = context.watch<ApplicationController>().getDetailsById(uuid) ??
        ApplicationDetails(uuid: uuid, name: name);

    return Positioned(
        left: appDetails.xmin,
        top: appDetails.ymin,
        child: GestureDetector(
          onTapUp: (details) {
            context.read<DesktopController>().setFocusedUuid(uuid);
          },
          onPanUpdate: (details) {
            context
                .read<ApplicationController>()
                .changeApplicationPosition(uuid, details);
          },
          child: SizedBox(
            height: appDetails.ymax - appDetails.ymin,
            width: appDetails.xmax - appDetails.xmin,
            child: Stack(
              children: [
                _childWrapper(child, context),
                Positioned(
                    left: 0,
                    top: 0,
                    child: MouseRegion(
                      cursor: SystemMouseCursors.resizeUpLeft,
                      child: GestureDetector(
                        onPanUpdate: (details) {
                          context
                              .read<ApplicationController>()
                              .changeApplicationByLeftTopPosition(
                                  uuid, details);
                        },
                        child: Container(
                          width: pointSize,
                          height: pointSize,
                          color: Colors.transparent,
                        ),
                      ),
                    )),
                // right top
                // Positioned(
                //     right: 0,
                //     top: 0,
                //     child: MouseRegion(
                //         cursor: SystemMouseCursors.resizeDownLeft,
                //         child: GestureDetector(
                //           onPanUpdate: (details) {
                //             context
                //                 .read<ApplicationController>()
                //                 .changeApplicationByRightTopPosition(
                //                     uuid, details);
                //           },
                //           child: Container(
                //             width: pointSize,
                //             height: pointSize,
                //             color: Colors.transparent,
                //           ),
                //         ))),
                // left bottom
                Positioned(
                    left: 0,
                    bottom: 0,
                    child: MouseRegion(
                        cursor: SystemMouseCursors.resizeDownLeft,
                        child: GestureDetector(
                          onPanUpdate: (details) {
                            context
                                .read<ApplicationController>()
                                .changeApplicationByLeftBottomPosition(
                                    uuid, details);
                          },
                          child: Container(
                            width: pointSize,
                            height: pointSize,
                            color: Colors.transparent,
                          ),
                        ))),
                // right bottom
                Positioned(
                    right: 0,
                    bottom: 0,
                    child: MouseRegion(
                        cursor: SystemMouseCursors.resizeUpLeft,
                        child: GestureDetector(
                          onPanUpdate: (details) {
                            context
                                .read<ApplicationController>()
                                .changeApplicationByRightBottomPosition(
                                    uuid, details);
                          },
                          child: Container(
                            width: pointSize,
                            height: pointSize,
                            color: Colors.transparent,
                          ),
                        ))),
              ],
            ),
          ),
        ));
  }

  Widget _childWrapper(Widget child, BuildContext ctx) {
    return Container(
      height: appDetails.ymax - appDetails.ymin,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppStyle.light2,
          border: Border.all(color: AppStyle.dark, width: 1.5)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(color: AppStyle.grey),
            height: 30,
            width: appDetails.xmax - appDetails.xmin,
            child: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: AppStyle.appbarIconSize,
                  height: AppStyle.appbarIconSize,
                  child: appDetails.icon!,
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                    child: Text(
                  appDetails.name,
                  softWrap: true,
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                )),
                InkWell(
                  onTap: () {
                    ctx.read<ApplicationController>().removeDetail(uuid);
                    ctx.read<DesktopController>().removeWidget(uuid);
                  },
                  child: Icon(
                    Icons.close,
                    color: AppStyle.dark,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
            padding: const EdgeInsets.all(5),
            child: child,
          ))
        ],
      ),
    );
  }
}

class ApplicationOnTaskbar extends StatelessWidget {
  const ApplicationOnTaskbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ApplicationOnTray extends StatelessWidget {
  const ApplicationOnTray({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
