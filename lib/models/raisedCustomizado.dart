import 'package:flutter/material.dart';

class RaisedCustomizado extends StatelessWidget {
  final String texto;
  final Color corTexto;
  final VoidCallback onPressed;

  RaisedCustomizado(
      {@required this.texto, this.corTexto = Colors.white, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
        child: Text(
          this.texto,
          style: TextStyle(fontSize: 18, color: this.corTexto),
        ),
        color: Color(0xff9c27b0),
        padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
        onPressed: this.onPressed);
  }
}
