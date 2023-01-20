bool isValidEmail(String email) {
  return RegExp(
          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$")
      .hasMatch(email);
}

bool isValidPass(String password) {
  return RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$")
      .hasMatch(password);
}

bool isPassEqual(String password, String cPassword) {
  if (password == cPassword) {
    return true;
  } else {
    return false;
  }
}

bool isTagsValid(String tag) {
  return RegExp(r'^[A-Za-z\s]*$').hasMatch(tag);
}

bool isNumberValid(String number) {
  return RegExp(r'^[0-9\s]*$').hasMatch(number);
}
