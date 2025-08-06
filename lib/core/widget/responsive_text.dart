import 'package:flutter/material.dart';

import '../utils/size_config.dart';

enum FontTextSize { headingFontSize, bodyFontSize, smallFontSize }

class ResponsiveText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final FontTextSize? fontSize;
  final FontWeight? fontWeight;
  final int? maxLines;
  final TextOverflow? overflow;
  final Color? color;
  final String fontFamily = 'Almarai';
  const ResponsiveText(
    this.text, {
    super.key,
    this.fontSize,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.fontWeight,
    this.color, this.textDirection,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      textDirection: textDirection,
      // style: style?.copyWith(
      //   fontFamily: fontFamily,
      //   fontSize:
      //       style?.fontSize != null
      //           ? getResponsiveFontSize(style!.fontSize!)
      //           : null,
      // ),
      style: TextStyle(
        fontFamily: fontFamily,
        fontSize: getResponsiveFontSize(_selactTextSize(fontSize!)),
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }

  static double getResponsiveFontSize(double fontSize) {
    final double scaleFactor = _getScaleFactor();
    final double responsiveFontSize = fontSize * scaleFactor;
    final double lowerLimit = fontSize * 0.8;
    final double upperLimit = fontSize * 1.2;
    return responsiveFontSize.clamp(lowerLimit, upperLimit);
  }

  static double _getScaleFactor() {
    return SizeConfig.width / 400;
  }

  double _selactTextSize(FontTextSize size) {
    if (size == FontTextSize.headingFontSize) {
      return 24;
    } else if (size == FontTextSize.bodyFontSize) {
      return 16;
    }
    return 12;
  }
}
