// import 'package:dlbsweep/presentation/merchant_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';
// import 'package:url_launcher/url_launcher.dart';
//
// import '../main.dart';
// import 'grid_view_page.dart';
//
// class PaymentScreen extends StatefulWidget {
//   final String nic;
//   final String amount;
//   final String tranRef;
//
//   PaymentScreen({required this.nic, required this.amount, required this.tranRef});
//
//   @override
//   _PaymentScreenState createState() => _PaymentScreenState();
// }
//
// class _PaymentScreenState extends State<PaymentScreen> {
//   String? selectedFromAccount;
//   String toAccount = '';
//   List<String> fromAccounts = [];
//   bool isLoading = true;
//   String accountName = '';
//   String currentDateTime = '';
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchAccounts();
//     _setCurrentDateTime();
//   }
//
//   void _setCurrentDateTime() {
//     final now = DateTime.now();
//     setState(() {
//       currentDateTime = '${now.day}/${now.month}/${now.year} ${now.hour}:${now.minute}';
//     });
//   }
//
//   Future<void> _fetchAccounts() async {
//     final String nic = widget.nic;
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('access_token');
//
//     try {
//       final response = await http.post(
//         Uri.parse('https://epictechdev.com:50422/api/third-party/user/account-details'),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//         body: jsonEncode({'nic': nic}),
//       );
//
//       print("Response: ${response.body}");
//
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> responseData = jsonDecode(response.body);
//         setState(() {
//           fromAccounts = List<String>.from(responseData['content']['fromAccountList']);
//           toAccount = responseData['content']['toAccount'];
//           accountName = responseData['content']['toAccountName'];
//           isLoading = false;
//         });
//       } else {
//         navigateToMerchantScreen();
//         print('Failed to load accounts: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }
//
//   Future<void> proceedToPay() async {
//     final String nic = widget.nic;
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('access_token');
//
//     if (selectedFromAccount == null || toAccount.isEmpty || accountName.isEmpty) {
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text('Error'),
//           content: Text('Please fill all fields'),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text('OK'),
//             ),
//           ],
//         ),
//       );
//       return;
//     }
//
//     final Map<String, dynamic> requestBody = {
//       'nic': widget.nic,
//       'amount': widget.amount,
//       'transactionRef': widget.tranRef,
//     };
//
//     try {
//       final response = await http.post(
//         Uri.parse('https://epictechdev.com:50422/api/third-party/user/pay-lottery'),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//         body: jsonEncode(requestBody),
//       );
//
//       print("Response: ${response.body}");
//
//       if (response.statusCode == 200) {
//         final responseData = json.decode(response.body);
//         if (responseData['status'] == "R000") { // Check for success status
//           print("Response success URL : $responseData");
//           final url = responseData['content']['webUrl'];
//           final uri = Uri.parse(url);
//           print("URI :::::::::::: $uri");
//           if (await canLaunchUrl(uri)) {
//             await launchUrl(uri, mode: LaunchMode.externalApplication);
//           } else {
//             print('Could not launch $url');
//           }
//         } else {
//           showDialog(
//             context: context,
//             builder: (context) => AlertDialog(
//               title: Text('Payment Failed'),
//               content: Text('Payment processing failed. Please try again.'),
//               actions: [
//                 TextButton(
//                   onPressed: () => Navigator.pop(context),
//                   child: Text('OK'),
//                 ),
//               ],
//             ),
//           );
//         }
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Fund Transfer', style: TextStyle(color: Colors.white)),
//         backgroundColor: Colors.blue,
//         iconTheme: IconThemeData(color: Colors.white),
//       ),
//       body: isLoading
//           ? Center(child: CircularProgressIndicator())
//           : Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Center(
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Card(
//                   elevation: 5,
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       children: [
//                         DropdownButtonFormField<String>(
//                           value: selectedFromAccount,
//                           decoration: InputDecoration(
//                             labelText: 'Select your beneficiary account',
//                             border: OutlineInputBorder(),
//                           ),
//                           onChanged: (String? newValue) {
//                             setState(() {
//                               selectedFromAccount = newValue;
//                             });
//                           },
//                           items: fromAccounts.map<DropdownMenuItem<String>>((String value) {
//                             return DropdownMenuItem<String>(
//                               value: value,
//                               child: Text(value),
//                             );
//                           }).toList(),
//                         ),
//                         SizedBox(height: 20),
//                         TextField(
//                           decoration: InputDecoration(
//                             labelText: 'To Account',
//                             border: OutlineInputBorder(),
//                           ),
//                           controller: TextEditingController(text: toAccount),
//                           readOnly: false,
//                         ),
//                         SizedBox(height: 20),
//                         TextField(
//                           decoration: InputDecoration(
//                             labelText: 'Account Name',
//                             border: OutlineInputBorder(),
//                           ),
//                           controller: TextEditingController(text: accountName),
//                           readOnly: false,
//                         ),
//                         SizedBox(height: 20),
//                         Text(
//                           'Current Date and Time: $currentDateTime',
//                           style: TextStyle(fontSize: 16, color: Colors.grey[700]),
//                         ),
//                         SizedBox(height: 20),
//                         ElevatedButton(
//                           onPressed: proceedToPay,
//                           style: ElevatedButton.styleFrom(
//                             foregroundColor: Colors.white, backgroundColor: Colors.blue,
//                             padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                           ),
//                           child: Text('Proceed to Pay'),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   void navigateToMerchantScreen() {
//     Navigator.of(navigatorKey.currentContext!).push(
//       MaterialPageRoute(
//         builder: (context) => MerchantScreen(nic: widget.nic,),
//       ),
//     );
//   }
// }