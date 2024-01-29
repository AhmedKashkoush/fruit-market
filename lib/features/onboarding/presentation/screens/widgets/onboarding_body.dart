import 'package:flutter/material.dart';
import 'package:fruit_market/config/routes/routes.dart';
import 'package:fruit_market/core/utils/app_navigator.dart';
import 'package:fruit_market/core/widgets/custom_elevated_button.dart';
import 'package:fruit_market/core/widgets/custom_text_button.dart';
import 'package:fruit_market/features/onboarding/presentation/screens/widgets/custom_page_indicator.dart';
import 'package:fruit_market/features/onboarding/presentation/screens/widgets/onboarding_page_view.dart';

class OnBoardingBody extends StatefulWidget {
  const OnBoardingBody({
    super.key,
  });

  @override
  State<OnBoardingBody> createState() => _OnBoardingBodyState();
}

class _OnBoardingBodyState extends State<OnBoardingBody> {
  final PageController _controller = PageController();
  bool _isLast = false;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(_postFrameCallback);
    super.initState();
  }

  void _postFrameCallback(_) {
    if (_controller.hasClients) {
      _controller.addListener(_pageListener);
    }
  }

  void _pageListener() {
    if (_controller.page! == 2 && !_isLast) {
      setState(() {
        _isLast = true;
      });
    } else {
      setState(() {
        _isLast = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: CustomTextButton(
                text: !_isLast ? 'Skip' : '',
                onPressed: !_isLast
                    ? () {
                        _animateToLast();
                      }
                    : null,
              ),
            ),
            const Spacer(
              flex: 2,
            ),
            Flexible(
              flex: 7,
              child: OnBoardingPageView(controller: _controller),
            ),
            // const Gap(50),
            const Spacer(),
            Align(
              alignment: Alignment.center,
              child: CustomPageIndicator(
                controller: _controller,
                onDotClicked: _animateToPage,
              ),
            ),
            const Spacer(
              flex: 2,
            ),
            Align(
              alignment: Alignment.center,
              child: CustomElevatedButton(
                onPressed: () {
                  if (!_isLast) {
                    _animateToNext();
                  } else {
                    _goToLogin(context);
                  }
                },
                text: !_isLast ? 'Next' : 'Get Started',
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  void _goToLogin(BuildContext context) {
    pushReplacementNamed(AppRoutes.login, context);
  }

  void _animateToNext() {
    if (!_isLast) {
      _controller.animateToPage(
        _controller.page!.round() + 1,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOut,
      );
    }
  }

  void _animateToLast() {
    if (_controller.hasClients) {
      if (!_isLast) {
        _controller.animateToPage(
          3,
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  void _animateToPage(int page) {
    if (_controller.hasClients) {
      _controller.animateToPage(
        page,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOut,
      );
    }
  }
}
