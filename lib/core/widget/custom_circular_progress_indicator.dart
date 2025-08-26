import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../style/app_palette.dart';

// ignore: must_be_immutable
class CustomCircularProgressIndicator extends StatelessWidget {
  Color? color;
  CustomCircularProgressIndicator({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return SpinKitRipple(
      color: color ?? AppPalette.backgroundColor,
      size: 150,
      borderWidth: 10,
    );
  }
}
