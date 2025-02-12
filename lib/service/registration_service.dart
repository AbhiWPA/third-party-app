import 'dart:convert';
import 'package:http/http.dart' as http;

import '../beans/register_bean.dart';

class RegistrationService {
  final String _baseUrl = 'https://epictechdev.com:50422/api/third-party/user/register';

  Future<Map<String, dynamic>> registerUser(RegisterReqBean user) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(user.toJson()),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception("Registration failed with status code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error during registration: $e");
    }
  }
}
