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

class TextfieldCaptcha extends StatefulWidget {
  final label;
  final obscure;
  final controller;
  const TextfieldCaptcha({super.key,required this.label,required this.obscure, required this.controller});

  @override
  State<TextfieldCaptcha> createState() => _TextfieldCaptchaState();
}

class _TextfieldCaptchaState extends State<TextfieldCaptcha> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      inputFormatters: [UpperCaseTextFormatter()],
      maxLength: 6,
      obscureText: widget.obscure,
      controller: widget.controller,
      textInputAction: TextInputAction.done,
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