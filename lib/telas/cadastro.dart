import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projetoestrutura/utils/validators.dart';
import 'package:projetoestrutura/widgets/app_textFormField.dart';

class Cadastro extends StatefulWidget {
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _tName = TextEditingController();
  TextEditingController _tEmail = TextEditingController();
  TextEditingController _tPassword = TextEditingController();
  TextEditingController _tPasswordConfirm = TextEditingController();
  TextEditingController _tBirthdate = TextEditingController();

  final format = DateFormat("dd-MM-yyyy");

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _appBar(), body: _body());
  }

  _body() {
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.all(16),
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          AppTextFormField(
            "Informe seu nome",
            Icons.person,
            textInputType: TextInputType.text,
            controller: _tName,
            validator: validatorName,
            fillcolor: Colors.white,
          ),
          SizedBox(
            height: 15,
          ),
          AppTextFormField(
            "Informe seu e-mail",
            Icons.mail,
            textInputType: TextInputType.emailAddress,
            controller: _tEmail,
            validator: validatorEmail,
            fillcolor: Colors.white,
          ),
          SizedBox(
            height: 15,
          ),
          _dateTimeField(
            controller: _tBirthdate,
            validator: validatorBirthdate,
          ),
          SizedBox(
            height: 15,
          ),
          AppTextFormField(
            "Crie sua senha",
            Icons.vpn_key,
            textInputType: TextInputType.text,
            password: true,
            controller: _tPassword,
            validator: validatorPassword,
            fillcolor: Colors.white,
          ),
          SizedBox(
            height: 15,
          ),
          AppTextFormField(
            "Confirme sua senha",
            Icons.vpn_key,
            textInputType: TextInputType.text,
            password: true,
            controller: _tPasswordConfirm,
            validator: (value) {
              return validatorPasswordConfirm(value, _tPassword.text);
            },
            fillcolor: Colors.white,
          ),
          SizedBox(
            height: 15,
          ),
          _cadastrarBtn(onPressed: () {}),
        ],
      ),
    );
  }

  Widget _appBar() {
    return AppBar(
      elevation: 0,
      title: Text("Cadastro"),
      centerTitle: true,
      backgroundColor: Color(0xff9c27b0),
    );
  }

  DateTimeField _dateTimeField(
      {TextEditingController controller, Function validator}) {
    return DateTimeField(
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        hintText: "Data de nascimento",
        prefixIcon: Icon(
          Icons.cake,
          color: Color(0xff9c27b0),
        ),
        contentPadding: EdgeInsets.all(2),
        filled: true,
        // fillColor: ,
        hintStyle: TextStyle(
          fontFamily: 'BreeSerif',
          fontSize: 16,
        ),
        //Enabled sem cursor
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5)
        ),
        //Enabled com cursor
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      style: TextStyle(
        fontFamily: 'BreeSerif',
        color: Colors.black,
      ),
      format: format,
      onShowPicker: (context, currentValue) {
        final DateTime now = DateTime.now();
        return showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            initialDate:
                currentValue ?? DateTime(now.year - 2, now.month, now.day),
            lastDate: DateTime(now.year - 2, now.month, now.day));
      },
    );
  }

  _cadastrarBtn({Function onPressed}) {
    return ElevatedButton(
        child: Text(
          "CADASTRAR",
          style: TextStyle(fontSize: 15, color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          primary: Color(0xff9c27b0),
          padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
        ),
        onPressed: () {});
  }
}
