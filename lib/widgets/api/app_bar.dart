import 'package:flutter/material.dart';
import 'package:machine_task/utils/app_color_themes.dart';
import 'package:machine_task/widgets/api/refresh_icon.dart';

class ApiAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AnimationController refreshIconController;
  final VoidCallback onRefresh;

  const ApiAppBar({Key? key, required this.refreshIconController, required this.onRefresh}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: ThemeConstants.backgroundColor,
      title: const Text(
        'API Users',
        style: TextStyle(
          color: ThemeConstants.primaryBlue,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
      actions: [
        RefreshIcon(controller: refreshIconController, onPressed: onRefresh),
        const SizedBox(width: 8),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}