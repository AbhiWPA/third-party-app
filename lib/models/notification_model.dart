class NotificationModel {
  final String title;
  final String body;
  final String nic;
  final String amount;
  final String tranRef;

  NotificationModel({
    required this.title,
    required this.body,
    required this.nic,
    required this.amount,
    required this.tranRef,
  });

  factory NotificationModel.fromMap(Map<String, dynamic> data) {
    return NotificationModel(
      title: data['title'] ?? '',
      body: data['body'] ?? '',
      nic: data['nic'] ?? '',
      amount: data['amount'] ?? '',
      tranRef: data['tranRef'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
      'nic': nic,
      'amount': amount,
      'tranRef': tranRef,
    };
  }
}
