import 'package:flutter/material.dart';
import 'package:flutter_desktop/components/app_style.dart';
import 'package:flutter_desktop/components/notifications/notification_controller.dart';
import 'package:flutter_desktop/components/notifications/notification_details.dart';
import 'package:provider/provider.dart';

class NotificationBuilder extends StatelessWidget {
  NotificationBuilder({super.key});
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    final details = context
        .watch<NotificationController>()
        .details
        .where((element) => element.needsTrayDisplay == true)
        .toList();
    return Positioned(
        bottom: 60,
        right: 10,
        child: SizedBox(
          height: 600,
          child: SingleChildScrollView(
            reverse: true,
            controller: controller,
            child: Column(
              children: details
                  .map((e) => _NotificationWidget(
                        details: e,
                      ))
                  .toList(),
            ),
          ),
        ));
  }
}

class _NotificationWidget extends StatefulWidget {
  const _NotificationWidget({required this.details});
  final NotificationDetails details;

  @override
  State<_NotificationWidget> createState() => __NotificationWidgetState();
}

class __NotificationWidgetState extends State<_NotificationWidget> {
  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _visible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 500),
      child: InkWell(
        onTap: () {
          // print("tapped");
          setState(() {
            _visible = false;
          });
          Future.delayed(const Duration(milliseconds: 600)).then((value) {
            context
                .read<NotificationController>()
                .removeANotification(widget.details);
          });
        },
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.all(10),
          width: 300,
          height: 200,
          decoration: BoxDecoration(
              color: AppStyle.light2.withOpacity(0.75),
              border: Border.all(color: AppStyle.light2),
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: widget.details.icon!,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(widget.details.name ?? widget.details.openWith)
                ],
              ),
              widget.details.content
            ],
          ),
        ),
      ),
    );
  }
}
