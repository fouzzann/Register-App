import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:machine_task/auth/login.dart';
import 'package:machine_task/utils/app_color_themes.dart';

class LogoutDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: ThemeConstants.backgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          const Icon(
            Icons.logout_rounded,
            size: 40,
            color: ThemeConstants.primaryBlue,
          ),
          const SizedBox(height: 16),
          const Text(
            'Logout',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: ThemeConstants.primaryBlue,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Are you sure you want to logout?',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      side: const BorderSide(color: ThemeConstants.primaryBlue),
                    ),
                    child: const Text('Cancel', style: TextStyle(color: ThemeConstants.primaryBlue)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Get.offAll(() => LoginScreen()),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      backgroundColor: ThemeConstants.primaryBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Logout', style: TextStyle(color: ThemeConstants.backgroundColor)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
