import 'package:html/parser.dart' as html;
import 'package:vtapp/models/timetable_model.dart';
import 'package:vtapp/session.dart';

List<TimetableModel>? parseVtopTimeTable() {
  final raw = Session.timetablehtml;
  final document = html.parse(raw);

  List<TimetableModel> timetable = [];
  final courseTable = document.querySelector("table.table");
  if (courseTable == null) return timetable;

  final courseRows = courseTable.querySelectorAll("tr").skip(1);

  for (var row in courseRows) {
    final cells = row.querySelectorAll("td");

    // SAFETY CHECK
    if (cells.length < 9) continue;

    // COURSE CODE + NAME
    final rawCourse = cells[2].text.trim();
    final courseSplit = rawCourse.split("-");
    final courseCode = courseSplit[0].trim();
    final courseName = (courseSplit.length > 1) ? courseSplit[1].split("(")[0].trim() : "";

    // FACULTY
    final facultyDetail = cells[8].text.split("-")[0].trim();

    // SLOTS + VENUE CELL
    final slotVenueCell = cells[7].text.trim();

    // SAFE VENUE EXTRACTION
    String venue = "NIL";
    final vParts = slotVenueCell.split("-");
    if (vParts.length >= 3) {
      venue = "${vParts[1].trim()}-${vParts[2].trim()}";
    }

    // SAFER CREDIT PARSING
    final creditParts = cells[3].text.trim().split(RegExp(r'\s+'));
    final credits = creditParts.isNotEmpty ? creditParts.last : "0.0";

    // SLOT EXTRACTION
    final slotCodes = slotVenueCell
        .split(RegExp(r'[\+\-]'))
        .map((s) => s.trim())
        .where((s) => RegExp(r'^[A-F][12][0-9]$').hasMatch(s))
        .toList();

    timetable.add(TimetableModel(
      courseCode: courseCode,
      courseName: courseName,
      slot: slotCodes,
      facultyDetail: facultyDetail,
      credits: credits,
      venue: venue,
    ));
  }

  return timetable;
}
