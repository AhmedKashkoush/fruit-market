import 'package:flutter/material.dart';
import 'package:fruit_market/core/widgets/texts/title_widget.dart';
import 'package:fruit_market/features/splash/presentation/screens/splash/widgets/bg_widget.dart';

class SplashBody extends StatelessWidget {
  const SplashBody({
    super.key,
    required Animation<double> animation,
  }) : _animation = animation;

  final Animation<double> _animation;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(flex: 2),
          FadeTransition(
            opacity: _animation,
            child: const TitleWidget(),
          ),
          const Spacer(),
          const Expanded(
            child: BgWidget(),
          ),
        ],
      ),
    );
  }
}
