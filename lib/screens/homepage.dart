import 'package:flutter/material.dart';
import 'package:vtapp/bottom_nav/academics.dart';
import 'package:vtapp/bottom_nav/dashboard.dart';
import 'package:vtapp/bottom_nav/timetable.dart';
import 'package:vtapp/screens/notices.dart';
import 'package:vtapp/session.dart';
import 'package:vtapp/widgets/logout.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    Dashboard(),
    AcademicsWid(),
    TimeTableWid(),
  ];
  
  void _onTappeditem(int index){
    setState(() {
      selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          child:_widgetOptions.elementAt(selectedIndex)
        ),
        bottomNavigationBar: BottomNavigationBar(items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.dashboard),label: "Dashboard"),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book_sharp),label: "Academics"),
          BottomNavigationBarItem(icon: Icon(Icons.timer),label: "Time Table")
        ],currentIndex: selectedIndex,
        selectedItemColor: Colors.purple,
        onTap: _onTappeditem),
      );
  }
}