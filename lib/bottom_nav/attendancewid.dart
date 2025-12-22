import 'package:flutter/material.dart';
import 'package:vtapp/drawer/drawer.dart';
import 'package:vtapp/widgets/attendance.dart';
import 'package:vtapp/widgets/logout.dart';
class Attendance extends StatefulWidget {
  const Attendance({super.key});

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Mydrawer(),
      appBar: AppBar(
        backgroundColor: Colors.purple,
        actions: [LogoutBtn()],
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text("Attendance",style: TextStyle(
          fontWeight: FontWeight.bold
        ),),
      ),
      body: Center(child: AttendanceWid(),)
    );
  }
}