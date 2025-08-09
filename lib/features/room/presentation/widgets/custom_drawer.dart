import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF2b836b)),
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
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('تسجيل الخروج'),
            onTap: () async {
              // final prefs = serviceLocater.get<SharedPreferences>();
              // await prefs.remove('campaign_id');
              // await prefs.remove('group_id');
              // await prefs.remove('token');
              // if (Navigator.canPop(context)) {
              //   Navigator.pop(context); // Close drawer
              // }
              // Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}
