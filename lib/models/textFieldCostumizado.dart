import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldCustomizado extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String label;
  final bool obscure;
  final bool autofocus;
  final TextInputType type;
  final List<TextInputFormatter> inputFormatters;
  final int maxLines;
  final Function(String) validator;
  final Function(String) onSaved;

  TextFieldCustomizado({
    this.controller,
    this.hint,
    this.label,
    this.obscure = false,
    this.autofocus = false,
    this.type = TextInputType.text,
    this.inputFormatters,
    this.maxLines = 1,
    this.validator,
    this.onSaved
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: this.controller,
      obscureText: obscure,
      autofocus: this.autofocus,
      keyboardType: this.type,
      inputFormatters: this.inputFormatters,
      validator: this.validator,
      maxLines: this.maxLines,
      onSaved: onSaved,
      style: TextStyle(fontSize: 20),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
          hintText: this.hint,
          labelText: this.label,
          filled: true,
          fillColor: Colors.white,
          
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6))),
    );
  }
}
