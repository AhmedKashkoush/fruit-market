import 'package:flutter/material.dart';
import 'package:fruit_market/core/widgets/custom_elevated_button.dart';
import 'package:fruit_market/core/widgets/custom_text_button.dart';
import 'package:fruit_market/features/onboarding/presentation/screens/widgets/custom_page_indicator.dart';
import 'package:fruit_market/features/onboarding/presentation/screens/widgets/onboarding_page_view.dart';

class OnBoardingBodyLandscape extends StatelessWidget {
  final void Function(int) animateToPage;
  final void Function() animateToLast;
  final void Function() animateToNext;
  final void Function(BuildContext) goToLogin;
  const OnBoardingBodyLandscape({
    super.key,
    required ValueNotifier<bool> isLast,
    required PageController controller,
    required this.animateToPage,
    required this.animateToLast,
    required this.animateToNext,
    required this.goToLogin,
  })  : _isLast = isLast,
        _controller = controller;

  final ValueNotifier<bool> _isLast;
  final PageController _controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
          alignment: AlignmentDirectional.centerEnd,
          child: ValueListenableBuilder<bool>(
            valueListenable: _isLast,
            builder: (context, isLast, _) {
              return CustomTextButton(
                text: !isLast ? 'Skip' : '',
                onPressed: !isLast
                    ? () {
                        animateToLast();
                      }
                    : null,
              );
            },
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
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Center(
                child: CustomPageIndicator(
                  controller: _controller,
                  onDotClicked: animateToPage,
                ),
              ),
            ),
            Expanded(
              child: ValueListenableBuilder(
                  valueListenable: _isLast,
                  builder: (context, isLast, _) {
                    return CustomElevatedButton(
                      onPressed: () {
                        if (!isLast) {
                          animateToNext();
                        } else {
                          goToLogin(context);
                        }
                      },
                      text: !isLast ? 'Next' : 'Get Started',
                    );
                  }),
            ),
          ],
        ),
      ],
    );
  }
}
