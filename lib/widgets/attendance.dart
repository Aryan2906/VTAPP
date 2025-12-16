import 'package:flutter/material.dart';
import 'package:vtapp/models/attendance_model.dart';
import 'package:vtapp/parser/attdata.dart';
import 'package:vtapp/parser/attendance_parser.dart';
import 'package:vtapp/session.dart';
import 'package:vtapp/widgets/circular.dart';

class AttendanceWid extends StatefulWidget {
  const AttendanceWid({super.key});

  @override
  State<AttendanceWid> createState() => _AttendanceWidState();
}

class _AttendanceWidState extends State<AttendanceWid> {
  bool isLoading = false;
  bool hasLoadedonce = false;
  bool semChange = false;
  String? selectedSem;
  Future<void> loadAttendance(semId) async{
    setState(() {
      isLoading = true;
    });
    if (Session.attmodel == null && hasLoadedonce == false){
    Session.attmodel = await PostData().sendVtopRequest(semId);
    Session.attinfo = parseAttendance();
    }
    else if(semChange){
      Session.attmodel = await PostData().sendVtopRequest(semId);
      Session.attinfo = parseAttendance();
    }
    else{}
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    loadAttendance(Session.semesterID!.values.first);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final attendance = Session.attinfo;
    if (attendance == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Expanded(
      // width: MediaQuery.of(context).size.width * 0.95,
      // height:MediaQuery.of(context).size.width * 1,
      // margin: EdgeInsets.only(
      //   left: MediaQuery.of(context).size.width * 0.025,
      //   top: 15,
        
      // ),
      child:Column(
        children: [
          const SizedBox(height: 10),
          Text(
            "Attendance",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          DropdownButton<String?>(hint: Text("Choose Semester"),value: selectedSem,items: Session.semesterID?.keys.map((name) {
            return DropdownMenuItem(child: Text(name),value: name);
          }).toList(), onChanged: (value) {
            setState(() {
              selectedSem = value;
              semChange = true;
            });
            final semId = Session.semesterID![value]!;
            loadAttendance(semId);
          }),

          Expanded(
           child: isLoading 
          ? AspectRatio(aspectRatio: 1.0,child: CircularProgressIndicator())
             : 
          ListView.builder(
              itemCount: attendance.length,
              itemBuilder: (context, index) {
                AttendanceModel item = attendance[index];
                if (item.attended == "-"){
                  item.attended = "100";
                  item.total = "100";
                }
                if(item.debarStatus != "-"){
                  item.debarStatus = "Permitted";
                }
                else{
                  item.debarStatus = "Debarred";
                }

                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.all(15),
                  child: ListTile(
                    title: Text(item.courseDetail),
                    subtitle: Text(
                      "${item.attended}/${item.total}     ${item.percentage} \n${item.facultyDetail} \nDebar Status: ${item.debarStatus}",
                    ),
                    leading:CircularTotal(percent:double.parse(item.attended)/double.parse(item.total)),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
