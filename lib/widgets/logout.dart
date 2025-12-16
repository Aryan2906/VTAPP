import 'package:flutter/material.dart';
import 'package:vtapp/screens/loginpage.dart';
import 'package:vtapp/vtop_client.dart';

class LogoutBtn extends StatefulWidget {
  const LogoutBtn({super.key});

  @override
  State<LogoutBtn> createState() => _LogoutBtnState();
}

class _LogoutBtnState extends State<LogoutBtn> {
  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: () {
      VtopClient.cookieJar.deleteAll();
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => CaptchaPage()), (Route<dynamic> route) => false);
    }, icon: Icon(Icons.logout,color: Colors.white));
  }
}