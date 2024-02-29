import 'package:flutter/material.dart';
import 'package:fruit_market/config/routes/routes.dart';
import 'package:fruit_market/core/constants/preferences_keys.dart';
import 'package:fruit_market/core/helpers/shared_preferences_helper.dart';
import 'package:fruit_market/core/utils/app_navigator.dart';
import 'package:fruit_market/core/widgets/orientation_widget.dart';
import 'package:fruit_market/features/onboarding/presentation/screens/widgets/onboarding_body_landscape.dart';
import 'package:fruit_market/features/onboarding/presentation/screens/widgets/onboarding_body_portrait.dart';

class OnBoardingBody extends StatefulWidget {
  const OnBoardingBody({
    super.key,
  });

  @override
  State<OnBoardingBody> createState() => _OnBoardingBodyState();
}

class _OnBoardingBodyState extends State<OnBoardingBody> {
  final PageController _controller = PageController();
  final ValueNotifier<bool> _isLast = ValueNotifier<bool>(false);
  final SharedPreferecesHelper _helper = SharedPreferecesHelper();
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
    if (_controller.page! == 2 && !_isLast.value) {
      _isLast.value = true;
    } else {
      _isLast.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: OrientationWidget(
          portrait: OnBoardingBodyPortrait(
            isLast: _isLast,
            controller: _controller,
            animateToPage: _animateToPage,
            animateToLast: _animateToLast,
            animateToNext: _animateToNext,
            goToLogin: _goToLogin,
          ),
          landscape: OnBoardingBodyLandscape(
            isLast: _isLast,
            controller: _controller,
            animateToPage: _animateToPage,
            animateToLast: _animateToLast,
            animateToNext: _animateToNext,
            goToLogin: _goToLogin,
          ),
        ),
      ),
    );
  }

  void _goToLogin(BuildContext context) async {
    _helper.write<bool>(PreferencesKeys.shownOnboarding, true);
    pushReplacementNamed(AppRoutes.login, context);
  }

  void _animateToNext() {
    if (!_isLast.value) {
      _controller.animateToPage(
        _controller.page!.round() + 1,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOut,
      );
    }
  }

  void _animateToLast() {
    if (_controller.hasClients) {
      if (!_isLast.value) {
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
