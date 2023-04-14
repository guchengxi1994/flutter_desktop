import 'package:flutter_desktop/components/applications/application_details.dart';

typedef OnDialogClose = Object Function();
typedef OnSubmit = Object Function();
typedef OnCancel = Object Function();

class DialogDetails extends ApplicationDetails {
  DialogDetails(
      {required super.uuid,
      required super.name,
      required this.onWindowClose,
      required super.xmin,
      required super.ymin,
      this.onCancel,
      this.onSubmit,
      required super.icon,
      required super.xmax,
      required super.ymax});
  final OnDialogClose onWindowClose;
  final OnSubmit? onSubmit;
  final OnCancel? onCancel;
}
