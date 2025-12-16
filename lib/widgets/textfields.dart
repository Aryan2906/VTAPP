import 'package:flutter/material.dart';

class Textfields extends StatefulWidget {
  final label;
  final obscure;
  final controller;
  final List<String>? autofillHints; 
  const Textfields({super.key,required this.label,required this.obscure, required this.controller,this.autofillHints = const [AutofillHints.password]});

  @override
  State<Textfields> createState() => _TextfieldsState();
}

class _TextfieldsState extends State<Textfields> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      autofillHints: widget.autofillHints,
      obscureText: widget.obscure,
      controller: widget.controller,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        label: Text("${widget.label}"),
        constraints: BoxConstraints(maxWidth: 300),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(6)),
        )
      ),
    );
  }
}