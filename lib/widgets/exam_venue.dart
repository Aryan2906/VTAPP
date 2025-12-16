  import 'package:flutter/material.dart';
  import 'package:vtapp/models/exam_schedule_model.dart';
  import 'package:vtapp/parser/exam_venue_data.dart';
  import 'package:vtapp/parser/exam_venue_parser.dart';
  import 'package:vtapp/session.dart';

  class ExamVenueWid extends StatefulWidget {
    const ExamVenueWid({super.key});

    @override
    State<ExamVenueWid> createState() => _ExamVenueWidState();
  }

  class _ExamVenueWidState extends State<ExamVenueWid> {
    bool isLoading = false;
    bool hasLoadedonce = false;
    bool semChange = false;
    String? selectedSem;
    Future<void> loadVenue(semId) async{
      setState(() {
        isLoading = true;
      });
      if (Session.examVenueModel == null && hasLoadedonce == false){
      Session.examVenueHtml = await PostDataVenue().fetchVenue(semId);
      Session.examVenueModel = parseExamScheduleHtml();
      }
      else if (semChange == true  ){
        Session.examVenueHtml = await PostDataVenue().fetchVenue(semId);
        Session.examVenueModel = parseExamScheduleHtml();
      }
      else{}
      setState(() {
        isLoading = false;
      });
    }

    @override
    void initState() {
      loadVenue(Session.semesterID!.values.first);
      super.initState();
    }

    @override
    Widget build(BuildContext context) {
      final venue = Session.examVenueModel;
      if (venue == null) {
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
              loadVenue(semId);
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
                itemCount: venue.length,
                itemBuilder: (context, index) {
                  ExamGroup item = venue[index];
                  
                  return Card(
                    margin: const EdgeInsets.all(15),
                    child: ListTile(
                      title: Text(item.type),
                      onTap: () {
                        final itemdetails = item.exams;
                        showModalBottomSheet(
  context: context,
  builder: (context) {
    return SizedBox(
      height: 400,
      child: ListView.builder(
        padding: const EdgeInsets.all(25),
        itemCount: itemdetails.length,
        itemBuilder: (context, index) {
          final exam = itemdetails[index];

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 5),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${exam.courseCode} - ${exam.courseTitle}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),
                  Text("Slot: ${exam.slot}"),
                  Text("Date: ${exam.examDate ?? '-'}"),
                  Text("Session: ${exam.examSession ?? '-'}"),
                  Text("Time: ${exam.examTime ?? '-'}"),
                  Text("Venue: ${exam.venue ?? '-'}",style: TextStyle(
                    fontWeight: FontWeight.bold
                  )),
                  Text(
                    "Seat: ${exam.seatNo ?? '-'} (${exam.seatLocation ?? '-'})",
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    )
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  },
);

                      },
                    ),
                  );
                },
              ),
            ),
          ],
      );
    }
  }
