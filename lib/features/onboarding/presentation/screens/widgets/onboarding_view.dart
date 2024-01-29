import 'package:flutter/material.dart';
import 'package:fruit_market/core/constants/colors.dart';
import 'package:gap/gap.dart';

class OnBoardingView extends StatefulWidget {
  final String image, title, body;
  const OnBoardingView({
    super.key,
    required this.image,
    required this.title,
    required this.body,
  });

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  late final Image _image = Image.asset(
    widget.image,
    height: 200,
  );

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await precacheImage(_image.image, context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: _image,
        ),
        const Gap(40),
        Text(
          widget.title,
          style: const TextStyle(fontSize: 18),
        ),
        const Gap(20),
        Text(
          widget.body,
          style: const TextStyle(
            fontSize: 14,
            color: lighterGrey,
          ),
        ),
      ],
    );
  }
}
