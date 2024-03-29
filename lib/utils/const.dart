import 'package:flutter/material.dart';

import '../models/message_model.dart';
import '../pages/auth/forget_password_page.dart';
import '../pages/auth/log_in_page.dart';
import '../pages/auth/sign_up_page.dart';
import '../pages/home_page.dart';

const Color kPrimaryColor = Color(0xff2B475E);
const Color kSenderColor = Colors.white70;
const BorderRadius borderRadius = BorderRadius.all(
  Radius.circular(20),
);
List<MessageModel> chats = [];

const String kLogInPage = 'LogIn';
const String kSignUpPage = 'SignUp';
const String kHomePage = 'Home';
const String kForgetPasswordPage = 'ForgetPassword';
const kChatPage = 'Chat';

Map<String, Widget Function(BuildContext)> routes = {
  kLogInPage: (context) => const LogInPage(),
  kSignUpPage: (context) => const SignUpPage(),
  kHomePage: (context) => const HomePage(),
  kForgetPasswordPage: (context) => const ForgetPasswordPage(),
};
const String emailPattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
    r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
    r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
    r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
    r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
    r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
    r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
final RegExp regexEmail = RegExp(emailPattern);
bool passwordVisible = true;
String? userId;
BorderRadius borderRadiusAll(double radius) {
  const borderRadius = BorderRadius.all(
    Radius.circular(100),
  );
  return borderRadius;
}
