import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fruit_market/core/widgets/inputs/custom_text_field.dart';
import 'package:fruit_market/core/widgets/texts/label_widget.dart';
import 'package:gap/gap.dart';

class LatLngFormField extends StatelessWidget {
  const LatLngFormField({
    super.key,
    required TextEditingController latController,
    required TextEditingController lngController,
  })  : _latController = latController,
        _lngController = lngController;

  final TextEditingController _latController;
  final TextEditingController _lngController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const LabelWidget(label: 'Latitude'),
              const Gap(2),
              CustomTextField(
                controller: _latController,
                validator: _validator,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
            ],
          ),
        ),
        const Gap(4),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const LabelWidget(label: 'Longitude'),
              const Gap(2),
              CustomTextField(
                controller: _lngController,
                validator: _validator,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  String? _validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field required';
    }
    return null;
  }
}
