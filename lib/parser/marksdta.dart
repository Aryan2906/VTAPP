import 'package:html/parser.dart' as html;
import 'package:vtapp/models/marks_model.dart';
import 'package:vtapp/session.dart';

List<CourseMark> parseMarks() {
  final document = html.parse(Session.marksmodel);

  // All the course rows + marks rows
  final rows = document.querySelectorAll("tr.tableContent");

  List<CourseMark> courses = [];

  for (int i = 0; i < rows.length; i += 2) {
    final courseRow = rows[i];
    final marksRow = rows[i + 1];

    final courseCells = courseRow.querySelectorAll("td");
    if (courseCells.length < 9) continue;

    // -----------------------------
    // PARSE COURSE INFO
    // -----------------------------
    final serialNo = int.tryParse(courseCells[0].text.trim()) ?? 0;

    final courseCode = courseCells[2].text.trim();
    final courseTitle = courseCells[3].text.trim();
    final courseType = courseCells[4].text.trim();
    final faculty = courseCells[6].text.trim();
    final slot = courseCells[7].text.trim();
    final courseMode = courseCells[8].text.trim();

    // -----------------------------
    // PARSE Mark Entries
    // -----------------------------
    final marksTable = marksRow.querySelector("table.customTable-level1");

    List<MarkEntry> marks = [];

    if (marksTable != null) {
      final markRows =
          marksTable.querySelectorAll("tr.tableContent-level1");

      for (final row in markRows) {
        final c = row.querySelectorAll("td");
        if (c.length < 7) continue;

        double toDouble(String s) => double.tryParse(s.trim()) ?? 0;
        int toInt(String s) => int.tryParse(s.trim()) ?? 0;

        marks.add(
          MarkEntry(
            serialNo: toInt(c[0].text),
            markTitle: c[1].text.trim(),
            maxMark: toDouble(c[2].text),
            weightagePercent: toDouble(c[3].text),
            status: c[4].text.trim(),
            scoredMark: toDouble(c[5].text),
            weightageMark: toDouble(c[6].text),
          ),
        );
      }
    }

    // -----------------------------
    // ADD COURSE MODEL
    // -----------------------------
    courses.add(
      CourseMark(
        serialNo: serialNo,
        courseCode: courseCode,
        courseTitle: courseTitle,
        courseType: courseType,
        faculty: faculty,
        slot: slot,
        courseMode: courseMode,
        marks: marks,
      ),
    );
  }

  return courses;
}
