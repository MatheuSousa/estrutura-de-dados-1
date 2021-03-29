import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projetoestrutura/models/anuncio.dart';
import 'package:projetoestrutura/models/itemAnuncio.dart';

class MeusAnuncios extends StatefulWidget {
  @override
  _MeusAnunciosState createState() => _MeusAnunciosState();
}

class _MeusAnunciosState extends State<MeusAnuncios> {
  final _controller = StreamController<QuerySnapshot>.broadcast();
  String idUsuarioLogado;

  _recuperaDadosUsuarioLogado() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User usuarioLogado = auth.currentUser;
    idUsuarioLogado = usuarioLogado.uid;
  }

  Future<Stream<QuerySnapshot>> _adicionarListenerAnuncios() async {
    
    await _recuperaDadosUsuarioLogado();
    FirebaseFirestore db = FirebaseFirestore.instance;
    Stream<QuerySnapshot> stream = db
        .collection("meus_anuncios")
        .doc(idUsuarioLogado)
        .collection("anuncios")
        .snapshots();

    stream.listen((dados) {
      _controller.add(dados);
    });
  }

  _removerAnuncio(String idAnuncio){

    FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection("meus_anuncios")
      .doc(idUsuarioLogado)
      .collection("anuncios")
      .doc( idAnuncio )
      .delete();

  }
@override
  void initState() {
    _adicionarListenerAnuncios();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Meus Anúncios"),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          foregroundColor: Colors.white,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, "/novo-anuncio");
          },
        ),
        body: StreamBuilder(
          stream: _controller.stream,
          builder: (context, snapshot) {

        switch(snapshot.connectionState){

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

              if(snapshot.hasError)
                return Text("Erro ao carregar os dados!");
              
              QuerySnapshot querySnapshot = snapshot.data;

              return ListView.builder(
                  itemCount: querySnapshot.docs.length,
                  itemBuilder: (_, indice){
                    
                    List<DocumentSnapshot> anuncios = querySnapshot.docs.toList();
                    DocumentSnapshot documentSnapshot = anuncios[indice];
                    Anuncio anuncio = Anuncio.fromDocumentSnapshot(documentSnapshot);
                    
                    return ItemAnuncio(
                    anuncio: anuncio,
                      onPressedRemover: (){
                        showDialog(
                            context: context,
                          builder: (context){
                              return AlertDialog(
                                title: Text("Confirmar"),
                                content: Text("Deseja realmente excluir o anúncio?"),
                                actions: <Widget>[

                                  FlatButton(
                                    color: Colors.blue,
                                    child: Text(
                                        "Cancelar",
                                      style: TextStyle(
                                          color: Colors.white
                                      ),
                                    ),
                                    onPressed: (){
                                      Navigator.of(context).pop();
                                    },
                                  ),

                                  FlatButton(
                                    color: Colors.red,
                                    child: Text(
                                      "Remover ",
                                      style: TextStyle(
                                          color: Colors.white
                                      ),
                                    ),
                                  
                                    onPressed: (){
                                      _removerAnuncio( anuncio.id );
                                      Navigator.of(context).pop();
                                    },
                                  ),


                                ],
                              );
                          }
                        );
                      },
                    );
                  }
              );
              
          }
          
          return Container();
          
        },
      ),
    );
  }
}
