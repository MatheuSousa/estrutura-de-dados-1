import 'package:flutter/material.dart';

class TextFieldCustomizado extends StatelessWidget {

  final TextEditingController controller;
  final String hint;
  final String label;
  final bool obscure;
  final bool autofocus;
  final TextInputType type;


  TextFieldCustomizado({this.controller, this.hint ,this.label ,
    this.obscure = false,this.autofocus = false, this.type = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: this.controller,
      obscureText: obscure,
      autofocus: this.autofocus,
      keyboardType: this.type,
      style: TextStyle(
          fontSize: 20
      ),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
          hintText: this.hint,
          labelText: this.label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6)
          )
      ),
    );
  }
}
