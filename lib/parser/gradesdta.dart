import 'package:html/parser.dart' as html;
import 'package:vtapp/models/grades_model.dart';
import 'package:vtapp/session.dart';

GradeReport parseGradeTable() {
  final doc = html.parse(Session.gradesHtml);

  // Find the target table
  final table = doc.querySelector("table.table.table-hover.table-bordered");
  if (table == null) {
    return GradeReport(courses: [], gpa: 0.0);
  }

  final List<GradeCourseSummary> list = [];

  final rows = table.querySelectorAll("tr");

  double extractedGPA = 0.0;

  for (var row in rows) {
    final cells = row.querySelectorAll("td");

    // GPA row looks like:
    // <td colspan="14">GPA : 7.67</td>
    if (cells.length == 1 && cells.first.text.contains("GPA")) {
      final gpaText = cells.first.text;
      final gpaValue = gpaText.replaceAll(RegExp(r'[^0-9.]'), '');
      extractedGPA = double.tryParse(gpaValue) ?? 0.0;
      continue;
    }

    // Normal course row requires at least 12 columns
    if (cells.length < 12) continue;

    try {
      final courseCode = cells[1].text.trim();
      final courseTitle = cells[2].text.trim();
      final credits = int.tryParse(cells[7].text.trim()) ?? 0;
      final gradingType = cells[8].text.trim();
      final grade = cells[10].text.trim();

      list.add(
        GradeCourseSummary(
          courseCode: courseCode,
          courseTitle: courseTitle,
          credits: credits,
          gradingType: gradingType,
          grade: grade,
        ),
      );
    } catch (e) {
      print("❌ Error parsing row: $e");
    }
  }

  return GradeReport(courses: list, gpa: extractedGPA);
}
