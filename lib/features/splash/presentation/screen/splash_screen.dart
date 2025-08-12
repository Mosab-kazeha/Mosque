import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:saas_mosque/core/router/routes_config.dart';
import 'package:saas_mosque/core/style/app_palette.dart';
import 'package:saas_mosque/features/splash/data/repositories/splash_repo.dart';

class SplashScreen extends StatefulWidget {
  final SplashRepo splashRepo;
  const SplashScreen(this.splashRepo, {super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () async {
      (await widget.splashRepo.getProfile()).fold(
        (l) => context.pushReplacement(AppRoutes.kLoginScreen),
        (r) => context.pushReplacement(AppRoutes.kCampaignsScreen),
      );
    });
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
