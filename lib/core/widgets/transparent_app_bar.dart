import 'package:flutter/material.dart';

class TransparentAppBar extends AppBar {
  final String? titleText;
  TransparentAppBar({super.key, this.titleText});

  Widget build(BuildContext context) {
    return AppBar(
      title: titleText != null ? Text(titleText!) : null,
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}
