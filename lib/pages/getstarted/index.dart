import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:mr_chicken_x/constants/index.dart';
import 'package:mr_chicken_x/navigation/app_navigation.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> _titles = [
    "Welcome to Mr. ChickenX",
    "Manage Your Poultry Efficiently",
    "Track & Analyze with Ease"
  ];

  final List<String> _subtitles = [
    "Your one-stop app for poultry management.",
    "Organize, feed, and care for your poultry.",
    "Detailed reports to improve productivity."
  ];

  final List<String> _images = [
    'assets/images/chicken.png', // Add corresponding image assets
    'assets/images/chicken.png',
    'assets/images/chicken.png'
  ];

  void _navigateToLogin() {
    context.go(NAVIGATION.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 0,
        backgroundColor: Theme.of(context).colors.lemon,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarColor: Theme.of(context).colors.lemon,
        ),
      ),
      body: Column(
        children: [
          // PageView Section
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: _titles.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Image.asset(
                          _images[index],
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        _titles[index],
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colors.persianred,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 15),
                      Text(
                        _subtitles[index],
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Page Indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _titles.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 5),
                width: _currentPage == index ? 12 : 8,
                height: _currentPage == index ? 12 : 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentPage == index
                      ? Theme.of(context).colors.persianred
                      : Colors.grey,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Button Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Skip Button
                TextButton(
                  onPressed: _navigateToLogin,
                  child: Text(
                    "Skip",
                    style: TextStyle(
                      color: Theme.of(context).colors.persianred,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // Next/Login Button
                ElevatedButton(
                  onPressed: () {
                    if (_currentPage == _titles.length - 1) {
                      _navigateToLogin();
                    } else {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colors.persianred,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    _currentPage == _titles.length - 1 ? "Login" : "Next",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}