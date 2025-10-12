enum FontTextSize {
  bigFontSize,
  headingFontSize,
  titleFontSize,
  subTitleFontSize,
  bodyFontSize,
  labelFontSize,
  smallFontSize,
  defaultFontSize,
}

abstract final class AppFontStyle {
  static const String fontFamily = 'Almarai';

  static double selectTextSize(FontTextSize? size) {
    if (size == FontTextSize.bigFontSize) {
      return 48;
    } else if (size == FontTextSize.headingFontSize) {
      return 24;
    } else if (size == FontTextSize.titleFontSize) {
      return 20;
    } else if (size == FontTextSize.subTitleFontSize) {
      return 18;
    } else if (size == FontTextSize.bodyFontSize) {
      return 16;
    } else if (size == FontTextSize.labelFontSize) {
      return 14;
    }
    return 12;
  }
}
