import 'package:flutter/material.dart';
import 'package:vtapp/bottom_nav/attendancewid.dart';
import 'package:vtapp/bottom_nav/timetable.dart';
import 'package:vtapp/drawer/drawer.dart';
import 'package:vtapp/screens/notices.dart';
import 'package:vtapp/services/updateService.dart';
import 'package:vtapp/session.dart';
import 'package:vtapp/widgets/logout.dart';
import 'package:vtapp/widgets/spotlight.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ForceUpdateService.check(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Mydrawer(),
      appBar: AppBar(
        foregroundColor: Colors.white,
        surfaceTintColor: Colors.purple,
        centerTitle: true,
        title: Text("Welcome ${Session.regNo}",style: TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),),
        backgroundColor: Colors.purple,
        // leading: IconButton(onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (context) => notifications()));}, icon: Icon(Icons.notifications,color: Colors.white,)),
        actions: [LogoutBtn()],
      ),
      body:Center(
          child: SpotlightWid(),
        ),
      );
  }
}