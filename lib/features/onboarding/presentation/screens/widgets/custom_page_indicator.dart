import 'package:flutter/material.dart';
import 'package:fruit_market/core/constants/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomPageIndicator extends StatelessWidget {
  final void Function(int)? onDotClicked;
  const CustomPageIndicator({
    super.key,
    required PageController controller,
    this.onDotClicked,
  }) : _controller = controller;

  final PageController _controller;

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: _controller,
      effect: const CustomizableEffect(
        dotDecoration: DotDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(
            Radius.circular(40),
          ),
          dotBorder: DotBorder(
            color: primary,
            type: DotBorderType.solid,
          ),
        ),
        activeDotDecoration: DotDecoration(
          color: primary,
          borderRadius: BorderRadius.all(
            Radius.circular(40),
          ),
          dotBorder: DotBorder(
            color: primary,
            type: DotBorderType.solid,
          ),
        ),
      ),
      onDotClicked: onDotClicked,
      count: 3,
    );
  }
}
