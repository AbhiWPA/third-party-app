import 'package:shared_preferences/shared_preferences.dart';

class TokenUtil {
  // Save the token
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', token);
  }

  // Retrieve the token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  // Remove the token (e.g., for logout)
  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
  }
}
