import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voice_text_translation_app/src/presentation/auth/google_auth/google_auth.dart';
import 'package:voice_text_translation_app/src/presentation/auth/register/register_controller.dart';
import 'package:voice_text_translation_app/src/presentation/auth/register/register_services.dart';
import 'package:voice_text_translation_app/src/presentation/utils/constants/constants.dart';
import 'package:voice_text_translation_app/src/presentation/utils/extention/extention.dart';
import 'package:voice_text_translation_app/src/presentation/utils/routes/routes_name.dart';
import 'package:voice_text_translation_app/src/presentation/widgets/register_form.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final RegisterController _controller = RegisterController();

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
        title: Text('Create an Account',
            style: MyTextStyles.kAppBarStyle(context)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: kTextColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: 10.0.padding,
        child: ChangeNotifierProvider(
            create: (_) => RegisterServices(),
            child:
                Consumer<RegisterServices>(builder: (context, provider, child) {
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
                  RegisterForm(controller: _controller, formKey: _formKey),
                  30.ph,
                  provider.loading
                      ? const CircularProgressIndicator()
                      : InkWell(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState?.save();
                              provider.registerScreen(
                                  context,
                                  _controller.userNameController.text,
                                  _controller.mobileNumberController.text,
                                  _controller.addressController.text,
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
                              color: kDeepPurpleColor,
                            ),
                            child: Center(
                              child: Text(
                                'Sign Up',
                                textAlign: TextAlign.center,
                                style: MyTextStyles.kIntroTextStyle(context),
                              ),
                            ),
                          ),
                        ),
                  20.ph,
                  Text(
                    'Or SignUp with Social Platforms',
                    style: MyTextStyles.kBodyText(context),
                  ),
                  8.ph,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Container(
                          width: context.mediaQueryWidth * 0.2,
                          height: context.mediaQueryHeight * 0.1,
                          decoration: const BoxDecoration(
                            color: kBackgroundColor,
                            shape: BoxShape.circle,
                          ),
                          child: const Image(
                              image: AssetImage('assets/images/facebook.png')),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          signInWithGoogle(context);
                        },
                        child: Container(
                          width: context.mediaQueryWidth * 0.2,
                          height: context.mediaQueryHeight * 0.1,
                          decoration: const BoxDecoration(
                            color: kBackgroundColor,
                            shape: BoxShape.circle,
                          ),
                          child: const Image(
                              image: AssetImage('assets/images/google.png')),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.0486,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Already have an account?',
                          style: MyTextStyles.kTextStyle(context),
                        ),
                        20.pw,
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, Routename.loginScreen);
                          },
                          child: Text('Login',
                              style: TextStyle(
                                  fontFamily: 'Cinzel',
                                  color: kDeepPurpleColor,
                                  fontSize: context.responsiveTextSize * 0.6,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                ],
              ));
            })),
      ),
    );
  }
}
