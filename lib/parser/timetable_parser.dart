import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:vtapp/session.dart';
import 'package:vtapp/vtop_client.dart';

class PostDataTimeTable{
  String generateX() {
    final now = DateTime.now().toUtc();
    return DateFormat("EEE, dd MMM yyyy HH:mm:ss 'GMT'", "en_US").format(now);
  }
  Future<String> cookiesAsString() async {
  final uri = Uri.parse("https://vtop.vitbhopal.ac.in");
  final cookies = await VtopClient.cookieJar.loadForRequest(uri);

  return cookies.map((c) => "${c.name}=${c.value}").join("; ");
}




Future<String> getTimeTable(String? semId)
 async {
  final dio = VtopClient.dio;
  final cookieHeader = await cookiesAsString();
  final response = await dio.post("/processViewTimeTable",
  data: {
    "_csrf" : Session.dashboardcsrf,
    "authorizedID" : Session.regNo,
    "semesterSubId" : semId,
    "x" : generateX(),
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


  return response.data.toString();
}

}