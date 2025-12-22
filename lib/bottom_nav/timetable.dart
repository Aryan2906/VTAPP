import 'package:flutter/material.dart';
import 'package:vtapp/drawer/drawer.dart';
import 'package:vtapp/widgets/logout.dart';
import 'package:vtapp/widgets/timetable.dart';

class TimeTableWid extends StatefulWidget {
  const TimeTableWid({super.key});

  @override
  State<TimeTableWid> createState() => _TimeTableWidState();
}

class _TimeTableWidState extends State<TimeTableWid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        actions: [LogoutBtn()],
        foregroundColor: Colors.white,
        title: Text("Time Table",style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white
        ),),
        centerTitle: true,
      ),
      drawer: const Mydrawer(),
      body: Center(child: TimeTable()),
    );
  }
}