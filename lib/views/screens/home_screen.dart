import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:machine_task/controllers/home_controller.dart';
import 'package:machine_task/utils/app_color_themes.dart';
import 'package:machine_task/views/screens/api_page.dart';
import 'package:machine_task/views/screens/user_list.dart';
import 'package:machine_task/widgets/loged_users/app_bar_contant.dart';
import 'package:machine_task/widgets/loged_users/bottom_nav_bar.dart';
import 'package:machine_task/widgets/loged_users/logout_dialog.dart';

class HomeScreen extends StatelessWidget {
  final Map<String, dynamic> user;
  HomeScreen({Key? key, required this.user}) : super(key: key);

  final HomeController homeController = Get.put(HomeController());
  final List<Widget> pages = [];

  @override
  Widget build(BuildContext context) {
    pages.addAll([
      UserListScreen(currentUser: user),
      ApiScreen(),
    ]);

    return Scaffold(
      backgroundColor: ThemeConstants.backgroundColor,
      appBar: CustomAppBar(user: user),
      body: Obx(() => IndexedStack(
            index: homeController.currentIndex.value,
            children: pages,
          )),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: homeController.currentIndex,
        onPageChange: homeController.changePage,
        onLogoutTap: () => LogoutBottomSheet.show(context),
      ),
    );
  }
}