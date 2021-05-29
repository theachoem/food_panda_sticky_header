import 'package:flutter/material.dart';

class Helper {
  Helper._internal();
  static StrutStyle buildStrutStyle(TextStyle? textStyle) {
    return StrutStyle(
      forceStrutHeight: true,
      fontWeight: textStyle?.fontWeight,
      fontSize: textStyle?.fontSize,
      fontFamily: textStyle?.fontFamily,
      fontStyle: textStyle?.fontStyle,
      fontFamilyFallback: textStyle?.fontFamilyFallback,
      debugLabel: textStyle?.debugLabel,
    );
  }
}
