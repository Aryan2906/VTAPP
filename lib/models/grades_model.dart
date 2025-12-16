class GradeCourseSummary {
  final String courseCode;
  final String courseTitle;
  final int credits;
  final String gradingType;
  final String grade;

  GradeCourseSummary({
    required this.courseCode,
    required this.courseTitle,
    required this.credits,
    required this.gradingType,
    required this.grade,
  });
}

class GradeReport {
  final List<GradeCourseSummary> courses;
  final double gpa;

  GradeReport({
    required this.courses,
    required this.gpa,
  });
}
