import 'package:flutter/material.dart';
import 'package:voice_text_translation_app/src/presentation/auth/register/register_controller.dart';
import 'package:voice_text_translation_app/src/presentation/utils/constants/constants.dart';
import 'package:voice_text_translation_app/src/presentation/utils/constants/focus_node.dart';

class RegisterForm extends StatefulWidget {
  final RegisterController controller;
  final GlobalKey<FormState> formKey;
  const RegisterForm(
      {Key? key, required this.controller, required this.formKey})
      : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          // Username TextFormfield
          Padding(
            padding: const EdgeInsets.only(top: 8, right: 17, left: 17),
            child: TextFormField(
              validator: (username) {
                if (username!.isEmpty) {
                  return "Please enter your Username";
                } else if (username.length < 8) {
                  return "Username must be at least 8 characters";
                }
                return null;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 10.0),
                fillColor: kBackgroundColor,
                hintText: 'Enter Username...',
                labelText: 'Username',
                suffixIcon:
                    const Icon(Icons.person_outlined, color: kTextColor),
              ),
              keyboardType: TextInputType.text,
            ),
          ),

          // Mobile Number TextFormfield
          Padding(
            padding: const EdgeInsets.only(top: 8, right: 17, left: 17),
            child: TextFormField(
              validator: (mobileNumber) {
                if (mobileNumber!.isEmpty) {
                  return "Please enter your Mobile Number";
                } else if (!RegExp(r'^[0-9]{11}$').hasMatch(mobileNumber)) {
                  return "Please enter a valid 10-digit Mobile Number";
                }
                return null;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 10.0),
                fillColor: kBackgroundColor,
                hintText: 'Enter Mobile Number...',
                labelText: 'Mobile Number',
                suffixIcon:
                    const Icon(Icons.phone_android_outlined, color: kTextColor),
              ),
              keyboardType: TextInputType.phone,
            ),
          ),

          // Address TextFormfield
          Padding(
            padding: const EdgeInsets.only(top: 8, right: 17, left: 17),
            child: TextFormField(
              validator: (address) {
                if (address!.isEmpty) {
                  return "Please enter your Address";
                } else if (address.length < 10) {
                  return "Address must be at least 10 characters";
                }
                return null;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 10.0),
                fillColor: kBackgroundColor,
                hintText: 'Enter Address...',
                labelText: 'Address',
                suffixIcon:
                    const Icon(Icons.location_on_outlined, color: kTextColor),
              ),
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
          ),

          // Email TextFormfield
          Padding(
            padding: const EdgeInsets.only(top: 8, right: 17, left: 17),
            child: TextFormField(
              validator: (email) {
                if (email!.isEmpty) {
                  return "Please Enter your email";
                } else if (!widget.controller.emailValidatorRegExp
                    .hasMatch(email)) {
                  return "Please Enter Valid Email";
                }
                return null;
              },
              controller: widget.controller.emailController,
              focusNode: widget.controller.emailFocusNode,
              onFieldSubmitted: (value) {
                Utils.fieldFocus(context, widget.controller.emailFocusNode,
                    widget.controller.passwordFocusNode);
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 10.0),
                fillColor: kBackgroundColor,
                hintText: 'Enter Email...',
                labelText: 'Email',
                suffixIcon: const Icon(Icons.mail_outline, color: kTextColor),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
          ),

          // Password TextFormfield
          Padding(
            padding: const EdgeInsets.only(top: 8, right: 17, left: 17),
            child: TextFormField(
              validator: (password) {
                if (password!.isEmpty) {
                  return "Please Enter your password";
                } else if (password.isNotEmpty && password.length <= 7) {
                  return "Password is too short, at least 8 chars";
                }
                return null;
              },
              controller: widget.controller.passwordController,
              focusNode: widget.controller.passwordFocusNode,
              obscureText: _obscureText,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 10.0),
                fillColor: kBackgroundColor,
                hintText: 'Enter Password...',
                labelText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    color: kTextColor,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
              ),
              keyboardType: TextInputType.text,
            ),
          ),
        ],
      ),
    );
  }
}
