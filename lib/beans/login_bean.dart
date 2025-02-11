class LoginReqBean {
  String nic;
  String password;

  LoginReqBean({required this.nic, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'nic': nic,
      'password': password,
    };
  }
}