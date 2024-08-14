import 'package:flutter/material.dart';

extension MediaQueryExtension on BuildContext {
  double get mediaQueryHeight => MediaQuery.of(this).size.height;
  double get mediaQueryWidth => MediaQuery.of(this).size.width;

  double get responsiveTextSize => mediaQueryWidth * 0.04;
}

extension SizedBoxExtension on num {
  SizedBox get ph => SizedBox(
        height: toDouble(),
      );
  SizedBox get pw => SizedBox(
        width: toDouble(),
      );
}

extension EdgeInsetsExtension on num {
  EdgeInsetsGeometry get padding => EdgeInsets.all(toDouble());
}
