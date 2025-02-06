import 'package:flutter/material.dart';
import 'package:machine_task/models/api_model.dart';
import 'package:machine_task/services/api_service.dart';
import 'package:machine_task/utils/app_color_themes.dart';
import 'package:machine_task/widgets/api/api_user_card.dart';

class ApiScreen extends StatefulWidget {
  const ApiScreen({Key? key}) : super(key: key);

  @override
  _ApiScreenState createState() => _ApiScreenState();
}

class _ApiScreenState extends State<ApiScreen> with SingleTickerProviderStateMixin {
  List<User>? users;
  String? error;
  bool isLoading = true;
  late AnimationController _refreshIconController;

  @override
  void initState() {
    super.initState();
    _refreshIconController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );  
    fetchUserData();
  }

  @override
  void dispose() {
    _refreshIconController.dispose();
    super.dispose();
  }

  Future<void> fetchUserData() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    _refreshIconController.repeat();

    try {
      users = await ApiService.fetchUsers();
    } catch (e) {
      setState(() => error = e.toString());
    } finally {
      setState(() => isLoading = false);
      _refreshIconController.stop();
      _refreshIconController.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeConstants.backgroundColor,
      appBar: AppBar(
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
          RotationTransition(
            turns: Tween(begin: 0.0, end: 1.0).animate(_refreshIconController),
            child: IconButton(
              icon: const Icon(Icons.refresh_rounded, color: ThemeConstants.primaryBlue),
              onPressed: fetchUserData,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    if (isLoading) {
      return _buildLoadingState();
    }
    if (error != null) {
      return _buildErrorState();
    }
    if (users == null || users!.isEmpty) {
      return _buildEmptyState();
    }
    return _buildUserList();
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(ThemeConstants.primaryBlue),
          ),
          const SizedBox(height: 16),
          Text(
            'Loading users...',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red[50],
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.error_outline, size: 32, color: Colors.red[400]),
            ),
            const SizedBox(height: 16),
            Text(
              error!,
              style: TextStyle(color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: fetchUserData,
              style: ElevatedButton.styleFrom(
                backgroundColor: ThemeConstants.primaryBlue,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.refresh_rounded, color: ThemeConstants.backgroundColor),
              label: Text(
                'Try Again',
                style: TextStyle(color: ThemeConstants.backgroundColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.people_outline_rounded,
            size: 48,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No users found',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserList() {
    return RefreshIndicator(
      color: ThemeConstants.primaryBlue,
      onRefresh: fetchUserData,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: users!.length,
        itemBuilder: (context, index) {
          return UserCard(user: users![index]);
        },
      ),
    );
  }
}