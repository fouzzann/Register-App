
import 'package:flutter/material.dart';
import 'package:machine_task/utils/app_color_themes.dart';
import 'package:machine_task/widgets/loged_users/user_profile_avather.dart';

class AppBarContent extends StatelessWidget {
  final Map<String, dynamic> user;

  const AppBarContent({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        UserProfileAvatar(user: user),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome back,',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontWeight: FontWeight.normal,
              ),
            ),
            Text(
              user['name'],
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: ThemeConstants.primaryBlue,
              ),
            ),
          ],
        ),
      ],
    );
  }
}


