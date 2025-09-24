import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:saas_mosque/core/style/font_style.dart';
import 'package:saas_mosque/core/utils/size_config.dart';
import 'package:saas_mosque/core/widget/responsive_text.dart';

enum SnackBarType { error, success, other }

class CustomSnackBar extends StatelessWidget {
  final String message;
  final TextStyle? messageStyle;
  final bool atTop;
  const CustomSnackBar({
    super.key,
    required this.message,
    this.messageStyle,
    this.atTop = false,
  });

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
      child: ResponsiveText(
        message,
        fontSize: FontTextSize.bodyFontSize,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
      ),
    );
  }

  static void show(
    BuildContext context,
    String message, {
    SnackBarType type = SnackBarType.other,
    bool atTop = false,
    TextStyle? messageStyle,
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: _backgroundColor(context, type).withAlpha(1),
          duration: _duration(type),
          content: CustomSnackBar(
            message: message,
            messageStyle: messageStyle,
            atTop: atTop,
          ),
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
            left: 10,
            right: 10,
            bottom: atTop ? SizeConfig.height - 100 : 10,
          ),
        ),
      );
  }

  static Color _backgroundColor(BuildContext context, SnackBarType type) {
    // if (type == SnackBarType.error) return Theme.of(context).colorScheme.error;
    if (type == SnackBarType.error) return Colors.red;
    if (type == SnackBarType.success) return Colors.green;
    return Colors.white;
  }

  static Duration _duration(SnackBarType type) {
    if (type == SnackBarType.success) return const Duration(seconds: 3);
    return const Duration(seconds: 10);
  }
}
