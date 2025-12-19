import 'package:flutter/material.dart';
import 'package:vtapp/session.dart';

class Aboutme extends StatelessWidget {
  const Aboutme({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.purple,
        title: Text("About Me",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),),
      ),
      body: Center(
        child: Column(
          children: [Text("Hello ${Session.regNo}!",style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20
          ),),
          Text("I'm Aryan the creator of VTAPP",style: TextStyle(
            overflow: TextOverflow.ellipsis,
            fontWeight: FontWeight.w600,
            fontSize: 18
          ),)
          ],
        ),
      ),
    );
  }
}