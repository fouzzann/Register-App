// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:machine_task/utils/app_color_themes.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onDestinationSelected;

  const BottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onDestinationSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ThemeConstants.backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: NavigationBar(
        selectedIndex: currentIndex,
        backgroundColor: ThemeConstants.backgroundColor,
        indicatorColor: ThemeConstants.secondaryBlue,
        onDestinationSelected: onDestinationSelected,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.people_outline, color: ThemeConstants.primaryBlue),
            selectedIcon: Icon(Icons.people, color: ThemeConstants.backgroundColor),
            label: 'Users',
          ),
          NavigationDestination(
            icon: Icon(Icons.api_outlined, color: ThemeConstants.primaryBlue),
            selectedIcon: Icon(Icons.api, color: ThemeConstants.backgroundColor),
            label: 'API',
          ),
          NavigationDestination(
            icon: Icon(Icons.logout_outlined, color: ThemeConstants.primaryBlue),
            label: 'Logout',
          ),
        ],
      ),
    );
  }
}
