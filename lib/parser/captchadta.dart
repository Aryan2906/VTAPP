import 'package:dio/dio.dart';
import 'package:flutter_js/extensions/fetch.dart';
import 'package:html/parser.dart' as html;
import 'package:vtapp/session.dart';
import 'package:vtapp/vtop_client.dart';

class VtopCaptchaService {
  bool? isLoaded;
  final tries = 0;
  final Dio dio = VtopClient.dio;
  String? cookies;
  Future<void> initSession() async {
  final res1 = await dio.get("/login");
  final doc  = html.parse(res1.data);
  final csrf = doc.querySelector("input[name = '_csrf']")?.attributes['value'];
  Session.logincsrf = csrf;

  final res2 = await dio.post("/prelogin/setup",
  data: {
    "_csrf" : csrf,
    "flag" : "VTOP"
  },
  options: Options(
    contentType: Headers.formUrlEncodedContentType));

  final res3 = await dio.get("/init/page");
  // final res4 = await dio.get("/open/page");
  // print("open/page = ${res4.statusCode}");  
  }



  
  Future<String> fetchCaptchaBase64() async {
    await initSession();

    final response = await dio.get("/captcha");
    // print(response.data.toString().substring(4000,5000));
    final doc = html.parse(response.data);
    final img = doc.querySelector("img");
    final src = img?.attributes["src"];
    if (src == null || !src.contains("base64,")) {
      isLoaded = false;
      throw Exception("Captcha not found");
    }
    isLoaded = true;
    debug("Captcha Loaded");
    return src.split("base64,").last;

  
  }
}