import 'dart:convert';
import 'package:dlbsweep/business/login_viewmodel.dart';
import 'package:dlbsweep/models/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../beans/login_bean.dart';

class AuthService {
  // Login API call
  Future<bool?> login(LoginModel loginModel) async {
    LoginReqBean loginReqBean = LoginReqBean(nic: loginModel.nic, password: loginModel.password);

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
          final String accName = responseData['content']['name'];
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('access_token', accessToken);
          await prefs.setString('username', accName);
          return true;
        } else {
          print('Invalid response structure or status: ${responseData['message']}');
          return false;
        }
      } else {
        print('Failed to login: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error during login: $e');
    }
    return false;
  }
}