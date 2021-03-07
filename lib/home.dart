

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool cadastrar = false;

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

              TextField(

                autofocus: true,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                  fontSize: 20
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                  hintText: "E-mail",
                  labelText: "Digite seu e-mail",
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6)
                  )
                ),
              ),
                SizedBox(height: 16,),
                TextField(

                  obscureText: true,
                  style: TextStyle(
                      fontSize: 20
                  ),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "Senha",
                      labelText: "Digite sua senha",
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6)
                      )
                  ),
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
                          });
                        }),
                    Text("Cadastrar"),
                  ]
                ),
                RaisedButton(
                  child: Text(
                    "Entrar",style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                    color: Color(0xff9c27b0),
                    padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    onPressed: (){}
                    )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
