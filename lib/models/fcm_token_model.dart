class FcmTokenModel {
  final String token;

  FcmTokenModel({required this.token});

  Map<String, dynamic> toJson() {
    return {'token': token};
  }
}