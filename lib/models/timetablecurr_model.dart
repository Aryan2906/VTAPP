import 'package:vtapp/models/timetable_model.dart';

class TimetablecurrModel extends TimetableModel{
    String? currentslot;
    String? startTime;
    String? endTime;

   TimetablecurrModel({
    required String? courseCode,
    required String? courseName,
    required List<String?> slot,
    required String? facultyDetail,
    required String? credits,
    required String? venue,
    required this.currentslot,
    required this.startTime,
    required this.endTime,
  }) : super(
          courseCode: courseCode,
          courseName: courseName,
          slot: slot,
          facultyDetail: facultyDetail,
          credits: credits,
          venue: venue,
        );
}
