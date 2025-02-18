import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PaymentService {
  // Fetch account details
  Future<Map<String, dynamic>> fetchAccounts(String nic) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    prefs.setString("notification", "");

    final response = await http.post(
      Uri.parse('https://epictechdev.com:50422/api/third-party/user/account-details'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'nic': nic}),
    );

    print("Response: ${response.body}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load accounts: ${response.statusCode}');
    }
  }

  // Make payment
  Future<Map<String, dynamic>> makePayment(String nic, String amount, String tranRef) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    final response = await http.post(
      Uri.parse('https://epictechdev.com:50422/api/third-party/user/pay-lottery'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'nic': nic,
        'amount': amount,
        'transactionRef': tranRef,
      }),
    );

    print("Response: ${response.body}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to make payment: ${response.statusCode}');
    }
  }
}