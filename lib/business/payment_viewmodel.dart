import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../service/payment_service.dart';

class PaymentViewModel with ChangeNotifier {
  final PaymentService _paymentService = PaymentService();
  List<String> fromAccounts = [];
  String toAccount = '';
  String accountName = '';
  String currentDateTime = '';
  bool isLoading = true;
  String? selectedFromAccount;

  // Fetch accounts
  Future<void> fetchAccounts(String nic) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await _paymentService.fetchAccounts(nic);
      fromAccounts = List<String>.from(response['content']['fromAccountList']);
      toAccount = response['content']['toAccount'];
      accountName = response['content']['toAccountName'];
    } catch (e) {
      print('Error: $e');
    }

    isLoading = false;
    notifyListeners();
  }

  // Make payment
  Future<void> makePayment(String nic, String amount, String tranRef, BuildContext context) async {
    if (selectedFromAccount == null || toAccount.isEmpty || accountName.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Please fill all fields'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    try {
      final response = await _paymentService.makePayment(nic, amount, tranRef);
      if (response['status'] == "R000") {
        final url = response['content']['webUrl'];
        _launchUrl(url, context);
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Payment Failed'),
            content: Text(response['message']),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  // Launch URL
  Future<void> _launchUrl(String url, BuildContext context) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      print('Could not launch $url');
    }
  }

  // Set current date and time
  void setCurrentDateTime() {
    final now = DateTime.now();
    currentDateTime = '${now.day}/${now.month}/${now.year} ${now.hour}:${now.minute}';
    notifyListeners();
  }
}