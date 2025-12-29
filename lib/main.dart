import 'package:flutter/material.dart';
import 'package:vtapp/screens/loginpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vtapp/services/notifService.dart';
import 'firebase_options.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  NotifService().initNotification();
  runApp(
    MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(children: [CaptchaPage()],),
      ),
      
    );
  }
}
