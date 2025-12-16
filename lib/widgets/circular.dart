import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CircularTotal extends StatefulWidget {
  final double percent;
  const CircularTotal({super.key,required this.percent});

  @override
  State<CircularTotal> createState() => _CircularTotalState();
}

class _CircularTotalState extends State<CircularTotal> {
  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 25,
      percent: widget.percent,
      progressColor: widget.percent*100<76?Colors.red:Colors.purple,
      center: Text((widget.percent*100).ceil().toString(),style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20
      ),),
    );
  }
}