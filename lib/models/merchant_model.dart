class MerchantModel {
  String nicNumber;
  String pushId;

  MerchantModel({required this.nicNumber, required this.pushId});

  Map<String, dynamic> toJson() {
    return {
      'nicNumber': nicNumber,
      'pushId': pushId,
    };
  }
}