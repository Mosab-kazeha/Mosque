import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:saas_mosque/core/router/routes_config.dart';
import 'package:saas_mosque/core/style/app_palette.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 2),
      // ignore: use_build_context_synchronously
      () => context.pushReplacement(AppRoutes.kLoginScreen),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF2b836b),
      body: Center(child: CircularProgressIndicator(color: AppPalette.white)),
    );
  }
}
