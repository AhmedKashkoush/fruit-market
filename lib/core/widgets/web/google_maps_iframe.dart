// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html';
import 'dart:ui_web' as ui;

import 'package:flutter/material.dart';
import 'package:fruit_market/core/constants/links.dart';

class GMapsIframe extends StatefulWidget {
  final String lat, lng;
  const GMapsIframe({
    super.key,
    required this.lat,
    required this.lng,
  });

  @override
  State<GMapsIframe> createState() => _GMapsIframeState();
}

class _GMapsIframeState extends State<GMapsIframe> {
  final IFrameElement iframeElement = IFrameElement();
  @override
  void initState() {
    iframeElement
      ..height = '100%'
      ..width = '100%'
      ..src =
          '$googleMapsLinkWebBase?q=${widget.lat},${widget.lng}&z=18&output=embed'
      ..style.border = 'none';
    ui.platformViewRegistry.registerViewFactory(
      '$googleMapsLinkWebBase?q=${widget.lat},${widget.lng}&z=18&output=embed',
      (_) => iframeElement,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HtmlElementView(
        viewType:
            '$googleMapsLinkWebBase?q=${widget.lat},${widget.lng}&z=18&output=embed');
  }
}
