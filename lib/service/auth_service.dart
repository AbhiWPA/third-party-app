import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../beans/login_bean.dart';

class AuthService {
  // Login API call
  Future<void> login(String nic, String password) async {
    LoginReqBean loginReqBean = LoginReqBean(nic: nic, password: password);

    try {
      final response = await http.post(
        Uri.parse('https://epictechdev.com:50422/api/third-party/user/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(loginReqBean.toJson()),
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        if (responseData['status'] == 'R000' && responseData['content'] != null) {
          print('Login successful!');

          final String accessToken = responseData['content']['access_token'];
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('access_token', accessToken);
        } else {
          print('Invalid response structure or status: ${responseData['message']}');
        }
      } else {
        print('Failed to login: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during login: $e');
    }
  }
}