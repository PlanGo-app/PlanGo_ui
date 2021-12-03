import 'package:flutter/material.dart';
import 'package:plango_front/service/planning_event_service.dart';
import 'package:plango_front/util/constant.dart';
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
  late DateTime selectedDate;
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
                                            Row(
                                              children: [
                                                Expanded(
                                                  flex: 6,
                                                  child: Row(children: [
                                                    FloatingActionButton(
                                                      onPressed: () {
                                                        _selectDate(context);
                                                      },
                                                      child: const Icon(
                                                          Icons.date_range),
                                                      mini: true,
                                                      backgroundColor:
                                                          kPrimaryColor,
                                                    ),
                                                    TextInputDate(
                                                        searchController),
                                                  ]),
                                                ),
                                                Expanded(
                                                  flex: 4,
                                                  child: Container(
                                                      height: 100,
                                                      width: 100,
                                                      color: Colors.red),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )));
                              });
                          // Appointment app = Appointment(
                          //   notes: 2.toString(),
                          //   startTime: DateTime.now(),
                          //   endTime: DateTime.now().add(Duration(hours: 2)),
                          //   subject: marker.name,
                          //   color: Colors.purple,
                          // );
                          // print(app);
                          // widget._dataSource!.appointments!.add(app);
                          // widget._dataSource!.notifyListeners(
                          //     CalendarDataSourceAction.add, <Appointment>[app]);
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
              viewNavigationMode: ViewNavigationMode.snap,
            ),
          ),
        ],
      ),
    ));
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: widget.dateBegin,
        firstDate: widget.dateBegin,
        lastDate: widget.dateEnd);
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        searchController.text =
            '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';
        print(selectedDate);
      });
    }
  }

  Flexible TextInputDate(searchController) {
    return Flexible(
        child: TextField(
      enabled: false,
      decoration: const InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide.none,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
      controller: searchController,
      onChanged: (text) {
        setState(() {});
        // getPlaces(searchController.text);
      },
    ));
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
