import 'package:dio/dio.dart';
import 'package:vtapp/session.dart';
import 'package:vtapp/vtop_client.dart';

class PostDataGPA{
  Future<String> cookiesAsString() async {
  final uri = Uri.parse("https://vtop.vitbhopal.ac.in");
  final cookies = await VtopClient.cookieJar.loadForRequest(uri);
  return cookies.map((c) => "${c.name}=${c.value}").join("; ");
}

  Future<String?> fetchGPA() async {
  final dio = VtopClient.dio;
  final cookieHeader = await cookiesAsString();

  final res = await dio.post(
    "/examinations/examGradeView/StudentGradeHistory",
    data: {
      "verifyMenu": "true",
      "_csrf": Session.dashboardcsrf,
      "authorizedID": Session.regNo,
      "nocache": DateTime.now().millisecondsSinceEpoch.toString(),
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