import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ApiService {
  // Send Purchase Request
  Future<void> sendPurchaseRequest(String nic, String amount, String tranRef) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    final String apiUrl = 'https://epictechdev.com:50422/api/third-party/user/pay-lottery';

    final Map<String, dynamic> requestBody = {
      'nic': nic,
      'amount': amount,
      'transactionRef': tranRef,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(requestBody),
      );

      print("Pay Lottery Request Body: ${requestBody}");
      if (response.statusCode == 200) {
        print("Pay Lottery Response: ${response.body}");
        print("✅ Purchase request successful!");
      } else {
        print("❌ Failed to make purchase request. Response: ${response.body}");
      }
    } catch (e) {
      print("❌ Error making purchase request: $e");
    }
  }
}