class RegisterReqBean {
  String nic;
  String firstName;
  String lastName;
  String email;
  String mobileNumber;
  String password;

  RegisterReqBean(this.nic, this.firstName, this.lastName, this.email, this.mobileNumber,
      this.password);


  Map<String, dynamic> toJson() {
    return {
      'nic' : nic,
      'firstName' : firstName,
      'lastName' : lastName,
      'email' : email,
      'mobileNumber' : mobileNumber,
      'password': password,
    };
  }
}