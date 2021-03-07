import 'package:flutter/material.dart';
import 'package:projetoestrutura/home.dart';

final ThemeData padrao = ThemeData(
  primaryColor: Color(0xff9c27b0),
  accentColor: Color(0xff7b1fa2),
);
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
    theme: padrao ,
  ));
}



