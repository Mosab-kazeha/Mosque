import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../style/app_palette.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  final Color? color;
  const CustomCircularProgressIndicator({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return SpinKitRipple(
      color: color ?? AppPalette.backgroundColor,
      size: 150,
      borderWidth: 10,
    );
  }
}
