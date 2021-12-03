import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plango_front/views/syncfusion/button_widget.dart';

class DatePickerWidget extends StatefulWidget {
  final ValueChanged<DateTime> onDateTimeChanged;
  final String text;
  final DateTime beginDate;
  final DateTime endDate;

  DatePickerWidget(
      {Key? key,
      required this.onDateTimeChanged,
      required this.text,
      required this.beginDate,
      required this.endDate});
  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  DateTime? date;

  String getText() {
    if (date == null) {
      return widget.text;
    } else {
      return DateFormat('dd/MM/yyyy').format(date!);
      // return '${date.month}/${date.day}/${date.year}';
    }
  }

  @override
  Widget build(BuildContext context) => ButtonHeaderWidget(
        title: 'Date',
        text: getText(),
        onClicked: () => pickDate(context),
      );

  Future pickDate(BuildContext context) async {
    final newDate = await showDatePicker(
      context: context,
      initialDate: widget.beginDate,
      firstDate: widget.beginDate,
      lastDate: widget.endDate,
    );

    if (newDate == null) return;

    setState(() {
      date = newDate;
      widget.onDateTimeChanged(newDate);
    });
  }
}
