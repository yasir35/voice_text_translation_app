import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:voice_text_translation_app/src/presentation/utils/extention/extention.dart';

const kBackgroundColor = Color(0xFFFDFAEE);
const kActiveIconColor = Color(0xFFE68342);
const kTextColor = Color(0xFF222B45);
const kDeepPurpleColor = Color(0xFF4527A0);
const kLightDeepColor = Color(0xFFB39DDB);
const kShadowColor = Color(0xFFE6E6E6);

class MyTextStyles {
  static TextStyle kAppBarStyle(BuildContext context) => TextStyle(
    color: kTextColor,
    fontSize: context.responsiveTextSize * 1.5, 
    fontWeight: FontWeight.bold,
    fontFamily: 'Honk',
    letterSpacing: 1.5,
  );

  static TextStyle kBodyText(BuildContext context) => TextStyle(
    fontSize: context.responsiveTextSize * 0.8, 
    fontFamily: 'Gaegu',
  );

  static TextStyle kIntroTextStyle(BuildContext context) => TextStyle(
    color: kBackgroundColor,
    fontSize: context.responsiveTextSize * 0.9, 
    fontWeight: FontWeight.bold,
    fontFamily: 'Cinzel',
  );

  static TextStyle kTextStyle(BuildContext context) => TextStyle(
    color: kTextColor,
    fontSize: context.responsiveTextSize * 0.6, 
    fontFamily: 'Gaegu',
  );
}
