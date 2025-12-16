import 'package:flutter/material.dart';
import 'package:vtapp/widgets/timetable.dart';

class TimeTableWid extends StatefulWidget {
  const TimeTableWid({super.key});

  @override
  State<TimeTableWid> createState() => _TimeTableWidState();
}

class _TimeTableWidState extends State<TimeTableWid> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TimeTable(),
    );
  }
}