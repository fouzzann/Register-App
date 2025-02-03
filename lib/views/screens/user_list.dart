import 'package:flutter/material.dart';
import 'package:machine_task/db/db_helper.dart';
import 'package:machine_task/widgets/loged_users/user_card.dart';

class UserListScreen extends StatelessWidget {
  final Map<String, dynamic> currentUser;

  const UserListScreen({Key? key, required this.currentUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: DatabaseHelper().getAllUsers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No users found'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            return UserCard(user: snapshot.data![index]);
          },
        );
      },
    );
  }
}