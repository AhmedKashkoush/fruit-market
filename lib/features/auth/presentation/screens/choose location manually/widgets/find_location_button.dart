import 'package:flutter/cupertino.dart';
import 'package:fruit_market/core/widgets/buttons/custom_outlined_button.dart';

class FindLocationButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController latController, lngController;
  final ValueNotifier<String> coordinates;
  const FindLocationButton({
    super.key,
    required this.formKey,
    required this.latController,
    required this.lngController,
    required this.coordinates,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: CustomOutlinedButton(
        text: 'Find location',
        icon: CupertinoIcons.location_solid,
        onPressed: _findLocation,
      ),
    );
  }

  void _findLocation() {
    final bool isValid = formKey.currentState!.validate();
    if (!isValid) return;
    coordinates.value = '${latController.text},${lngController.text}';
  }
}
