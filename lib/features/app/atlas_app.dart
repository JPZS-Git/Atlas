import 'package:flutter/material.dart';

import '../home/home_page.dart';
import '../onboarding/onboarding_page.dart';
import '../splashscreen/splashscreen_page.dart';

class AtlasApp extends StatelessWidget {
  const AtlasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Atlas',
      theme: ThemeData(
        useMaterial3: true,
        materialTapTargetSize: MaterialTapTargetSize.padded,
        visualDensity: VisualDensity.standard,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routes: {
        '/': (context) => const SplashScreenPage(),
        OnboardingPage.routeName: (context) => const OnboardingPage(),
        HomePage.routeName: (context) => const HomePage(title: 'Atlas'),
      },
      // home: const SplashScreenPage(),
    );
  }
}