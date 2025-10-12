import 'package:flutter/material.dart';

class SessionButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  const SessionButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Colors.white),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
