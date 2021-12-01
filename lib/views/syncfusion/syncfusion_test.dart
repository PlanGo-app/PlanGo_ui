import 'package:flutter/material.dart';
import 'package:plango_front/service/planning_event_service.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class SyncfusionTest extends StatefulWidget {
  List all = [];
  CalendarDataSource? _dataSource;
  SyncfusionTest({Key? key}) : super(key: key);

  @override
  _SyncfusionTestState createState() => _SyncfusionTestState();
}

class _SyncfusionTestState extends State<SyncfusionTest> {
  @override
  void initState() {
    super.initState();
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
                          Appointment app = Appointment(
                            notes: 2.toString(),
                            startTime: DateTime.now(),
                            endTime: DateTime.now().add(Duration(hours: 2)),
                            subject: marker.name,
                            color: Colors.blue,
                          );
                          print(app);
                          widget._dataSource!.appointments!.add(app);
                          widget._dataSource!.notifyListeners(
                              CalendarDataSourceAction.add, <Appointment>[app]);
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
            ),
          ),
        ],
      ),
    ));
  }

  void dragEnd(AppointmentDragEndDetails appointmentDragEndDetails) {
    dynamic appointment = appointmentDragEndDetails.appointment;
    print(appointment.startTime);
    print(appointment.endTime);
    // print((appointment as planningEvent).idEvent);
    print(int.parse((appointment).notes));
    CalendarResource? sourceResource = appointmentDragEndDetails.sourceResource;
    // print(sourceResource);
    CalendarResource? targetResource = appointmentDragEndDetails.targetResource;
    // print(targetResource);
    DateTime? droppingTime = appointmentDragEndDetails.droppingTime;
    // print(droppingTime);
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
}

class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}

//
//   void dragUpdate(AppointmentDragUpdateDetails appointmentDragUpdateDetails) {
//     dynamic appointment = appointmentDragUpdateDetails.appointment;
//     DateTime? draggingTime = appointmentDragUpdateDetails.draggingTime;
//     Offset? draggingOffset = appointmentDragUpdateDetails.draggingPosition;
//     CalendarResource? sourceResource =
//         appointmentDragUpdateDetails.sourceResource;
//     CalendarResource? targetResource =
//         appointmentDragUpdateDetails.targetResource;
//   }
//
// List<Meeting> _getDataSource() {
//   final List<Meeting> meetings = <Meeting>[];
//   final DateTime today = DateTime.now();
//   final DateTime startTime =
//       DateTime(today.year, today.month, today.day, 9, 0, 0);
//   final DateTime endTime = startTime.add(const Duration(hours: 2));
//   meetings.add(Meeting(
//       'Conference', startTime, endTime, const Color(0xFF0F8644), false));
//   return meetings;
// }

// class MeetingDataSource extends CalendarDataSource {
//   MeetingDataSource(List<Meeting> source) {
//     appointments = source;
//   }
//
//   @override
//   DateTime getStartTime(int index) {
//     return appointments![index].from;
//   }
//
//   @override
//   DateTime getEndTime(int index) {
//     return appointments == null ? false : appointments![index].to;
//   }
//
//   @override
//   String getSubject(int index) {
//     return appointments == null ? false : appointments![index].eventName;
//   }
//
//   @override
//   Color getColor(int index) {
//     return appointments == null ? false : appointments![index].background;
//   }
//
//   @override
//   bool isAllDay(int index) {
//     return appointments == null ? false : appointments![index].isAllDay;
//   }
// }

// class Meeting {
//   Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);
//
//   String eventName;
//   DateTime from;
//   DateTime to;
//   Color background;
//   bool isAllDay;
// }
