import 'package:flutter/material.dart';
import 'package:plango_front/model/planning_event.dart';
import 'package:plango_front/service/planning_event_service.dart';
import 'package:plango_front/views/components/rounded_button.dart';
import 'package:plango_front/views/syncfusion/date_picker_widget.dart';
import 'package:plango_front/views/syncfusion/time_picker_widget.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class SyncfusionTest extends StatefulWidget {
  int travelId;
  List all = [];
  CalendarDataSource? _dataSource;
  final DateTime dateBegin;
  final DateTime dateEnd;

  SyncfusionTest(
      {Key? key,
      required this.dateBegin,
      required this.dateEnd,
      required this.travelId})
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
    widget.all = [];
    widget._dataSource = _getCalendarDataSource();
    PlanningEventService().getPlanningEvents(widget.travelId).then((value) {
      print(value.first.date_start);
      setState(() {
        for (PlanningEvent planningEvent in value) {
          if (planningEvent.date_start != null) {
            createPlanningEvent(planningEvent, context, false);
          } else {
            widget.all.add(planningEvent);
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 3),
            height: 40,
            child: ListView(scrollDirection: Axis.horizontal, children: [
              ...widget.all
                  .map((planningEvent) => InkWell(
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: Colors.deepPurpleAccent,
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Center(child: Text(planningEvent.name))),
                      onTap: () {
                        showModalBottomSheet(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25)),
                          ),
                          context: context,
                          builder: (BuildContext context) {
                            return StatefulBuilder(builder:
                                (BuildContext context,
                                    StateSetter setModalState) {
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
                                                    text: "Date de l'activité",
                                                    beginDate: widget.dateBegin,
                                                    endDate: widget.dateEnd,
                                                    onDateTimeChanged:
                                                        (newDate) {
                                                      setModalState(() {
                                                        selectedDate = newDate;
                                                        print(newDate);
                                                      });
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
                                                    setModalState(() {
                                                      beginHour = newDateTime;
                                                      print(beginHour);
                                                    });
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
                                                    setModalState(() {
                                                      endHour = newDateTime;
                                                      print(endHour);
                                                    });
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                            flex: 3,
                                            child: !verifyData()
                                                ? Container()
                                                : compareData()
                                                    ? const Text(
                                                        "L'heure de debut doit être inferieur à l'heure de fin",
                                                        style: TextStyle(
                                                            color: Colors.red),
                                                      )
                                                    : Row(children: [
                                                        Expanded(
                                                            flex: 5,
                                                            child: RoundedButton(
                                                                text: "Ajouter",
                                                                press: () {
                                                                  if (selectedDate != null &&
                                                                      beginHour !=
                                                                          null &&
                                                                      endHour !=
                                                                          null) {
                                                                    createPlanningEvent(
                                                                        planningEvent,
                                                                        context,
                                                                        true);
                                                                  }
                                                                }))
                                                      ])),
                                      ],
                                    ),
                                  ));
                            });
                          },
                        );
                      }))
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
              timeSlotViewSettings: const TimeSlotViewSettings(
                timeIntervalHeight: 60,
                timeFormat: "hh:mm",
              ),
              showWeekNumber: true,
              minDate: widget.dateBegin,
              maxDate: widget.dateEnd,
            ),
          ),
        ],
      ),
    ));
  }

  bool verifyData() {
    return (selectedDate != null && beginHour != null && endHour != null);
  }

  bool compareData() {
    return ((beginHour!.hour * 60 + beginHour!.minute) -
            (endHour!.hour * 60 + endHour!.minute) >=
        0);
  }

  void createPlanningEvent(PlanningEvent planningEvent, context, bool save) {
    DateTime startTime = planningEvent.date_start ??
        DateTime(selectedDate!.year, selectedDate!.month, selectedDate!.day,
            beginHour!.hour, beginHour!.minute);
    DateTime endTime = planningEvent.date_end ??
        DateTime(selectedDate!.year, selectedDate!.month, selectedDate!.day,
            endHour!.hour, endHour!.minute);
    Appointment app = Appointment(
      notes: planningEvent.id.toString(),
      startTime: startTime,
      endTime: endTime,
      subject: planningEvent.name,
      color: Colors.purple,
    );
    print(app);
    if (save) {
      PlanningEventService().updatePlanningEvent(
          int.parse(app.notes!), app.subject, app.startTime, app.endTime);
    }
    widget._dataSource!.appointments!.add(app);
    widget._dataSource!
        .notifyListeners(CalendarDataSourceAction.add, <Appointment>[app]);
    setState(() {
      widget.all.remove(planningEvent);
      selectedDate = null;
      beginHour = null;
      endHour = null;
    });

    if (save) Navigator.of(context).pop();
  }
}

void dragEnd(AppointmentDragEndDetails appointmentDragEndDetails) {
  dynamic appointment = appointmentDragEndDetails.appointment;
  print(appointment);
  print(appointment.startTime);
  print(appointment.endTime);
  print(int.parse((appointment).notes));
  PlanningEventService().updatePlanningEvent(int.parse(appointment.notes),
      appointment.subject, appointment.startTime, appointment.endTime);
}

_AppointmentDataSource _getCalendarDataSource() {
  List<Appointment> appointments = <Appointment>[];
  return _AppointmentDataSource(appointments);
}

class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}
