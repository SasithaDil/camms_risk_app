import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:risk_sample/utils/assets.dart';


class TimePickerWidget extends StatefulWidget {
  const TimePickerWidget(
      {super.key, this.restorationId, required this.controller});

  final String? restorationId;
  final TextEditingController controller;

  @override
  State<TimePickerWidget> createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
  TextEditingController get controller => widget.controller;

  Future<TimeOfDay?> showTimePicker({
    required BuildContext context,
    required TimeOfDay initialTime,
    TransitionBuilder? builder,
    bool useRootNavigator = true,
    TimePickerEntryMode initialEntryMode = TimePickerEntryMode.dial,
    String? cancelText,
    String? confirmText,
    String? helpText,
    String? errorInvalidText,
    String? hourLabelText,
    String? minuteLabelText,
    RouteSettings? routeSettings,
    EntryModeChangeCallback? onEntryModeChanged,
    Offset? anchorPoint,
  }) async {
    assert(debugCheckHasMaterialLocalizations(context));

    final Widget dialog = TimePickerDialog(
      initialTime: initialTime,
      initialEntryMode: initialEntryMode,
      cancelText: cancelText,
      confirmText: confirmText,
      helpText: '',
      errorInvalidText: errorInvalidText,
      hourLabelText: hourLabelText,
      minuteLabelText: minuteLabelText,
      onEntryModeChanged: onEntryModeChanged,
    );
    return showDialog<TimeOfDay>(
      context: context,
      useRootNavigator: useRootNavigator,
      builder: (BuildContext context) {
        return builder == null ? dialog : builder(context, dialog);
      },
      routeSettings: routeSettings,
      anchorPoint: anchorPoint,
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Image.asset(timeIcon),
      onPressed: () async {
        var value = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(
            DateTime.now(),
          ),
        );

        if (value == null) return;
        setState(() {
          var time = TimeOfDay(
            hour: value.hour,
            minute: value.minute,
          ).format(context);

          DateFormat inputFormat = DateFormat('MM/dd/yyyy hh:mm a');
          DateTime dttemp = inputFormat.parse(controller.text);

          controller.text =
              '${dttemp.month}/${dttemp.day}/${dttemp.year} $time ';
        });
      },
    );
  }
}
