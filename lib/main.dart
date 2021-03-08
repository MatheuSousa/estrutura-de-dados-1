import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projetoestrutura/routeGenerator.dart';
import 'package:projetoestrutura/telas/anunciosOlx.dart';
import 'package:projetoestrutura/telas/login.dart';


final ThemeData padrao = ThemeData(
  primaryColor: Color(0xff9c27b0),
  accentColor: Color(0xff7b1fa2),
);
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Anuncios(),
    theme: padrao ,
    initialRoute: "/",
    onGenerateRoute: RouteGenerator.generateRoute,
  ));
}



