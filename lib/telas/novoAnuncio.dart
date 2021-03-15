import 'package:brasil_fields/modelos/estados.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projetoestrutura/models/raisedCustomizado.dart';
import 'dart:io';

import 'package:validadores/Validador.dart';

class NovoAnuncio extends StatefulWidget {
  @override
  _NovoAnuncioState createState() => _NovoAnuncioState();
}

class _NovoAnuncioState extends State<NovoAnuncio> {
  List<File> _listaImagens = List();
  List<DropdownMenuItem<String>> _listaItensEstados = List();
  List<DropdownMenuItem<String>> _listaItensCategorias = List();

  final _formKey = GlobalKey<FormState>();

  String _itemSelecionadoEstado ;
  String _itemSelecionadoCategoria;

  //final picker = ImagePicker();
  File imagemSelecionada;

  _selecionaGaleria() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);

    if (pickedFile == null) return;

    imagemSelecionada = File(pickedFile.path);

    if (imagemSelecionada != null) {
      setState(() {
        _listaImagens.add(imagemSelecionada);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _carregarItensDrop();
  }

  _carregarItensDrop() {

     _listaItensCategorias.add(
      DropdownMenuItem(
        child: Text("Automóvel"), value : "auto"));

      _listaItensCategorias.add(
        DropdownMenuItem(
          child: Text("Imóvel"), value : "imovel"));
    _listaItensCategorias.add(
        DropdownMenuItem(
          child: Text("Carros"), value : "carros"));
    _listaItensCategorias.add(
        DropdownMenuItem(
          child: Text("Jardinagem"), value : "jardinagem"));

      _listaItensCategorias.add(
      DropdownMenuItem(
        child: Text("Ferramentas"), value : "ferramentas"));

    //ESTADOS
    for (var estado in Estados.listaEstadosAbrv) {
      _listaItensEstados.add(DropdownMenuItem(
        child: Text(estado),
        value: estado,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Novo Anúncio"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    FormField<List>(
                      initialValue: _listaImagens,
                      validator: (imagens) {
                        if (imagens.length == 0) {
                          return "Necessário ter no mínimo uma imagem";
                        }

                        return null;
                      },
                      builder: (state) {
                        return Column(
                          children: [
                            Container(
                              height: 100,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: _listaImagens.length + 1,
                                  itemBuilder: (context, index) {
                                    if (index == _listaImagens.length) {
                                      return Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 8),
                                        child: GestureDetector(
                                          onTap: () {
                                            _selecionaGaleria();
                                          },
                                          child: CircleAvatar(
                                            backgroundColor: Colors.grey[400],
                                            radius: 50,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.add_a_photo,
                                                  size: 40,
                                                  color: Colors.grey[100],
                                                ),
                                                Text(
                                                  'Adicionar',
                                                  style: TextStyle(
                                                    color: Colors.grey[100],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }

                                    if (_listaImagens.length > 0) {
                                      return Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 8),
                                        child: GestureDetector(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) => Dialog(
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Image.file(
                                                              _listaImagens[
                                                                  index]),
                                                          FlatButton(
                                                            child:
                                                                Text("Excluir"),
                                                            textColor:
                                                                Colors.red,
                                                            onPressed: () {
                                                              setState(() {
                                                                _listaImagens
                                                                    .removeAt(
                                                                        index);
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              });
                                                            },
                                                          )
                                                        ],
                                                      ),
                                                    ));
                                          },
                                          child: CircleAvatar(
                                            radius: 50,
                                            backgroundImage:
                                                FileImage(_listaImagens[index]),
                                            child: Container(
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 0.4),
                                              alignment: Alignment.center,
                                              child: Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }

                                    return Container();
                                  }),
                            ),
                            if (state.hasError)
                              Container(
                                child: Text(
                                  "${state.errorText}",
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 14),
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: DropdownButtonFormField(
                                value: _itemSelecionadoEstado,
                                hint: Text("Estados"),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                                items: _listaItensEstados,
                                validator: (valor) {
                                  return Validador()
                                      .add(Validar.OBRIGATORIO,
                                          msg: "Campo Obrigatório!")
                                      .valido(valor);
                                },
                                onChanged: (valor) {
                                  _itemSelecionadoEstado = valor;
                                }),
                          ),
                        ),
                          Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: DropdownButtonFormField(
                                value: _itemSelecionadoCategoria,
                                hint: Text("Categoria"),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                                items: _listaItensCategorias,
                                validator: (valor) {
                                  return Validador()
                                      .add(Validar.OBRIGATORIO,
                                          msg: "Campo Obrigatório!")
                                      .valido(valor);
                                },
                                onChanged: (valor) {
                                  _itemSelecionadoCategoria = valor;
                                }),
                          ),
                        ),
                      ],
                    ),
                    Text("Caixas de texto"),
                    RaisedCustomizado(
                      texto: "Cadastrar anúncio",
                      onPressed: () {
                        if (_formKey.currentState.validate()) {}
                      },
                    )
                  ],
                )),
          ),
        ));
  }
}
