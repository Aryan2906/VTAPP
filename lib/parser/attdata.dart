import 'package:html/parser.dart' as htmlparser;
import 'package:vtapp/models/attendance_model.dart';
import 'package:vtapp/session.dart';
List<AttendanceModel>? parseAttendance(){
  final document = htmlparser.parse(Session.attmodel);
  final rows = document.querySelectorAll("tbody tr");
  List<AttendanceModel> items = [];
  for (var row in rows){
    final cells = row.querySelectorAll("td span");
    if (cells.length >= 8) {
      items.add(
        AttendanceModel(
          slNo: cells[0].text.trim() ,
          classGroup: cells[1].text.trim(),
          courseDetail: cells[2].text.trim(),
          classDetail: cells[3].text.trim(),
          facultyDetail: cells[4].text.trim(),
          attended: cells[5].text.trim(),
          total: cells[6].text.trim(),
          percentage: cells[7].text.trim(),
          debarStatus: cells[8].text.trim()
        ),
      );
    }
  }
  return items;
} 