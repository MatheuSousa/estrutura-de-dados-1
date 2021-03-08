
class Usuario{

  String _email;
  String _senha;
  String _nome;
  String _idUsuario;

  Usuario();

  Map<String,dynamic> toMap(){

    Map<String,dynamic> map = {
      "idUsuario" : this.idUsuario,
      "nome": this.nome,
      "email": this.email
    };

    return map;
  }
  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get senha => _senha;

  String get idUsuario => _idUsuario;

  set idUsuario(String value) {
    _idUsuario = value;
  }

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  set senha(String value) {
    _senha = value;
  }
}