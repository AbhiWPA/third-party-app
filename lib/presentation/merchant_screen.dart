import 'package:dlbsweep/business/merchant_viewmodel.dart';
import 'package:dlbsweep/presentation/login_screen.dart';
import 'package:dlbsweep/service/notifications_service.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MerchantScreen extends StatelessWidget {
  MerchantScreen({Key? key}) : super(key: key);

  void _navigateToLogin(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
          (route) => false,
    );
  }

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', '');
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
          (route) => false,
    );
  }

  Future<String?> _setAccountName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('username'); // Returns the username or null
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MerchantViewmodel(),
      child: Scaffold(
        appBar: AppBar(
          title: FutureBuilder<String?>(
            future: _setAccountName(), // Call the async function
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Show a loading indicator while fetching the username
                return Text('Loading...', style: TextStyle(color: Colors.black));
              } else if (snapshot.hasError) {
                // Handle errors
                return Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.black));
              } else if (snapshot.hasData && snapshot.data != null) {
                // Display the username if available
                return Text(snapshot.data!, style: TextStyle(color: Colors.black));
              } else {
                // Fallback if no username is found
                return Text('Guest', style: TextStyle(color: Colors.black));
              }
            },
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => _navigateToLogin(context),
          ),
          actions: [
            IconButton(
                onPressed: () => _logout(context),
                icon: const Icon(Icons.logout_rounded))
          ],
        ),
        body: Consumer<MerchantViewmodel>(
          builder: (context, viewModel, child) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  // Add space between AppBar and Slider
                  SizedBox(height: 20),

                  // Slider Section
                  _buildSliderWithHeader(),

                  // Add space between Slider and Heading Tiles
                  SizedBox(height: 20),

                  // Heading Tiles
                  _buildHeadingTiles(),

                  // Add space between Heading Tiles and Merchant Grid
                  SizedBox(height: 20),

                  // Merchant Grid
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GridView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                        childAspectRatio: 0.7,
                      ),
                      children: [
                        _buildMerchantButton(
                          context: context,
                          id: 1,
                          imagePath: 'assets/keells.jpeg',
                          url: 'https://example.com/merchant1',
                          viewModel: viewModel,
                          merchantName: 'Keells',
                        ),
                        _buildMerchantButton(
                          context: context,
                          id: 2,
                          imagePath: 'assets/foodCity.jpeg',
                          url: 'https://example.com/merchant2',
                          viewModel: viewModel,
                          merchantName: 'Food City',
                        ),
                        _buildMerchantButton(
                          context: context,
                          id: 3,
                          imagePath: 'assets/Damro.jpeg',
                          url: 'https://example.com/merchant3',
                          viewModel: viewModel,
                          merchantName: 'Damro',
                        ),
                        _buildMerchantButton(
                          context: context,
                          id: 4,
                          imagePath: 'assets/abans.jpeg',
                          url: 'https://buyabans.com/',
                          viewModel: viewModel,
                          merchantName: 'Abans',
                        ),
                        _buildMerchantButton(
                          context: context,
                          id: 5,
                          imagePath: 'assets/dlbSweep.jpeg',
                          url: 'https://epictechdev.com:50345',
                          viewModel: viewModel,
                          merchantName: 'DLB Sweep',
                        ),
                        _buildMerchantButton(
                          context: context,
                          id: 6,
                          imagePath: 'assets/iit.jpeg',
                          url: 'https://example.com/merchant6',
                          viewModel: viewModel,
                          merchantName: 'IIT',
                        ),
                        _buildMerchantButton(
                          context: context,
                          id: 7,
                          imagePath: 'assets/iit.jpeg',
                          url: 'https://example.com/merchant6',
                          viewModel: viewModel,
                          merchantName: 'IIT',
                        ),
                        _buildMerchantButton(
                          context: context,
                          id: 8,
                          imagePath: 'assets/foodCity.jpeg',
                          url: 'https://example.com/merchant2',
                          viewModel: viewModel,
                          merchantName: 'Food City',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // Image Slider
  Widget _buildSliderWithHeader() {
    final List<Map<String, String>> sliderItems = [
      {
        'title': '',
        'imageUrl': 'https://www.genie.lk/wp-content/uploads/2024/10/Dialog-in-app-biller-discount-for-any-Mastercardv2-1890x1100-1.jpg'
      },
      {
        'title': '',
        'imageUrl': 'https://www.genie.lk/wp-content/uploads/2025/01/Exclusive-25-Discount-1890x1100-1.jpg'
      },
      {
        'title': '',
        'imageUrl': 'https://www.genie.lk/wp-content/uploads/2023/11/genie-X-MasterCard-iPhone-15-Bonanza-1890x1100-2.jpg'
      },
    ];

    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 180.0,
            autoPlay: true,
            enlargeCenterPage: true,
          ),
          items: sliderItems.map((item) {
            return Stack(
              alignment: Alignment.bottomLeft,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(item['imageUrl']!, fit: BoxFit.cover, width: double.infinity),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.black54, Colors.transparent],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                  ),
                  child: Text(
                    item['title']!,
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }

  // Heading Tiles Section
  Widget _buildHeadingTiles() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildIconTile(Icons.payment, "Pay"),
          _buildIconTile(Icons.qr_code_scanner, "Scan QR"),
          _buildIconTile(Icons.send, "Send"),
          _buildIconTile(Icons.send_to_mobile, "Reload"),
        ],
      ),
    );
  }

  // Icon Tile Widget with Border and Border Radius
  Widget _buildIconTile(IconData icon, String title) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        // border: Border.all(color: Colors.black12, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.transparent,
            child: Icon(icon, size: 30, color: Colors.orangeAccent),
          ),
          SizedBox(height: 7),
          Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // Merchant Button Widget
  Widget _buildMerchantButton({
    required BuildContext context,
    required String imagePath,
    required String url,
    required int id,
    required MerchantViewmodel viewModel,
    required String merchantName,
  }) {
    return GestureDetector(
      onTap: () async {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('access_token');
        final pushId = prefs.getString('fcm_token');

        if (token == null || token.isEmpty) {
          _showUnauthorizedDialog(context);
          return;
        }

        if (id == 5) {
          await viewModel.handleSpecialMerchant(pushId!, token, context);
        } else {
          final uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          } else {
            print('Could not launch $url');
          }
        }
      },
      child: Container(
        width: 80, // Decreased width
        height: 140, // Increased height
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), // Rounded corners
          color: Colors.white, // Background color
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3), // Softer shadow color
              spreadRadius: 1, // Shadow spread
              blurRadius: 5, // Blur radius
              offset: Offset(0, 2), // Shadow position
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
          mainAxisSize: MainAxisSize.min, // Ensure the column takes only the space it needs
          children: [
            // Image section
            Container(
              width: 60, // Adjusted image width
              height: 60, // Adjusted image height
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath), // Merchant image
                  fit: BoxFit.cover, // Ensures the image fills the box
                ),
              ),
            ),
            SizedBox(height: 8), // Space between image and text
            // Text section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0), // Add horizontal padding
              child: Text(
                merchantName,
                style: TextStyle(
                  fontSize: 12, // Adjusted font size
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Text color
                ),
                textAlign: TextAlign.center,
                maxLines: 2, // Allow text to wrap to 2 lines
                overflow: TextOverflow.ellipsis, // Handle overflow
              ),
            ),
          ],
        ),
      ),
    );
  }





  // Unauthorized Dialog
  void _showUnauthorizedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Unauthorized Access'),
          content: const Text('Please log in to access this feature.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}