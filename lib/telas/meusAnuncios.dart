import 'package:flutter/material.dart';
import 'package:projetoestrutura/models/itemAnuncio.dart';

class MeusAnuncios extends StatefulWidget {
  @override
  _MeusAnunciosState createState() => _MeusAnunciosState();
}

class _MeusAnunciosState extends State<MeusAnuncios> {
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
        body: SingleChildScrollView(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 4,
            itemBuilder: (_, index) {
              return ItemAnuncio();
            },
          ),
        ));
  }
}
