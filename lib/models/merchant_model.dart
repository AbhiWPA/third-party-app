class MerchantModel {
  String pushId;

  MerchantModel({required this.pushId});

  Map<String, dynamic> toJson() {
    return {
      'pushId': pushId,
    };
  }
}