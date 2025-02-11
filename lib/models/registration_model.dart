class RegistrationModel {
  final String nic;
  final String firstName;
  final String lastName;
  final String email;
  final String mobileNumber;
  final String password;

  RegistrationModel(this.nic, this.firstName, this.lastName, this.email, this.mobileNumber, this.password);

  Map<String, dynamic> toJson() {
    return {
      "nic": nic,
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "mobileNumber": mobileNumber,
      "password": password,
    };
  }
}