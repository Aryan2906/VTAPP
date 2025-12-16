import 'package:vtapp/models/gpa_model.dart';
import 'package:vtapp/session.dart';
import 'package:html/parser.dart' as http;
GpaModel? parseGPA(){
  final document = http.parse(Session.gpamodel);
  final cgpatable = document.querySelector("div.box-body table.table.table-hover.table-bordered");
  final row = cgpatable?.querySelector("tbody tr");
  final cells = row?.querySelectorAll("td");
  final model = GpaModel(GPA: cells![2].text, Credits: cells[1].text);
  return model;
}