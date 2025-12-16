class ExamSchedule {
  final String courseCode;
  final String courseTitle;
  final String slot;
  final String? examDate;
  final String? examSession;
  final String? reportingTime;
  final String? examTime;
  final String? venue;
  final String? seatLocation;
  final String? seatNo;

  ExamSchedule({
    required this.courseCode,
    required this.courseTitle,
    required this.slot,
    this.examDate,
    this.examSession,
    this.reportingTime,
    this.examTime,
    this.venue,
    this.seatLocation,
    this.seatNo,
  });
}

class ExamGroup {
  final String type; // "FAT", "MT", "CAT", etc.
  final List<ExamSchedule> exams;

  ExamGroup({
    required this.type,
    required this.exams,
  });
}
