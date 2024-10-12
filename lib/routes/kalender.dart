import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';
import 'package:icalendar_parser/icalendar_parser.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:property_change_notifier/property_change_notifier.dart';
import 'package:sphplaner/helper/storage/storage_notifier.dart';

class Kalender extends StatefulWidget {
  const Kalender({super.key});

  @override
  State<Kalender> createState() => _KalenderState();
}

class _KalenderState extends State<Kalender> {
  String path = "";
  Map colors = {};
  @override
  void initState() {
    super.initState();
    getApplicationDocumentsDirectory().then((dir) {
      path = dir.path;
      File colorFile = File('$path/colors.json');
      String colorString = colorFile.readAsStringSync();

      setState(() {
        colors = jsonDecode(colorString);
      });
    });
  }

  Column singleDayTimeWidget(String start, String end) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(start, style: Theme.of(context).textTheme.bodyLarge),
        Text(end, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }

  Column allOrMultiDayDayTimeWidget(NeatCleanCalendarEvent event) {
    String start = DateFormat('HH:mm').format(event.startTime).toString();
    String end = DateFormat('HH:mm').format(event.endTime).toString();
    if (event.isAllDay) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Ganztägig",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      );
    }
    if (event.multiDaySegement == MultiDaySegement.first) {
      start = 'ab $start';
      end = '';
    } else if (event.multiDaySegement == MultiDaySegement.last) {
      start = '';
      end = 'bis $end';
    } else {
      start = "Ganztägig";
      end = '';
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(start, style: Theme.of(context).textTheme.bodyLarge),
        Text(end, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }

  Widget eventCell(BuildContext context, NeatCleanCalendarEvent event,
      String start, String end) {
    return Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color:
              Theme.of(context).colorScheme.secondaryContainer.withOpacity(.5),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: <Widget>[
            Container(
              height: 64,
              width: 8,
              decoration: BoxDecoration(
                  color: event.color, borderRadius: BorderRadius.circular(10)),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(event.summary,
                        style: Theme.of(context).textTheme.titleMedium),
                    if (event.description.isNotEmpty)
                      SizedBox(
                        height: 5.0,
                      ),
                    if (event.description.isNotEmpty)
                      Text(event.description,
                          style: Theme.of(context).textTheme.bodyMedium),
                    if (event.location.isNotEmpty)
                      SizedBox(
                        height: 5.0,
                      ),
                    if (event.location.isNotEmpty)
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.fontSize,
                          ),
                          Text(
                            event.location,
                            style: Theme.of(context).textTheme.bodyMedium,
                          )
                        ],
                      )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              // If the event is all day, then display the word "All day" with no time.
              child: event.isAllDay || event.isMultiDay
                  ? allOrMultiDayDayTimeWidget(event)
                  : singleDayTimeWidget(start, end),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return PropertyChangeConsumer<StorageNotifier, String>(
        properties: const ['kalender'],
        builder: (context, notify, child) {
          List<NeatCleanCalendarEvent> eventList = [];
          if (path != "") {
            File iCal = File('$path/ical.ics');
            String icsString = iCal.readAsStringSync();
            final iCalendar = ICalendar.fromString(icsString);
            for (Map<String, dynamic> data in iCalendar.toJson()['data']) {
              if (data['type'] == "VEVENT") {
                NeatCleanCalendarEvent event = NeatCleanCalendarEvent(
                  data['summary'],
                  startTime: DateTime.parse(data['dtstart']['dt']),
                  endTime: DateTime.parse(data['dtend']['dt']),
                  description: data['description'],
                  location: data['location'],
                  color: Color(colors[data['categories'][0]] ?? 4294967295),
                );
                Duration duration = Duration(
                    milliseconds: event.endTime.millisecondsSinceEpoch -
                        event.startTime.millisecondsSinceEpoch);
                if (duration.inDays == 1) {
                  event.endTime = event.endTime.subtract(Duration(seconds: 1));
                  event.isAllDay = true;
                } else if (duration.inDays > 1) {
                  if (DateFormat("HH:mm").format(event.endTime) == "00:00") {
                    event.endTime =
                        event.endTime.subtract(Duration(seconds: 1));
                  }
                  if (DateFormat("HH:mm").format(event.startTime) == "00:00" &&
                      DateFormat("HH:mm").format(event.endTime) == "23:59") {
                    event.isAllDay = true;
                  }
                }
                eventList.add(event);
              }
            }
          }

          return OrientationBuilder(builder: (context, orientation) {
            return SafeArea(
                child: Calendar(
                  forceEventListView: orientation == Orientation.landscape,
                  showEventListViewIcon: orientation == Orientation.portrait,
                  initialDate: DateTime.now(),
                  eventsList: eventList,
                  startOnMonday: true,
                  weekDays: ['Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa', 'So'],
                  isExpandable: false,
                  selectedColor: Theme.of(context).colorScheme.primary,
                  selectedTodayColor: Theme.of(context).colorScheme.primary,
                  showEvents: true,
                  todayColor: Theme.of(context).colorScheme.primary,
                  eventColor: null,
                  eventCellBuilder: (context, event, start, end) =>
                      eventCell(context, event, start, end),
                  locale: 'de_DE',
                  hideTodayIcon: true,
                  todayButtonText: 'Heute',
                  allDayEventText: 'Ganztägig',
                  multiDayEndText: 'Ende',
                  isExpanded: true,
                  expandableDateFormat: 'EEEE, dd. MMMM yyyy',
                  datePickerType: DatePickerType.hidden,
                  dayOfWeekStyle: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold),
                  defaultDayColor:
                  Theme.of(context).textTheme.bodyMedium?.color,
                  defaultOutOfMonthDayColor: Theme.of(context).disabledColor,
                  topRowIconColor: Theme.of(context).colorScheme.secondary,
                ));
          });
        });
  }
}
