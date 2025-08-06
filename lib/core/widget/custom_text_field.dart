import 'package:flutter/material.dart';

import '../style/app_palette.dart';
import 'responsive_text.dart';

enum TextFieldType { email, password, phone, other }

class CustomTextField extends StatefulWidget {
  final TextFieldType type;
  final bool isRequired;
  final TextInputAction? textInputAction;
  final TextCapitalization? textCapitalization;
  final String? Function(String?)? validator;
  final Color? activeColor;
  final Color? errorColor;
  final String? hintText;
  final TextStyle? hintStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final InputBorder? border;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final bool? filled;
  final Color? fillColor;
  final TextAlign? textAlign;

  const CustomTextField({
    super.key,
    this.type = TextFieldType.other,
    this.isRequired = true,
    this.textInputAction,
    this.textCapitalization,
    this.validator,
    this.activeColor = AppPalette.white,
    this.errorColor,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.border,
    this.onChanged,
    this.onFieldSubmitted,
    this.filled,
    this.fillColor,
    this.hintStyle,
    this.textAlign,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late final FocusNode focusNode;
  late bool isContentVisible;
  late bool isContentValid;

  @override
  void initState() {
    focusNode = FocusNode()..addListener(_focusNodeListener);
    isContentVisible = (widget.type == TextFieldType.password) ? false : true;
    isContentValid = true;
    super.initState();
  }

  @override
  void dispose() {
    focusNode
      ..removeListener(_focusNodeListener)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      textAlign: widget.textAlign ?? TextAlign.start,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onFieldSubmitted,
      textInputAction: widget.textInputAction,
      textCapitalization: widget.textCapitalization ?? TextCapitalization.none,
      obscureText: !isContentVisible,
      onTapOutside: (e) => focusNode.unfocus(),
      keyboardType: _keyboardType(),
      validator: _validator,

      decoration: InputDecoration(
        hintStyle: _hintStyle(),
        hintText: _hintText(),
        prefixIcon: _prefixIcon(),
        prefixIconColor: _prefixSuffixIconColor(),
        suffixIcon: _suffixIcon(),
        suffixIconColor: _prefixSuffixIconColor(),
        border: _border(),
        // errorBorder: _border(),
        // focusedBorder: _border(),
        // enabledBorder: _border(),
        // disabledBorder: _border(),
        // focusedErrorBorder: _border(),
        filled: widget.filled,
        fillColor: widget.fillColor,
      ),
    );
  }

  void _focusNodeListener() {
    setState(() {});
  }

  TextInputType _keyboardType() {
    if (widget.type == TextFieldType.email) {
      return TextInputType.emailAddress;
    }
    if (widget.type == TextFieldType.phone) {
      return TextInputType.phone;
    }
    if (widget.type == TextFieldType.password) {
      return TextInputType.visiblePassword;
    }
    return TextInputType.text;
  }

  bool _isEmailValid(String email) {
    return RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(email);
  }

  String? _validator(String? value) {
    String? validateMessage;

    if (widget.isRequired && (value?.isEmpty ?? true)) {
      validateMessage = "Required";
    } else if (widget.type == TextFieldType.email && !_isEmailValid(value!)) {
      validateMessage = validateMessage = "Please enter valid email address";
    } else if (widget.validator != null) {
      validateMessage = widget.validator!(value);
    }

    if (validateMessage != null) {
      setState(() {
        isContentValid = false;
      });
    } else {
      setState(() {
        isContentValid = true;
      });
    }

    return validateMessage;
  }

  TextStyle _hintStyle() {
    Color? hintColor = Colors.grey;

    if (!isContentValid) {
      hintColor = widget.errorColor ?? Theme.of(context).colorScheme.error;
    } else if (focusNode.hasFocus) {
      hintColor = widget.activeColor;
    }

    if (widget.hintStyle != null) {
      return widget.hintStyle!.copyWith(color: hintColor);
    }

    return TextStyle(
      color: hintColor,
      fontSize: ResponsiveText.getResponsiveFontSize(15),
    );
  }

  String? _hintText() {
    String? hintText;

    if (widget.hintText != null) {
      hintText = widget.hintText;
    } else if (widget.type == TextFieldType.email) {
      hintText = "Email";
    } else if (widget.type == TextFieldType.password) {
      hintText = "Password";
    } else if (widget.type == TextFieldType.phone) {
      hintText = "Phone";
    }

    if (hintText != null && !widget.isRequired) {
      hintText += " (optional)";
    }

    return hintText;
  }

  Widget? _suffixIcon() {
    if (widget.prefixIcon != null) {
      return widget.prefixIcon;
    }
    if (widget.type == TextFieldType.email) {
      return const Icon(Icons.email_outlined);
    }
    if (widget.type == TextFieldType.password) {
      return const Icon(Icons.lock_outline);
    }
    if (widget.type == TextFieldType.phone) {
      return const Icon(Icons.phone_outlined);
    }
    return null;
  }

  Widget? _prefixIcon() {
    if (widget.suffixIcon != null) {
      return widget.suffixIcon;
    }
    if (widget.type == TextFieldType.password) {
      return Focus(
        canRequestFocus: false,
        descendantsAreFocusable: false,
        child: IconButton(
          onPressed: () {
            setState(() {
              isContentVisible = !isContentVisible;
            });
          },
          icon: Icon(
            !isContentVisible
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
          ),
        ),
      );
    }
    return null;
  }

  Color? _prefixSuffixIconColor() {
    if (!isContentValid) return Theme.of(context).colorScheme.error;

    if (focusNode.hasFocus) return widget.activeColor;

    return Colors.grey;
  }

  InputBorder _border() {
    if (widget.border != null) {
      return widget.border!;
    }
    return OutlineInputBorder(borderRadius: BorderRadius.circular(12));
  }
}
