import 'package:flutter/material.dart';
import 'package:fruit_market/features/auth/presentation/screens/choose%20location%20manually/widgets/empty_map_widget.dart';

class MapViewWidget extends StatelessWidget {
  const MapViewWidget({
    super.key,
    required ValueNotifier<String> coordinates,
    required TextEditingController latController,
    required TextEditingController lngController,
  })  : _coordinates = coordinates,
        _latController = latController,
        _lngController = lngController;

  final ValueNotifier<String> _coordinates;
  final TextEditingController _latController;
  final TextEditingController _lngController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ValueListenableBuilder(
          valueListenable: _coordinates,
          builder: (context, _, __) {
            return _latController.text.isNotEmpty &&
                    _lngController.text.isNotEmpty
                ? const EmptyMapWidget()
                // GMapsWebView(
                //     lat: _latController.text,
                //     lng: _lngController.text,
                //   )
                : const EmptyMapWidget();
          }),
    );
  }
}
