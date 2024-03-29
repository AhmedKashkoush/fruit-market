import 'package:flutter/material.dart';

class TimerText extends StatelessWidget {
  final int seconds;
  const TimerText({
    super.key,
    required this.seconds,
  });

  @override
  Widget build(BuildContext context) {
    return Text('Resend code in ${seconds.toString().padLeft(2, '0')} seconds');
  }
}
