import 'package:flutter/material.dart';

class ForgetPasswordController {
  TextEditingController emailController = TextEditingController();

  final FocusNode emailFocusNode = FocusNode();

  final RegExp emailValidatorRegExp =
      RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  void dispose() {
    emailController.dispose();

    emailFocusNode.dispose();
  }
}
