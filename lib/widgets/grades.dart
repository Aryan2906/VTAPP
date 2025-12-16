import 'package:flutter/material.dart';
import 'package:vtapp/models/grades_model.dart';
import 'package:vtapp/parser/grades_parser.dart';
import 'package:vtapp/parser/gradesdta.dart';
import 'package:vtapp/session.dart';

class GradesWid extends StatefulWidget {
  const GradesWid({super.key});

  @override
  State<GradesWid> createState() => _GradesWidState();
}

class _GradesWidState extends State<GradesWid> {
  bool gotGPA = false;
  bool isLoading = false;
  bool hasLoadedonce = false;
  bool semChange = false;
  String? selectedSem;
  Future<void> loadGrades(semId) async{
    setState(() {
      isLoading = true;
    });
    if (Session.subjects == null && hasLoadedonce == false){
    Session.gradesHtml = await PostDataGrades().fetchGrades(semId);
    Session.subjects = parseGradeTable();
    }
    else if(semChange == true){
      Session.gradesHtml = await PostDataGrades().fetchGrades(semId);
      Session.subjects = parseGradeTable();
    }
    else{}
    // Session.gpamodel = await PostDataGPA().fetchGPA();
    // Session.GPAinfo = parseGPA();
    if (Session.subjects!.gpa == 0.0){
      gotGPA = false;
    }
    else{gotGPA = true;}
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    loadGrades(Session.semesterID!.values.first);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final grades = Session.subjects;
    if (grades == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
        children: [
          const SizedBox(height: 10),
          DropdownButton<String?>(hint: Text("Choose Semester"),value: selectedSem,items: Session.semesterID?.keys.map((name) {
            return DropdownMenuItem(child: Text(name),value: name);
          }).toList(), onChanged: (value) {
            setState(() {
              semChange = true;
              selectedSem = value;
            });
            final semId = Session.semesterID![value]!;
            loadGrades(semId);
            if(grades.gpa == 0.0){
              gotGPA = false;
            }
            else{
              gotGPA = true;
            }
          }),
          gotGPA?
          Text("Semester GPA: ${grades.gpa}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
          :
          Text(" "),


          Expanded(
           child: isLoading 
          ? AspectRatio(aspectRatio: 1.0 , child: SizedBox(
            height: 50,
            width: 50,
            child: CircularProgressIndicator())
          )
             : 
          ListView.builder(
              itemCount: grades.courses.length,
              itemBuilder: (context, index) {
                GradeCourseSummary item = grades.courses[index];
                return Card(
                  margin: const EdgeInsets.all(15),
                  child: ListTile(
                    title: Text("${item.courseCode}-${item.courseTitle}"),
                    subtitle: Text(
                      "Credits: ${item.credits} \nGrading Type: ${item.gradingType}"
                    ),
                    leading: Text("${item.grade}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40),),
                  ),
                );
              },
            ),
          ),
        ],
    );
  }
}
