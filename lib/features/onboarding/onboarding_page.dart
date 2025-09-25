import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/how_it_works_ob_page.dart';
import 'pages/welcome_ob_page.dart';
import 'pages/consent_page.dart';
import 'pages/go_to_access_page_ob_page.dart';
import 'widgets/dots_indicator.dart';

class OnboardingPage extends StatefulWidget {
  static const routeName = '/onboarding';

  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _totalPagesInOBPage = 4;
  final _consentPageIndex = 2;

  final _pageController = PageController();
  int _currentPage = 0;

  late final List<Widget> pages;

  @override
  void initState() {
    super.initState();
    pages = [
      const WellcomeOBPage(),
      const HowItWorksOBPage(),
      ConsentPageOBPage(onConsentGiven: _onConsentGiven),
      const GoToAccessPage(),
    ];

    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  bool get isLastPage => _currentPage >= _consentPageIndex;
  bool get isFirstPage => _currentPage == 0;

  _onConsentGiven() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboardingComplete', true);

    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            physics: _currentPage >= _consentPageIndex
                ? const NeverScrollableScrollPhysics()
                : const ClampingScrollPhysics(),
            children: pages,
          ),

          Positioned(
            bottom: 24,
            left: 0,
            right: 0,
            child: Visibility(
              visible: _currentPage < (_totalPagesInOBPage - 1),
              child: DotsIndicator(
                totalDots: _totalPagesInOBPage,
                currentIndex: _currentPage,
              ),
            ),
          ),

          if (!isLastPage)
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 40.0, right: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    _pageController.jumpToPage(_consentPageIndex);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF26A69A),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                  ),
                  child: const Text(
                    'Pular',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    
                    Visibility(
                      visible: !isFirstPage && _currentPage < (_totalPagesInOBPage - 1),
                      child: IconButton(
                        onPressed: () {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        icon: const Icon(Icons.arrow_back_ios,
                            size: 40, color: Color(0xFF26A69A)),
                      ),
                    ),

                    if (isFirstPage) const SizedBox(width: 36),

                    Visibility(
                      visible: _currentPage < _consentPageIndex,
                      child: IconButton(
                        onPressed: () {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        icon: const Icon(Icons.arrow_forward_ios,
                            size: 40, color: Color(0xFF26A69A)),
                      ),
                    ),

                    if (isLastPage) const SizedBox(width: 36),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}