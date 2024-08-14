import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voice_text_translation_app/src/presentation/auth/forget_password/forget_password_controller.dart';
import 'package:voice_text_translation_app/src/presentation/auth/forget_password/forget_password_services.dart';
import 'package:voice_text_translation_app/src/presentation/utils/constants/constants.dart';
import 'package:voice_text_translation_app/src/presentation/utils/extention/extention.dart';
import 'package:voice_text_translation_app/src/presentation/utils/routes/routes_name.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final ForgetPasswordController _controller = ForgetPasswordController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Forget Password?',
                style: MyTextStyles.kAppBarStyle(context)),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: kTextColor),
              onPressed: () => {Navigator.of(context).pop()},
            ),
          ),
          body: Padding(
              padding: 10.0.padding,
              child: ChangeNotifierProvider(
                  create: (_) => ForgetPasswordServices(),
                  child: Consumer<ForgetPasswordServices>(
                      builder: (context, provider, child) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Center(
                            child: Image.asset(
                              'assets/images/2.png',
                              width: context.mediaQueryWidth * 0.25,
                              height: context.mediaQueryHeight * 0.15,
                            ),
                          ),
                          Center(
                              child: Padding(
                            padding: 12.0.padding,
                            child: Text(
                              'Confirm your Email and \n we will send you the link on email',
                              style: TextStyle(
                                letterSpacing: 2,
                                fontFamily: 'Gaegu',
                                fontSize: context.responsiveTextSize * 0.8,
                                color: kLightDeepColor,
                              ),
                            ),
                          )),
                          30.ph,
                          // Email TextFormfield
                          Padding(
                            padding: EdgeInsets.only(
                              right: context.mediaQueryWidth * 0.0238,
                              left: context.mediaQueryHeight * 0.0238,
                            ),
                            child: TextFormField(
                              validator: (email) {
                                if (email!.isEmpty) {
                                  return "Please Enter your email";
                                } else if (!_controller.emailValidatorRegExp
                                    .hasMatch(email)) {
                                  return "Please Enter Valid Email";
                                }
                                return null;
                              },
                              controller: _controller.emailController,
                              focusNode: _controller.emailFocusNode,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: context.mediaQueryHeight * 0.0139,
                                  horizontal: context.mediaQueryWidth * 0.0139,
                                ),
                                fillColor: kBackgroundColor,
                                hintText: 'Enter Email...',
                                labelText: 'Email',
                                suffixIcon: const Icon(Icons.mail_outline,
                                    color: kTextColor),
                              ),
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                          25.ph,
                          provider.loading
                              ? const CircularProgressIndicator()
                              : InkWell(
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      provider.forgotPassword(
                                        context,
                                        _controller.emailController.text,
                                      );
                                      _formKey.currentState?.save();
                                      if (!provider.loading) {
                                        Navigator.pushReplacementNamed(context,
                                            Routename.voiceTranslation);
                                      }
                                    }
                                  },
                                  child: Container(
                                      width: context.mediaQueryWidth * 0.65,
                                      height: context.mediaQueryHeight * 0.1,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          color: kDeepPurpleColor),
                                      child: Center(
                                        child: Text(
                                          'Reset Password',
                                          textAlign: TextAlign.center,
                                          style: MyTextStyles.kIntroTextStyle(
                                              context),
                                        ),
                                      )),
                                ),
                          20.ph,
                          Padding(
                            padding: EdgeInsets.only(
                                left: context.mediaQueryWidth * 0.0486),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Don\'t have an account yet?',
                                    style: MyTextStyles.kBodyText(context),
                                  ),
                                  20.pw,
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, Routename.registerScreen);
                                    },
                                    child: Text('SignUp',
                                        style: TextStyle(
                                            fontFamily: 'Cinzel',
                                            color: kDeepPurpleColor,
                                            fontSize:
                                                context.responsiveTextSize *
                                                    0.6,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ]),
                          )
                        ],
                      ),
                    );
                  })))),
    );
  }
}
