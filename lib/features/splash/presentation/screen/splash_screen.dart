import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:saas_mosque/core/router/routes_config.dart';
import 'package:saas_mosque/core/style/app_palette.dart';
import 'package:saas_mosque/features/splash/data/repositories/splash_repo.dart';

import '../../../../core/widget/custom_circular_progress_indicator.dart';

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
      print("SplashScreen: About to call getProfile()");
      (await widget.splashRepo.getProfile()).fold(
        (l) {
          print(
            "SplashScreen: getProfile failed, navigating to login: ${l.errorMessege}",
          );
          context.pushReplacement(AppRoutes.kLoginScreen);
        },
        (r) {
          print("SplashScreen: getProfile succeeded, navigating to campaigns");
          context.pushReplacement(AppRoutes.kCampaignsScreen);
        },
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppPalette.backgroundColor,
      body: Center(
        child: CustomCircularProgressIndicator(color: AppPalette.white),
      ),
    );
  }
}
