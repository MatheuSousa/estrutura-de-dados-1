import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Anuncios extends StatefulWidget {
  @override
  _AnunciosState createState() => _AnunciosState();
}

class _AnunciosState extends State<Anuncios> {

  List<String> itensMenu = [];

  itemEscolhido(String itemEscolhido){

    switch(itemEscolhido){

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

  Future verificarUsuarioLogado() async{

    FirebaseAuth auth = FirebaseAuth.instance;

    User usuarioLogado =  auth.currentUser; //RECUPERAR O USUARIO LOGADO

    usuarioLogado == null ?
      itensMenu = ["Entrar / Cadastrar"]
    :
    itensMenu = [
        "Meus anúncios", "Deslogar"
      ];

  }
  deslogarUsuario()async{
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    Navigator.pushNamed(context, "/login");
  }
  @override
  void initState() {
   verificarUsuarioLogado();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OLX"),
        elevation: 0,
        actions: [
          PopupMenuButton<String>(
            onSelected: itemEscolhido ,
              itemBuilder: (context){
                return itensMenu.map((String item)  {
                    return PopupMenuItem<String>(
                      value: item,
                        child: Text(item));

                }).toList();
              })
        ],
        centerTitle: true,
      ),
      body: Container(
        child: Text('Anúncios')
      ),
    );
  }
}
