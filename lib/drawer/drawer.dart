import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:vtapp/screens/aboutme.dart';

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
            Text("Coming Soon",style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20
            ),),
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