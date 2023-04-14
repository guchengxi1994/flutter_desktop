// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_desktop/components/dialogs/dialog_details.dart';
import 'package:provider/provider.dart';

import '../app_style.dart';
import '../applications/application_controller.dart';

class CustomDialog extends StatelessWidget {
  CustomDialog(
      {super.key, required this.child, required this.name, required this.uuid});
  final Widget child;

  final String uuid;
  final String name;
  late DialogDetails dialogDetails;

  @override
  Widget build(BuildContext context) {
    dialogDetails = (context.watch<ApplicationController>().getDetailsById(uuid)
            as DialogDetails?) ??
        DialogDetails(
          uuid: uuid,
          name: name,
          icon: null,
          onWindowClose: () {
            return 0;
          },
          xmax: 500,
          xmin: 200,
          ymax: 400,
          ymin: 200,
        );

    return Container();
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
                    dialogDetails.onWindowClose();
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
