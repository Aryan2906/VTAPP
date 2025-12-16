class AttendanceModel {
  final String slNo;
  final String classGroup;
  final String courseDetail;
  final String classDetail;
  final String facultyDetail;
  String attended;
  String total;
  String debarStatus;
  final String percentage;

  AttendanceModel({
    required this.slNo,
    required this.classGroup,
    required this.courseDetail,
    required this.classDetail,
    required this.facultyDetail,
    required this.attended,
    required this.total,
    required this.debarStatus,
    required this.percentage,
  });
}