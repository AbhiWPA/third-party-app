import 'dart:convert';
import 'package:dlbsweep/models/merchant_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MerchantService {
  // Check user for special merchant
  Future<Map<String, dynamic>> checkUser(MerchantModel merchantModel, String token) async {
    try {
      final response = await http.post(
        Uri.parse('https://epictechdev.com:50422/api/third-party/user/check-user'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(merchantModel.toJson()),
      );

      print("Response: ${response.body}");

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to check user: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  }
}