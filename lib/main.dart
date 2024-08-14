import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voice_text_translation_app/src/presentation/Splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:voice_text_translation_app/src/presentation/auth/forget_password/forget_password_services.dart';
import 'package:voice_text_translation_app/src/presentation/auth/login/login_services.dart';
import 'package:voice_text_translation_app/src/presentation/auth/register/register_services.dart';
import 'package:voice_text_translation_app/src/presentation/screens/voice_translation.dart';
import 'package:voice_text_translation_app/src/presentation/utils/constants/constants.dart';
import 'package:voice_text_translation_app/src/presentation/utils/routes/routes.dart';
import 'package:voice_text_translation_app/src/presentation/utils/routes/routes_name.dart';
import 'firebase_options.dart';
import 'src/presentation/screens/text_translation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RegisterServices()),
        ChangeNotifierProvider(create: (_) => LoginServices()),
        ChangeNotifierProvider(create: (_) => ForgetPasswordServices()),
        ChangeNotifierProvider(create: (_) => TranslationState()),
        ChangeNotifierProvider(create: (_) => TextTranslationState()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: kDeepPurpleColor),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
        initialRoute: Routename.splashScreen,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
