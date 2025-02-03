import 'package:flutter/material.dart';
import 'package:machine_task/models/api_model.dart';
import 'package:machine_task/services/api_service.dart';
import 'package:machine_task/widgets/api/api_user_card.dart';

class ApiScreen extends StatefulWidget {
  const ApiScreen({Key? key}) : super(key: key);

  @override
  _ApiScreenState createState() => _ApiScreenState();
}

class _ApiScreenState extends State<ApiScreen> {
  List<User>? users;
  String? error;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      users = await ApiService.fetchUsers();
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('API Users'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: fetchUserData,
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        error!,
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: fetchUserData,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : users == null || users!.isEmpty
                  ? const Center(child: Text('No users found'))
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: users!.length,
                      itemBuilder: (context, index) {
                        return UserCard(user: users![index]);
                      },
                    ),
    );
  }
}
