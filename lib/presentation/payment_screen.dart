import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../business/payment_viewmodel.dart';

class PaymentScreen extends StatelessWidget {
  final String nic;
  final String amount;
  final String tranRef;

  PaymentScreen({required this.nic, required this.amount, required this.tranRef});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PaymentViewModel()..fetchAccounts(nic)..setCurrentDateTime(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Fund Transfer', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.blue,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Consumer<PaymentViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return Center(child: CircularProgressIndicator());
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              DropdownButtonFormField<String>(
                                value: viewModel.selectedFromAccount,
                                decoration: InputDecoration(
                                  labelText: 'Select your beneficiary account',
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (String? newValue) {
                                  viewModel.selectedFromAccount = newValue;
                                },
                                items: viewModel.fromAccounts.map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                              SizedBox(height: 20),
                              TextField(
                                decoration: InputDecoration(
                                  labelText: 'To Account',
                                  border: OutlineInputBorder(),
                                ),
                                controller: TextEditingController(text: viewModel.toAccount),
                                readOnly: true,
                              ),
                              SizedBox(height: 20),
                              TextField(
                                decoration: InputDecoration(
                                  labelText: 'Account Name',
                                  border: OutlineInputBorder(),
                                ),
                                controller: TextEditingController(text: viewModel.accountName),
                                readOnly: true,
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Current Date and Time: ${viewModel.currentDateTime}',
                                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                              ),
                              SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () => viewModel.makePayment(nic, amount, tranRef, context),
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white, backgroundColor: Colors.blue,
                                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                                ),
                                child: Text('Proceed to Pay'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}