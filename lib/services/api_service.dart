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

      switch (response.statusCode) {
        case 200: // OK
          final List<dynamic> decodedData = json.decode(response.body);
          return decodedData.map((json) => User.fromJson(json)).toList();

        case 400: // Bad Request
          throw Exception('Bad request: The server could not understand the request.');

        case 401: // Unauthorized
          throw Exception('Unauthorized: Access is denied due to invalid credentials.');

        case 403: // Forbidden
          throw Exception('Forbidden: You do not have permission to access this resource.');

        case 404: // Not Found
          throw Exception('Not found: The requested resource could not be found.');

        case 500: // Internal Server Error
          throw Exception('Server error: Something went wrong on the server.');

        case 503: // Service Unavailable
          throw Exception('Service unavailable: The server is temporarily unavailable.');

        default:
          throw Exception('Unexpected error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }
}
