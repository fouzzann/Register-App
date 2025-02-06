import 'package:flutter/material.dart';
import 'package:machine_task/models/api_model.dart';
import 'package:machine_task/services/api_service.dart';
import 'package:machine_task/utils/app_color_themes.dart';
import 'package:machine_task/widgets/api/api_state/api_empty_state.dart';
import 'package:machine_task/widgets/api/api_state/api_error_state.dart';
import 'package:machine_task/widgets/api/api_state/api_loading_state.dart';
import 'package:machine_task/widgets/api/api_user_list.dart';
import 'package:machine_task/widgets/api/app_bar.dart';

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
      appBar: ApiAppBar(refreshIconController: _refreshIconController, onRefresh: fetchUserData),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    if (isLoading) {
      return ApiLoadingState();
    }
    if (error != null) {
      return ApiErrorState(error: error!, onRetry: fetchUserData);
    }
    if (users == null || users!.isEmpty) {
      return ApiEmptyState();
    }
    return ApiUserList(users: users!, onRefresh: fetchUserData);
  }
}


