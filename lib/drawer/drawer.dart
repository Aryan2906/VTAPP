import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:vtapp/bottom_nav/academics.dart';
import 'package:vtapp/bottom_nav/attendancewid.dart';
import 'package:vtapp/bottom_nav/timetable.dart';
import 'package:vtapp/screens/aboutme.dart';
import 'package:vtapp/screens/homepage.dart';
import 'package:vtapp/widgets/attendance.dart';
import 'package:vtapp/widgets/timetable.dart';

class Mydrawer extends StatelessWidget {
  const Mydrawer({super.key});

  Future<String> _getversion() async{
    final info = await PackageInfo.fromPlatform();
    return "Version ${info.version} (${info.buildNumber})";
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
    semanticLabel: "VTAPP",
    width: MediaQuery.of(context).size.width*0.70,
    surfaceTintColor: Colors.purpleAccent,
      child: SafeArea(
        child: Column(
          children: [
            const Text("VTAPP",style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),),
            const Divider(),
            TextButton(onPressed: (){
              Navigator.pop(context);
              Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 300),
                pageBuilder: (_, __, ___) => const Homepage(),
                transitionsBuilder: (_, animation, __, child) {
                  final offsetAnimation = Tween<Offset>(
                    begin: const Offset(1.0, 0.0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutCubic,
                    ),
                  );

                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },
              ),
            );

            }, child: Text("Dashboard",style: TextStyle(
              fontWeight: FontWeight.bold,
            ),)),
            TextButton(onPressed: () {
              Navigator.pop(context);
              Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 300),
                pageBuilder: (_, __, ___) => const Attendance(),
                transitionsBuilder: (_, animation, __, child) {
                  final offsetAnimation = Tween<Offset>(
                    begin: const Offset(1.0, 0.0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutCubic,
                    ),
                  );

                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },
              ),
            );

            }, child: Text("Attendance",style: TextStyle(
              fontWeight: FontWeight.bold,
            ),)),
            TextButton(onPressed: (){
              Navigator.pop(context);
              Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 300),
                pageBuilder: (_, __, ___) => const AcademicsWid(),
                transitionsBuilder: (_, animation, __, child) {
                  final offsetAnimation = Tween<Offset>(
                    begin: const Offset(1.0, 0.0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutCubic,
                    ),
                  );

                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },
              ),
            );

            }, child: Text("Academics" ,style: TextStyle(
              fontWeight: FontWeight.bold
            ),)),
            TextButton(onPressed: (){
              Navigator.pop(context);
              Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 300),
                pageBuilder: (_, __, ___) => const TimeTableWid(),
                transitionsBuilder: (_, animation, __, child) {
                  final offsetAnimation = Tween<Offset>(
                    begin: const Offset(1.0, 0.0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutCubic,
                    ),
                  );

                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },
              ),
            );

            }, child: Text("Time Table" ,style: TextStyle(
              fontWeight: FontWeight.bold
            ),)),
            // ListTile(
            //   leading: const Icon(Icons.question_answer),
            //   title: Text("About Me",style: TextStyle(
            //     fontWeight: FontWeight.bold,
            //     fontSize: 18
            //   ),),
            //   onTap: () {
            //     Navigator.of(context).push(MaterialPageRoute(builder: (context) => Aboutme()));
            //   },
            // ),
            const Spacer(),
          FutureBuilder<String>(
            future: _getversion(),
            builder: (context, snapshot) {
              return Padding(padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                snapshot.data ?? "",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: const Color.fromARGB(255, 63, 63, 63)),
              ),
              );
            },
          )
          ],
        )
        ),

    );
  }
}