import 'package:flutter/material.dart';
import 'package:voice_text_translation_app/src/presentation/Splash/splash_screen.dart';
import 'package:voice_text_translation_app/src/presentation/auth/forget_password/forget_password.dart';
import 'package:voice_text_translation_app/src/presentation/auth/login/login.dart';
import 'package:voice_text_translation_app/src/presentation/auth/register/register_screen.dart';
import 'package:voice_text_translation_app/src/presentation/screens/text_translation.dart';
import 'package:voice_text_translation_app/src/presentation/screens/voice_translation.dart';
import 'package:voice_text_translation_app/src/presentation/utils/routes/routes_name.dart';

class Routes {
  static MaterialPageRoute generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routename.splashScreen:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case Routename.loginScreen:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case Routename.registerScreen:
        return MaterialPageRoute(builder: (context) => const RegisterScreen());
      case Routename.forgetPassword:
        return MaterialPageRoute(builder: (context) => const ForgetPassword());
      case Routename.voiceTranslation:
        return MaterialPageRoute(
            builder: (context) => const VoiceTranslation());
      case Routename.textTranslation:
        return MaterialPageRoute(
            builder: (context) => const TextTranslation());
      default:
        return MaterialPageRoute(
          builder: (context) {
            return const Scaffold(
              body: Center(child: Text('No route defined')),
            );
          },
        );
    }
  }
}
