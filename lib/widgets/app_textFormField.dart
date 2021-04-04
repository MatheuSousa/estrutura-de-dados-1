import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppTextFormField extends StatelessWidget {
  String hint;
  IconData icon;
  bool password;
  Function onTap;
  TextEditingController controller;
  FormFieldValidator<String> validator;
  TextInputType textInputType;
  TextInputAction textInputTypeAction;
  FocusNode focusNode;
  FocusNode nextFocus;
  Color fillcolor;
  Color disabledColor;
  bool enabled;

  AppTextFormField(this.hint, this.icon,
      {this.password = false,
      this.controller,
      this.validator,
      this.textInputType,
      this.textInputTypeAction,
      this.focusNode,
      this.nextFocus,
      this.onTap,
      this.fillcolor,
      this.disabledColor,
      this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: password,
      validator: validator,
      keyboardType: textInputType,
      textInputAction: textInputTypeAction,
      focusNode: focusNode,
      onTap: onTap,
      enabled: enabled,
      cursorColor: Colors.black,
      style: TextStyle(
        fontFamily: 'BreeSerif',
        color: Colors.black,
      ),
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: icon == null
            ? null
            : Icon(
                icon,
                color: Color(0xff9c27b0),
              ),
        contentPadding:
            icon == null ? EdgeInsets.fromLTRB(15, 2, 2, 2) : EdgeInsets.all(2),
        filled: true,
        hintStyle: TextStyle(
          fontFamily: 'BreeSerif',
          fontSize: 16,
        ),
        //Enabled sem cursor
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        //Enabled com cursor
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
