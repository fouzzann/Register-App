import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:machine_task/utils/app_color_themes.dart';

class CustomBottomNav extends StatelessWidget {
  final RxInt currentIndex;
  final Function(int) onPageChange;
  final VoidCallback onLogoutTap;

  const CustomBottomNav({
    Key? key,
    required this.currentIndex,
    required this.onPageChange,
    required this.onLogoutTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
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
            selectedIndex: currentIndex.value,
            backgroundColor: ThemeConstants.backgroundColor,
            indicatorColor: ThemeConstants.secondaryBlue,
            onDestinationSelected: (index) {
              if (index == 2) {
                onLogoutTap();
              } else {
                onPageChange(index);
              }
            },
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
        ));
  }
}