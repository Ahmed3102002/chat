
import '../../utils/const.dart';

String? nameValidator(String? name) {
  if (name!.isEmpty) {
    return 'this field is required';
  }
  if (name.length<3) {
    return 'your name is to less';
  }
  return null;
}String? emailValidator(String? email) {
  if (email!.isEmpty) {
    return 'this field is required';
  }
  if (!regexEmail.hasMatch(email)) {
    return 'your email is not valid';
  }
  return null;
}

String? passwordValidator(String? password) {
  if (password!.isEmpty) {
    return 'this field is required';
  }
  if (password.length<8) {
    return 'your password is week';
  }
  return null;
}