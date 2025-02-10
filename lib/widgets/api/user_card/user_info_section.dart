import 'package:flutter/material.dart';
import 'package:machine_task/models/api_model.dart';
import 'package:machine_task/utils/app_color_themes.dart';

class UserInfoSection extends StatelessWidget {
  final User user;

  const UserInfoSection({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          user.name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
            color: ThemeConstants.primaryBlue,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          user.email,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
            letterSpacing: 0.2,
          ),
        ),
      ],
    );
  }
}