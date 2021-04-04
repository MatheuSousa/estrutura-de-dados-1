import 'package:brasil_fields/modelos/estados.dart';
import 'package:flutter/material.dart';

class Configuracoes {
 
  static List<DropdownMenuItem<String>> getCategorias() {
    List<DropdownMenuItem<String>> _listaItensCategorias = [];

    _listaItensCategorias
        .add(DropdownMenuItem(child: Text("Categoria",
        style: TextStyle(color: Color(0xff9c27b0)),), value: null));

    _listaItensCategorias
        .add(DropdownMenuItem(child: Text("Automóvel"), value: "auto"));

    _listaItensCategorias
        .add(DropdownMenuItem(child: Text("Imóvel"), value: "imovel"));
    _listaItensCategorias
        .add(DropdownMenuItem(child: Text("Carros"), value: "carros"));
    _listaItensCategorias
        .add(DropdownMenuItem(child: Text("Jardinagem"), value: "jardinagem"));

    _listaItensCategorias.add(
        DropdownMenuItem(child: Text("Ferramentas"), value: "ferramentas"));

    return _listaItensCategorias;
  
  }


  
  static List<DropdownMenuItem<String>> getEstados() {
    List<DropdownMenuItem<String>> _listaItensEstados = [];

    _listaItensEstados
        .add(DropdownMenuItem(child: Text("Região",
        style: TextStyle(color: Color(0xff9c27b0)),), value: null));

    for (var estado in Estados.listaEstadosAbrv) {
      _listaItensEstados.add(DropdownMenuItem(
        child: Text(estado),
        value: estado,
      ));
    }

    return _listaItensEstados;
  
  }
}
