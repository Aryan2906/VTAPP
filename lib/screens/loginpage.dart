import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tiny_alert/tiny_alert.dart';
import 'package:vtapp/screens/homepage.dart';
import 'package:vtapp/services/fetchSem.dart';
import 'package:vtapp/session.dart';
import 'package:vtapp/vtop_client.dart';
import 'package:vtapp/widgets/textfieldCaptcha.dart';
import 'package:vtapp/widgets/textfieldUsername.dart';
import 'package:vtapp/widgets/textfields.dart';
import '../parser/captchadta.dart';
import 'package:html/parser.dart' as html;

class CaptchaPage extends StatefulWidget {
  const CaptchaPage({super.key});

  @override
  State<CaptchaPage> createState() => _CaptchaPageState();
}

class _CaptchaPageState extends State<CaptchaPage> {
  late ImageProvider bg;
  bool isLoading = false;
  final service = VtopCaptchaService();
  final regno = TextEditingController();
  final pass = TextEditingController();
  final captcha = TextEditingController();
  Future<String> cookiesAsString() async {
  final uri = Uri.parse("https://vtop.vitbhopal.ac.in");
  final cookies = await VtopClient.cookieJar.loadForRequest(uri);

  return cookies.map((c) => "${c.name}=${c.value}").join("; ");
}
Future<void> testResponse(Dio dio) async{
    final errorpage = await dio.get("/login/error");
    if (errorpage.data.toString().contains("Invalid Captcha")){
      TinyAlert.error(context, title: "Invalid Captcha", message: "Re-Enter the captcha once again");
    }
    else if(errorpage.data.toString().contains("Invalid LoginId/Password")){
      TinyAlert.error(context, title: "Invalid Credentials", message: "");
    }
    loadCaptcha();
  }

  Future<void> getSemesters() async{
    final getSem = await FirestoreService.semesters.collection("semesters").doc("semesterid").get();
    final data = getSem.data();
    Session.semesterID = data;
    print(data);
  }

  String? _base64;

  @override
  void initState() {
    super.initState();
    loadCaptcha();
    bg = const AssetImage("assets/loginpage.jpeg");
    getSemesters();
    WidgetsBinding.instance.addPostFrameCallback((_) {
    precacheImage(bg, context);
  });
  }

  Future<void> loadCaptcha() async {
    setState(() {
      _base64 = null;
    });
    for(int i = 1; i<10;i++){
      try {
        final img = await service.fetchCaptchaBase64();
        if (img != null && img.isNotEmpty) {
        setState(() => _base64 = img);
        return;
      }
      } catch (_) {}
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Tries:${i}"),duration: Duration(seconds: 2),));
      await Future.delayed(Duration(seconds: 2));
    }

    TinyAlert.error(context, title: "Captcha Not Loaded",message: "There was an error loading the captcha");
    setState(() {
      _base64 = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
        Positioned.fill(child: Image(image: bg,
          fit: BoxFit.cover,)),
          Positioned(
            top: 120,
            left: 25,
            right: 25,
            height: 400,
            child: Card(),
          ),
              Positioned.fill(
                top: 160,
                right: 25,
                left: 25,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [                      /// Username + Password
                      AutofillGroup(
                        child: Column(
                          children: [
                            Textfieldregno(
                              controller: regno,
                              label: "Registration Number",
                              obscure: false,
                            ),
                            SizedBox(height: 10),
                            Textfields(
                              label: "Password",
                              obscure: true,
                              controller: pass,
                            ),
                          ],
                        ),
                      ),
                  
                      SizedBox(height: 10),
                  
                      /// Captcha Input
                      TextfieldCaptcha(
                        label: "Captcha",
                        obscure: false,
                        controller: captcha,
                      ),
                  
                      SizedBox(height: 5),
                  
                      /// Captcha Image + Login Button
                      _base64 == null
                          ? const CircularProgressIndicator()
                          : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                             children: [ Image.memory(base64Decode(_base64!)),
                              const SizedBox(height: 20), 
                              isLoading 
                              ? CircularProgressIndicator() 
                              : ElevatedButton(
                                onPressed: () async
                                { setState(() { isLoading = true; });
                                 final Dio dio = VtopClient.dio;
                                  Session.regNo = regno.text.toUpperCase().trim();
                                   final loginres = await dio.post("/login",data:{
                                     "_csrf" : Session.logincsrf,
                                      "username" : Session.regNo,
                                       "password" : pass.text.trim(),
                                        "captchaStr" : captcha.text.toUpperCase()
                                        },
                                        options: Options(
                                          headers: { "Referer" : "https://vtop.vitbhopal.ac.in/vtop/login" },
                                          contentType: Headers.formUrlEncodedContentType,
                                          followRedirects: true,
                                          validateStatus: (status) => status == 200 || status == 302, ),);
                                          if(loginres.headers["location"]!.contains("/vtop/login/error")){ 
                                            testResponse(dio);
                                            loadCaptcha(); 
                                            setState(() { isLoading=false; }); 
                                            } 
                                          else{ 
                                          final dash = await dio.get("/main/page");
                                          final dash1 = await dio.get("/open");
                                          final docCsrf = html.parse(dash1.data); 
                                          final dashBoardcsrf = docCsrf.querySelector('input[name ="_csrf"]')!.attributes['value']; 
                                          Session.dashboardcsrf = dashBoardcsrf; final cookieHeader = await cookiesAsString(); 
                                          setState(() { isLoading = false; }); 
                                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Homepage()),(Route<dynamic> route) => false,); } },
                                          child: Icon(Icons.login),) ], ),
                  
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ]),
            floatingActionButton: FloatingActionButton(onPressed: (){
              loadCaptcha();
            },
            child: Icon(Icons.replay)),
                );
  }
}
