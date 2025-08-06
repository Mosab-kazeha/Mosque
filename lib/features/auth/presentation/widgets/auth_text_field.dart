import 'package:flutter/material.dart';
import 'package:saas_mosque/core/style/app_palette.dart';
import 'package:saas_mosque/core/widget/custom_text_field.dart';
import 'package:saas_mosque/core/widget/responsive_text.dart';
import 'package:saas_mosque/core/widget/spaces.dart';

class AuthTextField extends StatelessWidget {
  final String label;
  final TextFieldType type;
  final String hintText;
  final void Function(String)? onChanged;
  const AuthTextField({
    super.key,
    required this.label,
    required this.type,
    required this.hintText, this.onChanged,
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ResponsiveText(
          label,
          fontSize: FontTextSize.bodyFontSize,
          color: AppPalette.white,
          fontWeight: FontWeight.bold,
          textAlign: TextAlign.right,
          textDirection: TextDirection.rtl,
        ),
        const VerticalSpace(8),
        CustomTextField(
          type: type,
          hintText: hintText,
          textAlign: TextAlign.right,
          filled: true,
          fillColor: AppPalette.white,
          activeColor: AppPalette.backgroundColor,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
