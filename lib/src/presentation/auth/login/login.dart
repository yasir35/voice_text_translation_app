import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voice_text_translation_app/src/presentation/auth/login/login_controller.dart';
import 'package:voice_text_translation_app/src/presentation/auth/login/login_services.dart';
import 'package:voice_text_translation_app/src/presentation/utils/constants/constants.dart';
import 'package:voice_text_translation_app/src/presentation/utils/extention/extention.dart';
import 'package:voice_text_translation_app/src/presentation/utils/routes/routes_name.dart';
import 'package:voice_text_translation_app/src/presentation/widgets/login_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController _controller = LoginController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome and Login',
            style: MyTextStyles.kAppBarStyle(context)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: kTextColor),
          onPressed: () => {Navigator.pop(context)},
        ),
      ),
      body: Padding(
          padding: 10.0.padding,
          child: ChangeNotifierProvider(
              create: (_) => LoginServices(),
              child:
                  Consumer<LoginServices>(builder: (context, provider, child) {
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
                      LoginForm(controller: _controller, formKey: _formKey),
                      15.ph,
                      Padding(
                        padding: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * 0.0417),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Routename.forgetPassword);
                            },
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                  color: kLightDeepColor,
                                  fontFamily: 'Gaegu',
                                  fontSize: context.responsiveTextSize * 0.8,
                                  letterSpacing: 1.5,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      25.ph,
                      provider.loading
                          ? const CircularProgressIndicator() 
                          : InkWell(
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState?.save();
                                  provider.login(
                                    context,
                                    _controller.userNameController.text,
                                    _controller.emailController.text,
                                    _controller.passwordController.text,
                                  );
                                  if (!provider.loading) {
                                    Navigator.pushReplacementNamed(
                                        context, Routename.voiceTranslation);
                                  }
                                }
                              },
                              child: Container(
                                  width: context.mediaQueryWidth * 0.8,
                                  height: context.mediaQueryHeight * 0.1,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50.0),
                                      color: kDeepPurpleColor),
                                  child: Center(
                                    child: Text('Login',
                                        textAlign: TextAlign.center,
                                        style: MyTextStyles.kIntroTextStyle(context)),
                                  )),
                            ),
                      20.ph,
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.0486),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Don\'t have an account yet?',
                                style: TextStyle(
                                  fontFamily: 'Gaegu',
                                  letterSpacing: 1.5,
                                  fontSize: context.responsiveTextSize * 0.6,
                                ),
                              ),
                              20.pw,
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, Routename.registerScreen);
                                },
                                child: Text('SignUp',
                                    style: TextStyle(
                                        fontSize:
                                            context.responsiveTextSize * 0.6,
                                        fontFamily: 'Cinzel',
                                        color: kDeepPurpleColor,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ]),
                      )
                    ],
                  ),
                );
              }))),
    );
  }
}
