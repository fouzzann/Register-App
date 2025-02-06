import 'package:flutter/material.dart';
import 'package:machine_task/models/api_model.dart';
import 'package:machine_task/utils/app_color_themes.dart';
import 'package:machine_task/widgets/api/api_user_card.dart';

class ApiUserList extends StatelessWidget {
  final List<User> users;
  final Future<void> Function() onRefresh;

  const ApiUserList({Key? key, required this.users, required this.onRefresh}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: ThemeConstants.primaryBlue,
      onRefresh: onRefresh,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: users.length,
        itemBuilder: (context, index) {
          return UserCard(user: users[index]);
        },
      ),
    );
  }
}
