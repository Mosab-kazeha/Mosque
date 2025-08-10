enum FontTextSize {
  headingFontSize,
  titleFontSize,
  bodyFontSize,
  smallFontSize,
}

abstract final class AppFontStyle {
  static const String fontFamily = 'Almarai';

  static double selectTextSize(FontTextSize size) {
    if (size == FontTextSize.headingFontSize) {
      return 24;
    } else if (size == FontTextSize.titleFontSize) {
      return 20;
    } else if (size == FontTextSize.bodyFontSize) {
      return 16;
    }
    return 12;
  }
}
