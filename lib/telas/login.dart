import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projetoestrutura/models/textFieldCostumizado.dart';
import 'package:projetoestrutura/models/usuario.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController _controlladorSenha  = TextEditingController();
  TextEditingController _controlladorEmail = TextEditingController();
  bool cadastrar = false;
  String msgErro = '';
  String textoRaised = "Entrar";

  cadastrarUser(Usuario usuario){

    FirebaseAuth auth = FirebaseAuth.instance;

    auth.createUserWithEmailAndPassword(
        email: usuario.email,
        password: usuario.senha).then((firebaseUser) {

          Navigator.pushReplacementNamed(context, "/");

    });
  }

  logarUser(Usuario usuario){
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.signInWithEmailAndPassword(
        email: usuario.email,
        password: usuario.senha).then((firebaseUser) {
           Navigator.pushReplacementNamed(context, "/");
    });
  }
  validadorCampos(){

    String email = _controlladorEmail.text;
    String senha = _controlladorSenha.text;

    if(email.isNotEmpty && email.contains("@") && email.length > 10){
      if(senha.isNotEmpty && senha.length > 5){

        Usuario usuario = Usuario();
        usuario.email = email;
        usuario.senha  = senha;


        if(cadastrar  == true){

          cadastrarUser(usuario);
          //cadastrar o usuário
        }
        else{
          //logar
         logarUser(usuario);
        }
      }
      else{
        setState(() {

          msgErro = "Digite uma senha com mais de 5 caracteres";
        });
      }
    }

    else{
      setState(() {
        msgErro = "Digite um e-mail válido";
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        backgroundColor: Color(0xff9c27b0),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 32),
                    child: Image.asset("imagens/logo.png",
                    width: 200,
                      height: 150,
                    ),
                  ),

                TextFieldCustomizado(
                  controller: _controlladorEmail,
                  hint: "E-mail",
                  label: "Digite seu e- mail ",
                  obscure: false,
                ),
                SizedBox(height: 16,),
                TextFieldCustomizado(
                  controller: _controlladorSenha,
                  hint: "Senha",
                  obscure: true,
                  label: "Digite sua senha",
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Logar'),

                    Switch(

                        value: cadastrar ,
                        onChanged: (bool valor){
                          setState(() {
                              cadastrar = valor;
                              cadastrar == false ?
                              textoRaised = "Entrar" : textoRaised = "Cadastrar";
                          });
                        }),
                    Text("Cadastrar"),
                  ]
                ),
                RaisedButton(
                  child: Text(
                    textoRaised,style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                    color: Color(0xff9c27b0),
                    padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    onPressed: (){
                      validadorCampos();
                    }
                    ),

               SizedBox(height: 20,),
                Text(msgErro.toString(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
