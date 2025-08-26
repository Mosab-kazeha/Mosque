import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:saas_mosque/core/router/routes_config.dart';
import 'package:saas_mosque/core/style/app_palette.dart';
import 'package:saas_mosque/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: AppPalette.backgroundColor),
            margin: EdgeInsets.zero,
            padding: EdgeInsets.symmetric(vertical: 16), // reduce height
            child: Center(
              child: Text(
                'منصة حلقات',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const Spacer(),
          Directionality(
            textDirection: TextDirection.rtl,
            child: ListTile(
              contentPadding: const EdgeInsets.all(20),
              leading: const Icon(Icons.logout),
              title: const Text('تسجيل الخروج'),
              onTap: () async {
                final prefs = serviceLocater.get<SharedPreferences>();
                await prefs.remove('campaign_id');
                await prefs.remove('group_id');
                await prefs.remove('teacher-id');
                await prefs.remove('token');
                await prefs.remove('permessions');
                // ignore: use_build_context_synchronously
                context.pushReplacement(AppRoutes.kLoginScreen);
              },
            ),
          ),
        ],
      ),
    );
  }
}
