import 'package:flutter_desktop/components/applications/application_details.dart';

typedef OnDialogClose = Function();
typedef OnSubmit = Function();
typedef OnCancel = Function();

class DialogDetails extends ApplicationDetails {
  DialogDetails(
      {required super.uuid,
      required super.name,
      required super.xmin,
      required super.ymin,
      this.onCancel,
      this.onSubmit,
      required super.icon,
      required super.xmax,
      required super.ymax,
      required super.multiple,
      required super.openWith});
  final OnSubmit? onSubmit;
  final OnCancel? onCancel;
}
