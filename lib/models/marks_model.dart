class MarkEntry {
  final int serialNo;
  final String markTitle;
  final double maxMark;
  final double weightagePercent;
  final String status;
  final double scoredMark;
  final double weightageMark;

  MarkEntry({
    required this.serialNo,
    required this.markTitle,
    required this.maxMark,
    required this.weightagePercent,
    required this.status,
    required this.scoredMark,
    required this.weightageMark,
  });
}

class CourseMark {
  final int serialNo;
  final String courseCode;
  final String courseTitle;
  final String courseType;
  final String faculty;
  final String slot;
  final String courseMode;

  final List<MarkEntry> marks;

  CourseMark({
    required this.serialNo,
    required this.courseCode,
    required this.courseTitle,
    required this.courseType,
    required this.faculty,
    required this.slot,
    required this.courseMode,
    required this.marks,
  });
}
