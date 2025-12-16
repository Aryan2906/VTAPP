import 'package:html/parser.dart' as html;
import 'package:vtapp/models/exam_schedule_model.dart';
import 'package:vtapp/session.dart';

List<ExamGroup> parseExamScheduleHtml() {
  final document = html.parse(Session.examVenueHtml);

  final rows = document.querySelectorAll("table.customTable tr");
  List<ExamGroup> groups = [];

  String? currentGroupName;
  List<ExamSchedule> currentGroupExams = [];

  for (final row in rows) {
    final cells = row.querySelectorAll("td");

    // ---------------------
    // 1. DETECT GROUP HEADER (example: FAT, MT)
    // ---------------------
    if (cells.length == 1 && cells.first.attributes["colspan"] == "13") {
      // Push previous group before starting new
      if (currentGroupName != null && currentGroupExams.isNotEmpty) {
        groups.add(ExamGroup(
          type: currentGroupName!,
          exams: List.from(currentGroupExams),
        ));
      }

      currentGroupName = cells.first.text.trim();
      currentGroupExams.clear();
      continue;
    }

    // ---------------------
    // 2. SKIP HEADER ROWS
    // ---------------------
    if (cells.length < 13) continue;
    if (cells[0].text.trim() == "S.No.") continue;

    // ---------------------
    // 3. PARSE EXAM ROW (FAT / MT)
    // ---------------------
    final exam = ExamSchedule(
      courseCode: cells[1].text.trim(),
      courseTitle: cells[2].text.trim(),
      slot: cells[5].text.trim(),
      examDate: emptyToNull(cells[6].text),
      examSession: emptyToNull(cells[7].text),
      reportingTime: emptyToNull(cells[8].text),
      examTime: emptyToNull(cells[9].text),
      venue: emptyToNull(cells[10].text),
      seatLocation: emptyToNull(cells[11].text),
      seatNo: emptyToNull(cells[12].text),
    );

    if (currentGroupName != null) {
      currentGroupExams.add(exam);
    }
  }

  // Push last group
  if (currentGroupName != null && currentGroupExams.isNotEmpty) {
    groups.add(ExamGroup(
      type: currentGroupName!,
      exams: currentGroupExams,
    ));
  }

  return groups;
}

String? emptyToNull(String? value) {
  final v = value?.trim() ?? "";
  return v.isEmpty || v == "-" ? null : v;
}
