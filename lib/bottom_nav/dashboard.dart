import 'package:flutter/material.dart';
import 'package:vtapp/widgets/attendance.dart';
class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [AttendanceWid()],
    );
  }
}