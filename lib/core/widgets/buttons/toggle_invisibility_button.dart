import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ToggleInVisibilityButton extends StatelessWidget {
  const ToggleInVisibilityButton({
    super.key,
    required this.toggleInvisibility,
    required bool isShown,
  }) : _isShown = isShown;

  final void Function()? toggleInvisibility;
  final bool _isShown;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: toggleInvisibility,
      icon: _isShown
          ? const Icon(CupertinoIcons.eye_slash_fill)
          : const Icon(CupertinoIcons.eye_fill),
    );
  }
}
