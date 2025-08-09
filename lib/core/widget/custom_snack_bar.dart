import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:saas_mosque/core/style/font_style.dart';
import 'package:saas_mosque/core/utils/size_config.dart';
import 'package:saas_mosque/core/widget/responsive_text.dart';

enum SnackBarType { error, success, other }

class CustomSnackBar extends StatelessWidget {
  final String message;
  final TextStyle? messageStyle;
  const CustomSnackBar({super.key, required this.message, this.messageStyle});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
      child: ResponsiveText(
        message,
        fontSize: FontTextSize.bodyFontSize,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  static void show(
    BuildContext context,
    String message, {
    SnackBarType type = SnackBarType.other,
    TextStyle? messageStyle,
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: _backgroundColor(context, type).withAlpha(5),
          duration: _duration(type),
          content: CustomSnackBar(message: message, messageStyle: messageStyle),
          behavior: SnackBarBehavior.floating,
          dismissDirection: DismissDirection.horizontal,
          shape: OutlineInputBorder(
            borderSide: BorderSide(
              color: _backgroundColor(context, type).withAlpha(7),
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.zero,
              topRight: Radius.circular(12),
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          margin: EdgeInsets.only(
            bottom: SizeConfig.height - 120,
            left: 16,
            right: 16,
          ),
        ),
      );
  }

  static Color _backgroundColor(BuildContext context, SnackBarType type) {
    if (type == SnackBarType.error) return Theme.of(context).colorScheme.error;
    if (type == SnackBarType.success) return Colors.green;
    return Colors.white;
  }

  static Duration _duration(SnackBarType type) {
    if (type == SnackBarType.success) return const Duration(seconds: 3);
    return const Duration(seconds: 5);
  }
}
