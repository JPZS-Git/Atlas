import 'package:flutter/material.dart';

class DotsIndicator extends StatelessWidget {
  final int totalDots;
  final int currentIndex;
  final Color activeColor;
  final Color inactiveColor;

  const DotsIndicator({
    super.key,
    required this.totalDots,
    required this.currentIndex,
    this.activeColor = const Color(0xFF26A69A),
    this.inactiveColor = Colors.white38,
  });

  Widget _buildDot({required bool isActive}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 6),
      width: isActive ? 14 : 10,
      height: isActive ? 14 : 10,
      decoration: BoxDecoration(
        color: isActive ? activeColor : inactiveColor,
        shape: BoxShape.circle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        totalDots,
        (index) => _buildDot(isActive: index == currentIndex),
      ),
    );
  }
}