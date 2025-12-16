import 'package:flutter/material.dart';
import 'package:vtapp/models/marks_model.dart';
import 'package:vtapp/parser/marks_parser.dart';
import 'package:vtapp/parser/marksdta.dart';
import 'package:vtapp/session.dart';
import 'package:vtapp/widgets/circular.dart';

class MarksWid extends StatefulWidget {
  const MarksWid({super.key});

  @override
  State<MarksWid> createState() => _MarksWidState();
}

class _MarksWidState extends State<MarksWid> {
  bool isLoading = false;
  bool hasLoadedonce = false;
  bool semChange = false;
  String? selectedSem;
  Future<void> loadMarks(semId) async{
    setState(() {
      isLoading = true;
    });
    if (Session.marksInfo == null && hasLoadedonce == false){
    Session.marksmodel = await PostDataMarks().fetchMarks(semId);
    Session.marksInfo = parseMarks();
    }
    else if (semChange == true){
      Session.marksmodel = await PostDataMarks().fetchMarks(semId);
      Session.marksInfo = parseMarks();
    }
    else{}
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    loadMarks(Session.semesterID!.values.first);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final marks = Session.marksInfo;
    if (marks == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
        children: [
          const SizedBox(height: 10),
          DropdownButton<String?>(hint: Text("Choose Semester"),value: selectedSem,items: Session.semesterID?.keys.map((name) {
            return DropdownMenuItem(child: Text(name),value: name);
          }).toList(), onChanged: (value) {
            setState(() {
              selectedSem = value;
              semChange = true;
            });
            final semId = Session.semesterID![value]!;
            loadMarks(semId);
          }),

          Expanded(
           child: isLoading 
          ? AspectRatio(aspectRatio: 1.0 , child: SizedBox(
            height: 50,
            width: 50,
            child: CircularProgressIndicator())
          )
             : 
          ListView.builder(
              itemCount: marks.length,
              itemBuilder: (context, index) {
                CourseMark item = marks[index];
                String markString = "";
                double total = 0;
                double scoredWeight = 0;
                for(var v in item.marks){
                  total = total + v.weightagePercent;
                  scoredWeight = scoredWeight + v.weightageMark;
                  markString = markString + "${v.markTitle} - ${v.scoredMark}/${v.maxMark}" + "\n";
                }
                return Card(
                  margin: const EdgeInsets.all(15),
                  child: ListTile(
                    title: Text("${item.courseTitle} \n${item.courseCode} - ${item.faculty}\n${item.slot}"),
                    subtitle: Text(
                      markString,
                    ),
                    leading:CircularTotal(percent: scoredWeight/total),
                  ),
                );
              },
            ),
          ),
        ],
    );
  }
}
