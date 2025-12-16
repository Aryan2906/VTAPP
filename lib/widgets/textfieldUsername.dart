import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class Textfieldregno extends StatefulWidget {
  final label;
  final obscure;
  final controller;
  final List<String>? autofillHints; 
  const Textfieldregno({super.key,required this.label,required this.obscure, required this.controller,this.autofillHints = const [AutofillHints.username]});

  @override
  State<Textfieldregno> createState() => _TextfieldregnoState();
}

class _TextfieldregnoState extends State<Textfieldregno> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      autofillHints: widget.autofillHints,
      inputFormatters: [UpperCaseTextFormatter()],
      obscureText: widget.obscure,
      controller: widget.controller,
      keyboardType: TextInputType.text,
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