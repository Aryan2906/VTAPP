import 'dart:math';

import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:vtapp/models/timetable_model.dart';
import 'package:vtapp/models/timetablecurr_model.dart';
import 'package:vtapp/parser/timetabledta.dart';
import 'package:vtapp/parser/timetable_parser.dart';
import 'package:vtapp/services/notifService.dart';
import 'package:vtapp/session.dart';

class TimeTable extends StatefulWidget {
  const TimeTable({super.key});

  @override
  State<TimeTable> createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  bool isLoading = false;
  bool hasLoadedonce = false;
  bool semChange = false;
  String? selectedSem;
  final datetimecontroller = EasyDatePickerController();
  late DateTime today;
  late DateTime start;
  late DateTime end;
  late DateTime startofweek;
  late DateTime endofweek;
  int? selectedDay;
  late String currtime;

  bool highlighTime(String? slotTimeStart,String currtime,String? slotTimeEnd){
    final slotEndHours = num.parse(slotTimeEnd!.split(":")[0]);
    final slotEndmins = num.parse(slotTimeEnd.split(":")[1]);
    final currhours = num.parse(currtime.split(":")[0]);
    final currmins = num.parse(currtime.split(":")[1]);
    final slotHours = num.parse(slotTimeStart!.split(":")[0]);
    final slotmins = num.parse(slotTimeStart.split(":")[1]);
    print("${currhours}  , ${slotHours}, ${slotEndHours} ");
    if (currhours > slotHours){
      return false;
    }
    else if (currhours >= slotHours && currhours < slotEndHours){
      return true;
    }
    else{
      return false;
    }
    return false;
  }

  bool sendNotif(String? slotTimeStart,String currtime,String? slotTimeEnd){
    final slotEndHours = num.parse(slotTimeEnd!.split(":")[0]);
    final slotEndmins = num.parse(slotTimeEnd.split(":")[1]);
    final currhours = num.parse(currtime.split(":")[0]);
    final currmins = num.parse(currtime.split(":")[1]);
    final slotHours = num.parse(slotTimeStart!.split(":")[0]);
    final slotmins = num.parse(slotTimeStart.split(":")[1]);
    if(currhours == slotHours && currmins - slotmins <= 10){
      return true;
    }
    return false;
  }

  Future<void> loadTimetable(semId) async{
    setState(() {
      isLoading = true;
    });
    if (Session.timetablemodel == null && hasLoadedonce == false){
    Session.timetablehtml = await PostDataTimeTable().getTimeTable(semId);  
    Session.timetablemodel = parseVtopTimeTable();
    hasLoadedonce = true;
    }
    else if (semChange == true){
      Session.timetablehtml = await PostDataTimeTable().getTimeTable(semId);
      Session.timetablemodel = parseVtopTimeTable();
    }
    setState(() {
      isLoading = false;
    });
  }
  List<TimetablecurrModel> maptodays(List<TimetableModel>? ttdta,int days){
    final List<TimetablecurrModel>? subDay = [];
    final slotsDay = Session.dayToSlots;
    final slottotime = Session.slotTimes;
    final day = (Session.daysMapping![days]);
    for (var subject in ttdta!){
      for(var slot in subject.slot){
        if(slotsDay[day]!.contains(slot)){
        subDay!.add(TimetablecurrModel(courseCode: subject.courseCode, courseName: subject.courseName, slot: subject.slot, facultyDetail: subject.facultyDetail, credits: subject.credits, venue: subject.venue, currentslot: slot, startTime: slottotime[slot]!.$1, endTime: slottotime[slot]!.$2));
        }
      }
    }
    Session.timetablecurrent = subDay;
    return subDay!;
  }


  @override
  void initState() {
    super.initState();
    today = DateTime.now();
    currtime = "${today.hour}:${today.minute}";
    print(currtime);
    selectedDay = today.weekday;
    start = today.subtract(Duration(days: today.weekday - DateTime.monday));
    startofweek = DateTime(start.year,start.month,start.day);
    end = today.add(Duration(days: DateTime.saturday - today.weekday));
    endofweek = DateTime(end.year,end.month,end.day);
    if (selectedDay == 7){
          selectedDay = 1;
      }
    Future.microtask(() async{
    await loadTimetable(Session.semesterID!.values.first);
    maptodays(Session.timetablemodel, selectedDay!-1);
    setState(() {
    });
    },);
  }

  @override
  Widget build(BuildContext context) {
    final timetable = Session.timetablemodel;
    final timetableday = Session.timetablecurrent ?? [];
    if (timetable == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        const SizedBox(height: 4),
        const SizedBox(height: 0),
        DropdownButton<String?>(hint: Text("Choose Semester"),value: selectedSem,items: Session.semesterID?.keys.map((name) {
          return DropdownMenuItem(child: Text(name),value: name);
        }).toList(), onChanged: (value) async{
          setState(() {
            semChange = true;
            selectedSem = value;
          });
          final semId = Session.semesterID![value]!;
          await loadTimetable(semId);
          maptodays(Session.timetablemodel, today.weekday-1);
          if (selectedDay == 7){
            selectedDay = 1;
          }
          selectedDay = today.weekday;
          setState(() {
          });
        }),

        EasyDateTimeLinePicker(controller: datetimecontroller,timelineOptions: TimelineOptions(height: 100),headerOptions: HeaderOptions(headerType: HeaderType.none),firstDate: startofweek, lastDate: endofweek, focusedDate: today, onDateChange: (date) {
          datetimecontroller.jumpToDate(date);
          selectedDay = date.weekday;
          if (selectedDay == 7){
            selectedDay = 1;
          }
          maptodays(Session.timetablemodel, date.weekday-1);
          setState(() {
          });
        },),
        Text("Selected Day: ${Session.daysMapping?[selectedDay!-1]}",style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold
        ),),
        Expanded(
          child: isLoading?
          CircularProgressIndicator()
          :
          ListView.builder(
            shrinkWrap: false,
            itemCount: timetableday.length,
            itemBuilder:(context, index) {
              TimetablecurrModel item = timetableday[index];
              final highlight = highlighTime(item.startTime, currtime, item.endTime);
              // print(item.startTime);
              // print("${item.currentslot} : ${highlight}");
              // print("${currtime}");
              if (sendNotif(item.startTime, currtime, item.endTime)){
                NotifService().showNotif(
                  body: "Subject: ${item.courseName} , Start Time: ${item.startTime}",
                  title: "Next Class @ ${item.venue}"
                );
              }
              return Card(
                elevation: 3,
                margin: const EdgeInsets.all(15),
                color: highlight? Colors.purple : Colors.white,
                child: ListTile(
                  textColor: highlight?  Colors.white : Colors.black,
                  title: Text("${item.courseCode} - ${item.courseName } (${item.venue})\n(${item.currentslot})",style: TextStyle(
                    overflow: TextOverflow.clip,
                    fontWeight: FontWeight.bold
                  ),),
                  subtitle: Text("Credits:${item.credits}\nSlots:${item.slot.join("+")}\nStart Time:${item.startTime}\nEnd Time:${item.endTime}\nFaculty: ${item.facultyDetail}",style: TextStyle(
                    overflow: TextOverflow.ellipsis
                  ),),
                ),
              );
            },),
        )
      ],
    );
  }
}
