import 'package:flutter/material.dart';
import 'package:projetoestrutura/telas/anunciosOlx.dart';
import 'package:projetoestrutura/telas/cadastro.dart';
import 'package:projetoestrutura/telas/detalhesAnuncio.dart';
import 'package:projetoestrutura/telas/login.dart';
import 'package:projetoestrutura/telas/meusAnuncios.dart';
import 'package:projetoestrutura/telas/novoAnuncio.dart';

class RouteGenerator {
  // ignore: missing_return
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // ignore: unused_local_variable
    final args = settings.arguments;

    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => Anuncios());
      case "/login":
        return MaterialPageRoute(builder: (_) => Login());

      case "/cadastro":
        return MaterialPageRoute(builder: (_) => Cadastro());

      case "/meus-anuncios":
        return MaterialPageRoute(builder: (_) => MeusAnuncios());

      case "/novo-anuncio":
        return MaterialPageRoute(builder: (_) => NovoAnuncio());

      case "/detalhes-anuncio":
        return MaterialPageRoute(builder: (_) => DetalhesAnuncio(args));  

      default:
        erroTela();
    }
  }

  static Route<dynamic> erroTela() {
    return MaterialPageRoute(builder: (_) {
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
