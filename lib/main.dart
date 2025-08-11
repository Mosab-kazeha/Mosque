import 'package:flutter/material.dart';
import 'package:saas_mosque/core/router/router_config.dart';
import 'package:saas_mosque/core/style/app_palette.dart';
import 'package:saas_mosque/core/utils/size_config.dart';

import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();

  runApp(const Mosque());
}

class Mosque extends StatelessWidget {
  const Mosque({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.light().copyWith(
          primary: AppPalette.backgroundColor,
        ),
      ),
    );
  }
}
