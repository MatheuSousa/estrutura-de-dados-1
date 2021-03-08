import 'package:flutter/material.dart';
import 'package:projetoestrutura/telas/anunciosOlx.dart';
import 'package:projetoestrutura/telas/login.dart';

class RouteGenerator{

  static Route<dynamic> generateRoute(RouteSettings settings){

    final args = settings.arguments;

    switch(settings.name){
      case "/":
        return MaterialPageRoute(
            builder: (_) => Anuncios() );
      case "/login":
        return MaterialPageRoute(
            builder: (_) => Login() );

      default:
        erroTela();
    }
  }


  static Route<dynamic> erroTela(){
    return MaterialPageRoute(
        builder: (_){
          return Scaffold(
            appBar: AppBar(
              title: Text("Erro de rota"),
              centerTitle: true,
            ),

            body: Center(
              child: Text("Tela não encotnrada!"),
            ),
          );
        });
  }
}