// ignore_for_file: avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:fruit_market/core/constants/links.dart';

class GMapsWebView extends StatefulWidget {
  final String lat, lng;
  const GMapsWebView({
    super.key,
    required this.lat,
    required this.lng,
  });

  @override
  State<GMapsWebView> createState() => _GMapsWebViewState();
}

class _GMapsWebViewState extends State<GMapsWebView> {
  final WebViewController controller = WebViewController();
  @override
  void initState() {
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
        Uri.parse(
            '$googleMapsLinkSearchBase/?api=1&query=${widget.lat},${widget.lng}'),
      );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(
      controller: controller,
    );
  }
}
