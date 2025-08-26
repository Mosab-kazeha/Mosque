// ignore: must_be_immutable
import 'package:flutter/material.dart';
import '../style/app_palette.dart';
import '../style/font_style.dart';
import '../utils/size_config.dart';
import 'responsive_text.dart';
import 'spaces.dart';

// ignore: must_be_immutable
class FailureScreen extends StatelessWidget {
  final IconData? icon;
  final String? title;
  final String? subtitle;
  final String? buttonText;
  void Function() onPressed;
  FailureScreen({
    super.key,
    this.icon,
    this.title,
    this.subtitle,
    this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Failure Icon
              Icon(
                icon ?? Icons.wifi_off_rounded,
                color: AppPalette.black,
                size: 80,
              ),
              VerticalSpace(SizeConfig.height * 0.08),
              // Title
              ResponsiveText(
                title ?? 'No Internet Connection',
                fontSize: FontTextSize.headingFontSize,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
              ),
              VerticalSpace(SizeConfig.height * 0.02),

              // Subtitle
              ResponsiveText(
                subtitle ?? 'Please check your network settings and try again.',
                fontSize: FontTextSize.smallFontSize,
                textAlign: TextAlign.center,
                color: AppPalette.grey,
              ),
              VerticalSpace(SizeConfig.height * 0.03),

              // Retry Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppPalette.backgroundColor,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: onPressed,
                  child: ResponsiveText(
                    buttonText ?? 'Retry Connection',
                    fontSize: FontTextSize.smallFontSize,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                    color: AppPalette.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
