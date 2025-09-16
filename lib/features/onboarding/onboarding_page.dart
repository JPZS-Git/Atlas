import 'package:flutter/material.dart';

import 'pages/how_it_works_ob_page.dart';
import 'pages/welcome_ob_page.dart';

class OnboardingPage extends StatefulWidget {
  static const routeName = '/onboarding';

  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _pageController = PageController();
  int _currentPage = 0;

  final List<Widget> pages = const [
    WellcomeOBPage(),
    HowItWorksOBPage(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  bool get isLastPage => _currentPage == pages.length - 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: pages.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return AnimatedBuilder(
                animation: _pageController,
                builder: (context, child) {
                  double value = 1.0;
                  if (_pageController.position.haveDimensions) {
                    value = _pageController.page! - index;
                    value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
                  } else if (index == 0) {
                    value = 1.0;
                  } else {
                    value = 0.7;
                  }

                  return Transform.scale(
                    scale: value,
                    child: Opacity(
                      opacity: value,
                      child: pages[index],
                    ),
                  );
                },
              );
            },
          ),

          Positioned(
            bottom: 24,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pages.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  width: _currentPage == index ? 14 : 10,
                  height: _currentPage == index ? 14 : 10,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? const Color(0xFF26A69A)
                        : Colors.white38,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),

          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (_currentPage != 0)
                      IconButton(
                        onPressed: () {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        icon: const Icon(Icons.arrow_back_ios,
                            size: 40, 
                            color: Color(0xFF26A69A)),
                      )
                    else
                      const SizedBox(width: 36),

                    if (!isLastPage)
                      IconButton(
                        onPressed: () {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        icon: const Icon(Icons.arrow_forward_ios,
                            size: 40, 
                            color: Color(0xFF26A69A)),
                      )
                    else
                      const SizedBox(width: 36),
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