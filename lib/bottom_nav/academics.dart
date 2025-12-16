import 'package:flutter/material.dart';
import 'package:vtapp/widgets/exam_venue.dart';
import 'package:vtapp/widgets/getGPA.dart';
import 'package:vtapp/widgets/grades.dart';
import 'package:vtapp/widgets/marks.dart';
class AcademicsWid extends StatefulWidget {
  const AcademicsWid({super.key});

  @override
  State<AcademicsWid> createState() => _AcademicsWidState();
}

class _AcademicsWidState extends State<AcademicsWid> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 3,
    child:Scaffold(
      appBar: AppBar(
        title: GetGPA(),
        centerTitle: true,
        bottom: const TabBar(
            tabs: <Widget>[
              Tab(child: Row(children: [Icon(Icons.wysiwyg_outlined),Text(" Marks",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20,),)],),),
              Tab(child: Row(children: [Icon(Icons.calculate_rounded),Text(" GPA",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20,),)],),),
              Tab(child: Row(children: [Icon(Icons.calculate_rounded),Text(" Venue",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20,),)],),),
            ],
          ),
      ),
      body: const TabBarView(children: <Widget>[
        Center(child: MarksWid()),
        Center(child: GradesWid()),
        Center(child: ExamVenueWid())
      ]),
    )
    );
  }
}