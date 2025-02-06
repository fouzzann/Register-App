import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:machine_task/controllers/home_controller.dart';
import 'package:machine_task/utils/app_color_themes.dart';
import 'package:machine_task/views/screens/user_list.dart';
import 'package:machine_task/views/screens/api_page.dart';
import 'package:machine_task/widgets/loged_users/app_bar_contant.dart';
import 'package:machine_task/widgets/loged_users/bottom_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  final Map<String, dynamic> user;
  const HomeScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController(user));

    return Scaffold(
      backgroundColor: ThemeConstants.backgroundColor,
      appBar: AppBarWidget(user: user),
      body: Obx(() {
        return FadeTransition(
          opacity: homeController.fadeAnimation,
          child: IndexedStack(
            index: homeController.currentIndex.value,
            children: [
              UserListScreen(currentUser: user),
              ApiScreen(),
            ],
          ),
        );
      }),
      bottomNavigationBar: NavigationBarWidget(
        homeController: homeController,
        context: context,
      ),
    );
  }
}
