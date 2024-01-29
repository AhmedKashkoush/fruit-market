import 'package:flutter/material.dart';
import 'package:fruit_market/core/constants/images.dart';

class BgWidget extends StatefulWidget {
  const BgWidget({
    super.key,
  });

  @override
  State<BgWidget> createState() => _BgWidgetState();
}

class _BgWidgetState extends State<BgWidget> {
  late final Image _image = Image.asset(
      splashBg,
      fit: BoxFit.cover,
    );
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(_precache);
    super.initState();
  }

  void _precache(timeStamp) async {
    await precacheImage(_image.image, context);
  }

  @override
  Widget build(BuildContext context) {
    return _image;
  }
}
