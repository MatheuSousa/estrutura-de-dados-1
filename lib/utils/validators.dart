String validatorName(String text) {
  if (text.isEmpty) {
    return "Por favor informe seu nome";
  } else {
    return null;
  }
}

String validatorEmail(String email) {
  if (!(RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email))) {
    return "Por favor informe um e-mail válido";
  } else {
    return null;
  }
}

String validatorBirthdate(DateTime dateTime) {
  if (dateTime == null) {
    return "Por favor informe sua data de nascimento";
  } else {
    return null;
  }
}

String validatorGender(String gender) {
  if (gender == null) {
    return "Por favor selecione seu gênero";
  } else {
    return null;
  }
}

String validatorPassword(String password) {
  if (!isPasswordCompliant(password)) {
    return "A senha deve ter 8 caracteres e no mínimo uma letra e número.";
  } else {
    return null;
  }
}

String validatorPasswordConfirm(String password, String confirmPassword) {
  if (!isPasswordCompliant(password)) {
    return "A senha deve ter 8 caracteres e no mínimo uma letra e número.";
  } else if (password != confirmPassword) {
    return "As senhas não coincidem";
  } else {
    return null;
  }
}

bool isPasswordCompliant(String password, [int minLength = 8]) {
  if (password == null || password.isEmpty) {
    return false;
  }

  bool hasUppercase = password.contains(new RegExp(r'[A-Z]'));
  bool hasDigits = password.contains(new RegExp(r'[0-9]'));
  bool hasLowercase = password.contains(new RegExp(r'[a-z]'));
  bool hasMinLength = password.length > minLength;

  return hasDigits & (hasUppercase || hasLowercase) & hasMinLength;
}

String validatorCourse(String text) {
  if (text.isEmpty) {
    return "Por favor selecione um curso";
  } else {
    return null;
  }
}