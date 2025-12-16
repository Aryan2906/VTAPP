import 'package:vtapp/vtop_client.dart';
import 'package:dio/dio.dart';
import 'package:vtapp/session.dart';

class PostDataGrades{
  Future<String> cookiesAsString() async {
  final uri = Uri.parse("https://vtop.vitbhopal.ac.in");
  final cookies = await VtopClient.cookieJar.loadForRequest(uri);

  return cookies.map((c) => "${c.name}=${c.value}").join("; ");
}
Future<String?> fetchGrades(String semId) async {
  final dio = VtopClient.dio;
  final cookieHeader = await cookiesAsString();

  final res = await dio.post(
    "/examinations/examGradeView/doStudentGradeView",
    data: {
      "_csrf": Session.dashboardcsrf,
      "authorizedID": Session.regNo,
      "semesterSubId" : semId
    },
    options: Options(
      contentType: Headers.formUrlEncodedContentType,
      headers: {
        "Cookie": cookieHeader,
        "Origin": "https://vtop.vitbhopal.ac.in",
        "Referer": "https://vtop.vitbhopal.ac.in/vtop/content",
      },
    ),
  );
  return res.data.toString();

  }
}