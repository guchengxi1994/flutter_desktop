// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_desktop/components/applications/application.dart';
import 'package:flutter_desktop/components/desktop/desktop_controller.dart';
import 'package:flutter_desktop/components/dialogs/dialog_details.dart';
import 'package:provider/provider.dart';

import '../app_style.dart';
import '../applications/application_controller.dart';

class CustomDialog extends Application {
  late DialogDetails dialogDetails;

  CustomDialog(
      {super.key,
      required super.child,
      required super.uuid,
      required super.name});

  @override
  Widget build(BuildContext context) {
    dialogDetails = (context.watch<ApplicationController>().getDetailsById(uuid)
            as DialogDetails?) ??
        DialogDetails(
            uuid: uuid,
            name: name,
            icon: null,
            xmax: 500,
            xmin: 200,
            ymax: 350,
            ymin: 200,
            multiple: false);

    // return Container();
    return Positioned(
        left: dialogDetails.xmin,
        top: dialogDetails.ymin,
        child: GestureDetector(
          onPanUpdate: (details) {
            context
                .read<ApplicationController>()
                .changeApplicationPosition(uuid, details);
          },
          child: SizedBox(
            height: dialogDetails.ymax - dialogDetails.ymin,
            width: dialogDetails.xmax - dialogDetails.xmin,
            child: _childWrapper(child, context),
          ),
        ));
  }

  Widget _childWrapper(Widget child, BuildContext ctx) {
    return Container(
      height: dialogDetails.ymax - dialogDetails.ymin,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppStyle.light2,
          border: Border.all(color: AppStyle.dark, width: 1.5)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 168, 227, 227),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8))),
            height: 30,
            width: dialogDetails.xmax - dialogDetails.xmin,
            child: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: AppStyle.appbarIconSize,
                  height: AppStyle.appbarIconSize,
                  child: dialogDetails.icon!,
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                    child: Text(
                  dialogDetails.name,
                  softWrap: true,
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                )),
                InkWell(
                  onTap: () {
                    ctx.read<DesktopController>().removeWidget(uuid);
                    ctx.read<ApplicationController>().removeDetail(uuid);
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
          child
        ],
      ),
    );
  }
}
