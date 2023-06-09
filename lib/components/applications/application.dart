// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_desktop/components/app_style.dart';
import 'package:flutter_desktop/components/applications/_system_applications/audio_player_application.dart';
import 'package:flutter_desktop/components/applications/application_controller.dart';
import 'package:flutter_desktop/components/desktop/desktop_controller.dart';
import 'package:flutter_desktop/components/notifications/notification_controller.dart';
import 'package:flutter_desktop/components/shortcuts/shortcut_controller.dart';
import 'package:flutter_desktop/components/taskbar/taskbar_controller.dart';
import 'package:provider/provider.dart';

import 'application_details.dart';

const double pointSize = 20;

class Application extends StatelessWidget {
  Application(
      {super.key,
      required this.child,
      required this.uuid,
      this.name = "窗口",
      this.resizable = true,
      this.background = AppStyle.light2,
      this.onClose});
  final Widget child;
  final VoidCallback? onClose;

  final String uuid;
  final String name;
  final Color background;

  late ApplicationDetails appDetails;
  final bool resizable;

  @override
  Widget build(BuildContext context) {
    appDetails = context.watch<ApplicationController>().getDetailsById(uuid) ??
        ApplicationDetails(uuid: uuid, name: name, openWith: name);

    return Positioned(
        left: appDetails.xmin,
        top: appDetails.ymin,
        child: appDetails.resizable
            ? _stackWrapper(
                SizedBox(
                  height: appDetails.ymax - appDetails.ymin,
                  width: appDetails.xmax - appDetails.xmin,
                  child: _childWrapperV2(child, context),
                ),
                context)
            : SizedBox(
                height: appDetails.ymax - appDetails.ymin,
                width: appDetails.xmax - appDetails.xmin,
                child: _childWrapperV2(child, context),
              ));
  }

  @Deprecated("use `v2` instead")
  Widget _childWrapper(Widget child, BuildContext ctx) {
    return Container(
      height: appDetails.ymax - appDetails.ymin,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: background,
          border: Border.all(color: AppStyle.dark, width: 1.5)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: const BoxDecoration(
                color: AppStyle.grey,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8))),
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
                  appDetails.name ?? appDetails.openWith,
                  softWrap: true,
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                )),
                InkWell(
                  onTap: () async {
                    if (onClose != null) {
                      onClose!();
                    }

                    if (name == SystemConfig.sAudioPlayer) {
                      await AudioPlayerController.stop();
                    }

                    ctx.read<ApplicationController>().removeDetail(uuid);
                    ctx.read<DesktopController>().removeWidget(uuid);
                    ctx.read<TaskbarController>().removeDetails(uuid);
                    ctx.read<ShortcutPreviewController>().clear();
                    ctx
                        .read<NotificationController>()
                        .removeNotificationByUuid(uuid);
                  },
                  child: const Icon(
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
            // padding: const EdgeInsets.all(5),
            child: child,
          ))
        ],
      ),
    );
  }

  Widget _stackWrapper(Widget child, BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned(
            left: 0,
            top: 0,
            child: MouseRegion(
              cursor: SystemMouseCursors.resizeUpLeft,
              child: GestureDetector(
                onPanUpdate: (details) {
                  context
                      .read<ApplicationController>()
                      .changeApplicationByLeftTopPosition(uuid, details);
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
                        .changeApplicationByLeftBottomPosition(uuid, details);
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
                        .changeApplicationByRightBottomPosition(uuid, details);
                  },
                  child: Container(
                    width: pointSize,
                    height: pointSize,
                    color: Colors.transparent,
                  ),
                ))),
      ],
    );
  }

  Widget _childWrapperV2(Widget child, BuildContext ctx) {
    return Container(
      height: appDetails.ymax - appDetails.ymin,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: background,
          border: Border.all(color: AppStyle.dark, width: 1.5)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onSecondaryTap: () {},
            onTapUp: (details) {
              ctx.read<DesktopController>().setFocusedUuid(uuid);
            },
            onDoubleTap: () {
              if (appDetails.resizable) {
                final windowsSize = MediaQuery.of(ctx).size;

                /// loose size
                if (appDetails.xmin <= 3 &&
                    appDetails.ymin <= 3 &&
                    appDetails.xmax >= windowsSize.width - 3 &&
                    appDetails.ymax >= windowsSize.height - 53) {
                  ctx
                      .read<ApplicationController>()
                      .changeWindowSizeOnDoubleClick(uuid, 0, windowsSize);
                } else {
                  ctx
                      .read<ApplicationController>()
                      .changeWindowSizeOnDoubleClick(uuid, 1, windowsSize);
                }
              }
            },
            onPanUpdate: (details) {
              ctx
                  .read<ApplicationController>()
                  .changeApplicationPosition(uuid, details);
            },
            child: Container(
              decoration: const BoxDecoration(
                  color: AppStyle.grey,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8))),
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
                    appDetails.name ?? appDetails.openWith,
                    softWrap: true,
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                  )),
                  InkWell(
                    onTap: () async {
                      if (onClose != null) {
                        onClose!();
                      }

                      if (name == SystemConfig.sAudioPlayer) {
                        await AudioPlayerController.stop();
                      }

                      ctx.read<ApplicationController>().removeDetail(uuid);
                      ctx.read<DesktopController>().removeWidget(uuid);
                      ctx.read<TaskbarController>().removeDetails(uuid);
                      ctx.read<ShortcutPreviewController>().clear();
                      ctx
                          .read<NotificationController>()
                          .removeNotificationByUuid(uuid);
                    },
                    child: const Icon(
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
          ),
          Expanded(
              child: GestureDetector(
            onSecondaryTap: () {},
            onTapUp: (details) {
              ctx.read<DesktopController>().setFocusedUuid(uuid);
            },
            child: appDetails.needScroll
                ? SingleChildScrollView(
                    // padding: const EdgeInsets.all(5),
                    child: child,
                  )
                : child,
          ))
        ],
      ),
    );
  }
}
