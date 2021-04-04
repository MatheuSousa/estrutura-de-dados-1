import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projetoestrutura/utils/configuracoes.dart';

class Anuncios extends StatefulWidget {
  @override
  _AnunciosState createState() => _AnunciosState();
}

class _AnunciosState extends State<Anuncios> {
  List<String> itensMenu = [];

  String itemSelecionadoEstado;
  String itemSelecionadoCategoria;
  List<DropdownMenuItem<String>> _listaItensEstados = List();
  List<DropdownMenuItem<String>> _listaItensCategorias = List();

  itemEscolhido(String itemEscolhido) {
    switch (itemEscolhido) {
      case "Meus anúncios":
        Navigator.pushNamed(context, "/meus-anuncios");
        break;
      case "Entrar / Cadastrar":
        Navigator.pushNamed(context, "/login");
        break;

      case "Deslogar":
        deslogarUsuario();
        break;
    }
  }

  Future verificarUsuarioLogado() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    User usuarioLogado = auth.currentUser; //RECUPERAR O USUARIO LOGADO

    usuarioLogado == null
        ? itensMenu = ["Entrar / Cadastrar"]
        : itensMenu = ["Meus anúncios", "Deslogar"];
  }

  deslogarUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    Navigator.pushNamed(context, "/login");
  }

  @override
  void initState() {
    _carregarItensDrop();
    verificarUsuarioLogado();
    super.initState();
  }

  _carregarItensDrop() {
    _listaItensCategorias = Configuracoes.getCategorias();

    //ESTADOS
    _listaItensEstados = Configuracoes.getEstados();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OLX"),
        elevation: 0,
        actions: [
          PopupMenuButton<String>(
              onSelected: itemEscolhido,
              itemBuilder: (context) {
                return itensMenu.map((String item) {
                  return PopupMenuItem<String>(value: item, child: Text(item));
                }).toList();
              })
        ],
        centerTitle: true,
      ),
      body: Container(
          child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: Center(
                    child: DropdownButton(
                      iconEnabledColor: Color(0xff9c27b0),
                      value: itemSelecionadoEstado,
                      items: _listaItensEstados,
                      style: TextStyle(fontSize: 22,color: Colors.black),
                      onChanged: (estados) {
                        setState(() {
                          itemSelecionadoEstado = estados;
                        });
                      },
                    ),
                  ),
                ),
              ),

              Container(color: Colors.grey[200],
              margin: EdgeInsets.only(top: 12),
              width: 2,
              height: 60,),

              Expanded(
                child: DropdownButtonHideUnderline(
                  child: Center(
                    child: DropdownButton(
                      iconEnabledColor: Color(0xff9c27b0),
                      value: itemSelecionadoCategoria,
                      items: _listaItensCategorias,
                      style: TextStyle(fontSize: 22,color: Colors.black),
                      onChanged: (categorias) {
                        setState(() {
                          itemSelecionadoCategoria = categorias;
                        });
                      },
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      )),
    );
  }
}
