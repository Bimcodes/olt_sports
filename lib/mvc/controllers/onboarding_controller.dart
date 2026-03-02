import 'package:flutter/material.dart';

import '../models/onboarding_item.dart';

class OnboardingController extends ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  final PageController pageController = PageController();

  final List<OnboardingItem> items = [
    OnboardingItem(
      title: 'Welcome to OLT SPORTS!',
      description:
          'Your ultimate destination for sports streaming, news and merchandise.',
      imagePlaceholder: 'Image 1: Fan with hands up',
    ),
    OnboardingItem(
      title: 'Stay ahead of the game..',
      description: 'Get the latest sports news, updates, and analysis',
      imagePlaceholder: 'Image 2: Laptops analysis',
    ),
    OnboardingItem(
      title: 'Wear your team pride',
      description: 'Shop official jerseys, merchandise, and more...',
      imagePlaceholder: 'Image 3: Green tribal jersey',
    ),
    OnboardingItem(
      title: 'Wear your team pride',
      description: 'Shop official jerseys, merchandise, and more...',
      imagePlaceholder: 'Image 4: Blue jersey hanging',
    ),
  ];

  void onPageChanged(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void next() {
    if (_currentIndex < items.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  void skip() {
    pageController.animateToPage(
      items.length - 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
