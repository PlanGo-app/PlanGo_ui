import 'package:flutter/material.dart';

import 'button_widget.dart';

class TimePickerWidget extends StatefulWidget {
  final ValueChanged<TimeOfDay> onDateTimeChanged;
  final String text;
  final TimeOfDay? beginTime;

  TimePickerWidget(
      {Key? key,
      required this.onDateTimeChanged,
      required this.text,
      this.beginTime});

  @override
  _TimePickerWidgetState createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
  TimeOfDay? time = null;

  String getText() {
    if (time == null) {
      return widget.text;
    } else {
      final hours = time!.hour.toString().padLeft(2, '0');
      final minutes = time!.minute.toString().padLeft(2, '0');

      return '$hours:$minutes';
    }
  }

  @override
  Widget build(BuildContext context) => ButtonHeaderWidget(
        title: 'Horaire',
        text: getText(),
        onClicked: () => pickTime(context),
      );

  Future pickTime(BuildContext context) async {
    final newTime = await showTimePicker(
      context: context,
      initialTime: time ?? const TimeOfDay(hour: 9, minute: 0),
      // initialEntryMode: TimePickerEntryMode.input,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if (newTime == null) return;
    setState(() {
      time = newTime;
      widget.onDateTimeChanged(newTime);
    });
  }
}
