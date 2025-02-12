class PaymentModel {
  String nic;
  String amount;
  String tranRef;

  PaymentModel({required this.nic, required this.amount, required this.tranRef});

  Map<String, dynamic> toJson() {
    return {
      'nic': nic,
      'amount': amount,
      'transactionRef': tranRef,
    };
  }
}