import 'package:assessment/app/constants/app_color.dart';
import 'package:assessment/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: context.width * .7,
      backgroundColor: AppColors.white,
      child: Column(
        children: [
          const ListTile(),
          ListTile(
            leading: const Icon(Icons.person),
            onTap: () {},
            title: const Text('Account'),
          ),
          ListTile(
            leading: const Icon(Icons.error),
            onTap: () {},
            title: const Text('Terms and Conditions'),
          ),
          ListTile(
            leading: const Icon(Icons.lock),
            onTap: () {},
            title: const Text('Privacy Policy'),
          ),
          ListTile(
            leading: const Icon(Icons.error),
            onTap: () {},
            title: const Text('About Us'),
          ),
          const Spacer(),
          ListTile(
            leading: const Icon(Icons.logout),
            onTap: () => Get.offAllNamed(Routes.login),
            title: const Text('Logout'),
          )
        ],
      ),
    );
  }
}
