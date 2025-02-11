class LoginModel {
  String nic;
  String password;

  LoginModel({required this.nic, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'nic': nic,
      'password': password,
    };
  }
}