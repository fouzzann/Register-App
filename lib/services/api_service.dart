import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:machine_task/models/api_model.dart';

class ApiService {
  static const String apiUrl = 'https://meetingapi.infolksgroup.com/api/user';

  static Future<List<User>> fetchUsers() async {
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> decodedData = json.decode(response.body);
        return decodedData.map((json) => User.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load users: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }
}
