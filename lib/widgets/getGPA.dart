import 'package:flutter/material.dart';
import 'package:vtapp/models/gpa_model.dart';
import 'package:vtapp/parser/gpa_parser.dart';
import 'package:vtapp/parser/gpadata.dart';
import 'package:vtapp/session.dart';

class GetGPA extends StatefulWidget {
  const GetGPA({super.key});

  @override
  State<GetGPA> createState() => _GetGPAState();
}

class _GetGPAState extends State<GetGPA> {
  bool hasLoaded = false;

  Future<GpaModel?> loadGPA() async {
    if(Session.GPAinfo == null && hasLoaded == false){
    Session.gpamodel = await PostDataGPA().fetchGPA();
    Session.GPAinfo = parseGPA();
    }
    else{}
    setState(() {});
  }

  @override
  void initState(){
    loadGPA();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (Session.GPAinfo == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Text("CGPA: ${Session.GPAinfo!.GPA}",style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold
      ),);
  }
}
