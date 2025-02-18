import 'package:dlbsweep/models/notification_model.dart';

import '../service/api_service.dart';
import '../service/notifications_service.dart';

class NotificationViewModel {
  final NotificationService _notificationService = NotificationService();
  final ApiService _apiService = ApiService();

  Future<void> initializeNotifications() async {
    await _notificationService.initialize();
  }

  Future<void> showNotification(NotificationModel notification) async {
    await _notificationService.showNotification(
      NotificationModel(title: notification.title, body: notification.body, nic: notification.nic, amount: notification.amount, tranRef: notification.tranRef)
    );
  }

  Future<void> sendPurchaseRequest(String nic, String amount, String tranRef) async {
    await _apiService.sendPurchaseRequest(nic, amount, tranRef);
  }
}