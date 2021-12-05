import 'package:flutter/material.dart';
import 'package:plango_front/service/planning_event_service.dart';
import 'package:plango_front/views/components/rounded_button.dart';
import 'package:plango_front/views/syncfusion/date_picker_widget.dart';
import 'package:plango_front/views/syncfusion/time_picker_widget.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class SyncfusionTest extends StatefulWidget {
  List all = [];
  CalendarDataSource? _dataSource;
  final DateTime dateBegin;
  final DateTime dateEnd;

  SyncfusionTest({Key? key, required this.dateBegin, required this.dateEnd})
      : super(key: key);

  @override
  _SyncfusionTestState createState() => _SyncfusionTestState();
}

class _SyncfusionTestState extends State<SyncfusionTest> {
  DateTime? selectedDate;
  TimeOfDay? beginHour;
  TimeOfDay? endHour;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedDate = widget.dateBegin;
    widget._dataSource = _getCalendarDataSource();
    PlanningEventService().loadMarkers().then((value) {
      setState(() {
        widget.all = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: ListView(scrollDirection: Axis.horizontal, children: [
              ...widget.all
                  .map((marker) => InkWell(
                        child: Container(
                            color: Colors.deepPurpleAccent,
                            child: Center(child: Text(marker.name))),
                        onTap: () {
                          showModalBottomSheet(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25),
                                    topRight: Radius.circular(25)),
                              ),
                              context: context,
                              builder: (BuildContext context) {
                                return Material(
                                    elevation: 20,
                                    child: SizedBox(
                                      height: 300,
                                      child: Column(
                                        children: [
                                          Expanded(
                                              flex: 3,
                                              child: Row(children: [
                                                Expanded(
                                                    flex: 10,
                                                    child: DatePickerWidget(
                                                      text:
                                                          "Date de l'activité",
                                                      beginDate:
                                                          widget.dateBegin,
                                                      endDate: widget.dateEnd,
                                                      onDateTimeChanged:
                                                          (newDate) {
                                                        selectedDate = newDate;
                                                        print(newDate);
                                                      },
                                                    ))
                                              ])),
                                          Expanded(
                                            flex: 3,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 5,
                                                  child: TimePickerWidget(
                                                    text: "Heure de debut",
                                                    onDateTimeChanged:
                                                        (newDateTime) {
                                                      beginHour = newDateTime;
                                                      print(beginHour);
                                                    },
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 5,
                                                  child: TimePickerWidget(
                                                    text: "Heure de fin",
                                                    beginTime: beginHour,
                                                    onDateTimeChanged:
                                                        (newDateTime) {
                                                      endHour = newDateTime;
                                                      print(endHour);
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Row(children: [
                                                Expanded(
                                                    flex: 5,
                                                    child: RoundedButton(
                                                        text: "Ajouter",
                                                        press: () {
                                                          if (selectedDate !=
                                                                  null &&
                                                              beginHour !=
                                                                  null &&
                                                              endHour != null) {
                                                            createPin(marker,
                                                                context);
                                                          }
                                                        }))
                                              ])),
                                        ],
                                      ),
                                    ));
                              });
                        },
                      ))
                  .toList(),
              // IgnorePointer(child: Center(child: buildText(text))),
            ]),
          ),
          Expanded(
            flex: 9,
            child: SfCalendar(
              view: CalendarView.day,
              dataSource: widget._dataSource,
              allowDragAndDrop: true,
              onDragEnd: dragEnd,
              initialDisplayDate: selectedDate,
              timeSlotViewSettings:
                  TimeSlotViewSettings(timeIntervalHeight: 60),
              showWeekNumber: true,
            ),
          ),
        ],
      ),
    ));
  }

  void createPin(marker, context) {
    DateTime startTime = DateTime(selectedDate!.year, selectedDate!.month,
        selectedDate!.day, beginHour!.hour, beginHour!.minute);
    DateTime endTime = DateTime(selectedDate!.year, selectedDate!.month,
        selectedDate!.day, endHour!.hour, endHour!.minute);
    Appointment app = Appointment(
      notes: 2.toString(),
      startTime: startTime,
      endTime: endTime,
      subject: marker.name,
      color: Colors.purple,
    );
    print(app);
    widget._dataSource!.appointments!.add(app);
    widget._dataSource!
        .notifyListeners(CalendarDataSourceAction.add, <Appointment>[app]);
    setState(() {
      widget.all.remove(marker);
      selectedDate = null;
      beginHour = null;
      endHour = null;
    });
    Navigator.of(context).pop();
  }
}

void dragEnd(AppointmentDragEndDetails appointmentDragEndDetails) {
  dynamic appointment = appointmentDragEndDetails.appointment;
  print(appointment);
  print(appointment.startTime);
  print(appointment.endTime);
  print(int.parse((appointment).notes));
}

_AppointmentDataSource _getCalendarDataSource() {
  List<Appointment> appointments = <Appointment>[];
  appointments.add(Appointment(
    notes: 1.toString(),
    startTime: DateTime.now(),
    endTime: DateTime.now().add(Duration(minutes: 60)),
    subject: 'Meeting',
    color: Colors.blue,
  ));

  return _AppointmentDataSource(appointments);
}

class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}
