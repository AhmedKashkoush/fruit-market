import 'package:flutter/material.dart';
import 'package:fruit_market/core/constants/images.dart';
import 'package:fruit_market/features/onboarding/presentation/screens/widgets/onboarding_view.dart';

class OnBoardingPageView extends StatelessWidget {
  const OnBoardingPageView({
    super.key,
    required PageController controller,
  }) : _controller = controller;

  final PageController _controller;

  @override
  Widget build(BuildContext context) {
    return PageView(
      scrollDirection: Axis.horizontal,
      controller: _controller,
      children: const [
        OnBoardingView(
          image: onBoarding1,
          title: 'E Shopping',
          body: 'Explore top organic fruits & grab them',
        ),
        OnBoardingView(
          image: onBoarding2,
          title: 'Delivery on the way',
          body: 'Get your order by speed delivery',
        ),
        OnBoardingView(
          image: onBoarding3,
          title: 'Delivery Arrived',
          body: 'Order is arrived at your Place',
        ),
      ],
    );
  }
}
