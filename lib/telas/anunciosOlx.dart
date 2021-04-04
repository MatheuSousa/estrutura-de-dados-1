import 'dart:async';
import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projetoestrutura/models/anuncio.dart';
import 'package:projetoestrutura/models/itemAnuncio.dart';
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

  final _controler = StreamController<QuerySnapshot>.broadcast();

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
    _adicionarListenerAnuncios();
    super.initState();
  }

  _carregarItensDrop() {
    _listaItensCategorias = Configuracoes.getCategorias();

    //ESTADOS
    _listaItensEstados = Configuracoes.getEstados();
  }

  //RECUPERA DADOS FIREBASE
  Future<Stream<QuerySnapshot>> _adicionarListenerAnuncios() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    Stream<QuerySnapshot> stream = db.collection("anuncios").snapshots();

    stream.listen((dados) {
      _controler.add(dados);
    });
  }

  //filtrando os anúncios
  Future<Stream<QuerySnapshot>> _filtrarAnuncios() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    Query query = db.collection("anuncios");

    if(itemSelecionadoEstado != null){
        query = query.where("estado", isEqualTo: itemSelecionadoEstado);
    }

    if(itemSelecionadoCategoria != null){
        query = query.where("categoria", isEqualTo: itemSelecionadoCategoria);
    }

    Stream<QuerySnapshot> stream = query.snapshots();

    stream.listen((dados) {
      _controler.add(dados);
    });
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
                      style: TextStyle(fontSize: 22, color: Colors.black),
                      onChanged: (estados) {
                        setState(() {
                          itemSelecionadoEstado = estados;
                          _filtrarAnuncios();
                        });
                      },
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.grey[200],
                margin: EdgeInsets.only(top: 12),
                width: 2,
                height: 60,
              ),
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: Center(
                    child: DropdownButton(
                      iconEnabledColor: Color(0xff9c27b0),
                      value: itemSelecionadoCategoria,
                      items: _listaItensCategorias,
                      style: TextStyle(fontSize: 22, color: Colors.black),
                      onChanged: (categorias) {
                        setState(() {
                          itemSelecionadoCategoria = categorias;
                          _filtrarAnuncios();
                        });
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          StreamBuilder(
              stream: _controler.stream,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Center(
                      child: Column(
                        children: [
                          Text("Carregando anúncios"),
                          CircularProgressIndicator(),
                        ],
                      ),
                    );
                    break;
                  case ConnectionState.active:
                  case ConnectionState.done:
                    if (snapshot.hasError)
                      return Text("Erro ao carregar os dados!");

                    QuerySnapshot querySnapshot = snapshot.data;

                    if (querySnapshot.docs.length == 0) {
                      return Container(
                        padding: EdgeInsets.all(32),
                        child: Text("Nenhum anúncio no momento!"),
                      );
                    }

                    return Expanded(
                      child: ListView.builder(
                          itemCount: querySnapshot.docs.length,
                          itemBuilder: (_, index) {
                            List<DocumentSnapshot> anuncios =
                                querySnapshot.docs.toList();
                            DocumentSnapshot documentSnapshot = anuncios[index];
                            Anuncio anuncio =
                                Anuncio.fromDocumentSnapshot(documentSnapshot);

                            return ItemAnuncio(
                              anuncio: anuncio,
                              onTapItem: () {},
                            );
                          }),
                    );
                }

                return Container();
              })
        ],
      )),
    );
  }
}
