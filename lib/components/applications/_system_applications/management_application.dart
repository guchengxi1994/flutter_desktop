import 'package:flutter/material.dart';
import 'package:flutter_desktop/components/app_style.dart';
import 'package:flutter_desktop/components/applications/_system_applications/details.dart'
    show appManagementDetails;
import 'package:flutter_desktop/components/applications/application.dart';
import 'package:flutter_desktop/components/applications/application_controller.dart';
import 'package:flutter_desktop/components/applications/application_details.dart';
import 'package:flutter_desktop/components/desktop/desktop_controller.dart';
import 'package:flutter_desktop/components/notifications/notification_controller.dart';
import 'package:flutter_desktop/components/sysinfo/sysinfo_widget.dart';
import 'package:flutter_desktop/components/taskbar/taskbar_controller.dart';
import 'package:hovering/hovering.dart';
import 'package:provider/provider.dart';

Application managementApplication() {
  return Application(
    uuid: appManagementDetails.uuid,
    name: appManagementDetails.name ?? appManagementDetails.openWith,
    resizable: false,
    child: const ManagementForm(),
  );
}

class ManagementForm extends StatefulWidget {
  const ManagementForm({super.key});

  @override
  State<ManagementForm> createState() => _ManagementFormState();
}

class _ManagementFormState extends State<ManagementForm> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final d = context.watch<ApplicationController>().details;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: AppStyle.chartHeight + 60,
          child: SysInfoWidget(),
        ),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          width: 700,
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: d
                .map((e) => _ManagementWidget(
                      details: e,
                    ))
                .toList(),
          ),
        )
      ],
    );
  }
}

class _ManagementWidget extends StatelessWidget {
  const _ManagementWidget({required this.details});
  final ApplicationDetails details;

  @override
  Widget build(BuildContext context) {
    return HoverWidget(
        hoverChild: Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
              border: Border.all(color: AppStyle.light),
              color: AppStyle.light,
              borderRadius: BorderRadius.circular(15)),
          width: 150,
          height: 40,
          child: Row(
            children: [
              SizedBox(
                height: 20,
                width: 20,
                child: details.icon!,
              ),
              const SizedBox(
                width: 5,
              ),
              // Text(details.name),
              SizedBox(
                width: 50,
                child: Text(
                  details.name ?? details.openWith,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Expanded(child: SizedBox()),
              InkWell(
                onTap: () {
                  context
                      .read<DesktopController>()
                      .setFocusedUuid(details.uuid);
                },
                child: const Icon(
                  Icons.center_focus_strong,
                  color: AppStyle.light2,
                ),
              ),
              InkWell(
                onTap: () {
                  context
                      .read<ApplicationController>()
                      .removeDetail(details.uuid);
                  context.read<DesktopController>().removeWidget(details.uuid);
                  context.read<TaskbarController>().removeDetails(details.uuid);
                  context
                      .read<NotificationController>()
                      .removeNotificationByUuid(details.uuid);
                },
                child: const Icon(
                  Icons.delete,
                  color: AppStyle.light2,
                ),
              )
            ],
          ),
        ),
        onHover: (f) {},
        child: Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
              border: Border.all(color: AppStyle.light),
              borderRadius: BorderRadius.circular(15)),
          width: 150,
          height: 40,
          child: Row(
            children: [
              SizedBox(
                height: 20,
                width: 20,
                child: details.icon!,
              ),
              const SizedBox(
                width: 5,
              ),
              SizedBox(
                width: 100,
                child: Text(
                  details.name ?? details.openWith,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ));
  }
}
