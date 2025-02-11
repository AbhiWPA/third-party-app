import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../service/merchant_service.dart';

class MerchantViewmodel with ChangeNotifier {
  final MerchantService _merchantService = MerchantService();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  // Handle special merchant interaction
  Future<void> handleSpecialMerchant(String nic, String pushId, String token, BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _merchantService.checkUser(nic, pushId, token);

      if ((response['status'] == '0011' || response['status'] == '0010') && response['content'] != null) {
        final String redirectUrl = response['content']['url'];
        _launchUrl(redirectUrl, context);
      } else {
        print('Invalid response or status: ${response['message']}');
      }
    } catch (e) {
      print('Error: $e');
    }

    _isLoading = false;
    notifyListeners();
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
}