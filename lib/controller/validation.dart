validate(value, type) {
  if (value!.isEmpty) {
    return 'أدخل $type';
  } else if (type == 'البريد الإلكتروني' && !validateEmail(value)) {
    return ' أدخل البريد الإلكتروني بشكل صحيح';
  } else if (type == 'كلمة المرور' && !validatePass(value)) {
    return ' أدخل كلمة المرور بشكل صحيح';
  }
}

validatePass(pass) {
  Pattern pattern = r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$";
  RegExp correctPass = RegExp(pattern.toString());

  if (correctPass.hasMatch(pass)) {
    return true;
  } else {
    return false;
  }
}

validateEmail(email) {
  Pattern pattern =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+";
  RegExp correctEmail = RegExp(pattern.toString());

  if (correctEmail.hasMatch(email)) {
    return true;
  } else {
    return false;
  }
}
