import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:voice_text_translation_app/src/presentation/utils/constants/constants.dart';
import 'package:voice_text_translation_app/src/presentation/utils/extention/extention.dart';
import 'package:voice_text_translation_app/src/presentation/utils/routes/routes_name.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoading = true;
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        isLoading = false;
        Navigator.pushReplacementNamed(context, Routename.registerScreen);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [kDeepPurpleColor, kLightDeepColor],
      )),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Voice and Text Translation',
              style: MyTextStyles.kAppBarStyle(context)),
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/1.png',
                width: context.mediaQueryWidth * 0.4,
                height: context.mediaQueryHeight * 0.3,
              ),
              40.ph,
              const SpinKitFadingCircle(
                color: kDeepPurpleColor,
                size: 50.0,
              ),
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
