import 'package:flutter/material.dart';

abstract final class SizeConfig {
  static bool _isInitialized = false;
  static late final double width, height;

  static void init(BuildContext context) {
    if (!_isInitialized) {
      _isInitialized = true;
      width = MediaQuery.sizeOf(context).width;
      height = MediaQuery.sizeOf(context).height;
    }
  }
}