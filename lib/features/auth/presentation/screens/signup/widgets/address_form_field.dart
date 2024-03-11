import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fruit_market/config/routes/routes.dart';
import 'package:fruit_market/core/utils/app_navigator.dart';
import 'package:fruit_market/core/utils/enums.dart';
import 'package:fruit_market/core/utils/location.dart';
import 'package:fruit_market/core/utils/snack_messages.dart';
import 'package:fruit_market/core/widgets/buttons/custom_outlined_button.dart';
import 'package:fruit_market/core/widgets/inputs/custom_text_field.dart';
import 'package:fruit_market/core/widgets/texts/label_widget.dart';
import 'package:gap/gap.dart';
import 'package:geocoding/geocoding.dart';

class AddressFormField extends StatelessWidget {
  final TextEditingController _countryController,
      _governorateController,
      _cityController,
      _streetController;

  final ValueNotifier<bool> isExpanded;
  const AddressFormField({
    super.key,
    required TextEditingController countryController,
    required TextEditingController governorateController,
    required TextEditingController cityController,
    required TextEditingController streetController,
    required this.isExpanded,
  })  : _countryController = countryController,
        _governorateController = governorateController,
        _cityController = cityController,
        _streetController = streetController;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text('Address'),
      expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      initiallyExpanded: isExpanded.value,
      onExpansionChanged: _onExpansionChanged,
      children: [
        Row(
          children: [
            Expanded(
              child: CustomOutlinedButton(
                text: 'Add address based on your location',
                icon: CupertinoIcons.location,
                onPressed: () => _addAddressFromLocation(context),
              ),
            ),
            const Gap(4),
            Expanded(
              child: CustomOutlinedButton(
                text: 'Add address from custom location',
                icon: CupertinoIcons.location_solid,
                onPressed: () => _goToChooseLocation(context),
              ),
            ),
          ],
        ),
        const Gap(10),
        Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const LabelWidget(label: 'Country'),
                  const Gap(2),
                  CustomTextField(
                    controller: _countryController,
                    validator: _fieldValidation,
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
                  const LabelWidget(label: 'Governorate'),
                  const Gap(2),
                  CustomTextField(
                    controller: _governorateController,
                    validator: _fieldValidation,
                  ),
                ],
              ),
            ),
          ],
        ),
        const Gap(10),
        const LabelWidget(label: 'City'),
        const Gap(2),
        CustomTextField(
          controller: _cityController,
          validator: _fieldValidation,
        ),
        const Gap(10),
        const LabelWidget(label: 'Street'),
        const Gap(2),
        CustomTextField(
          controller: _streetController,
          validator: _fieldValidation,
        ),
        const Gap(10),
      ],
    );
  }

  String? _fieldValidation(String? value) {
    if (value == null || value.isEmpty) return 'Field required';
    return null;
  }

  void _addAddressFromLocation(BuildContext context) async {
    final Either<String, Placemark> result =
        await getAddressFromCurrentLocation();
    result.fold(
      (error) =>
          showErrorSnackBar(context, error, errorType: ErrorType.location),
      (address) => debugPrint(
        address.toString(),
      ),
    );
  }

  void _goToChooseLocation(BuildContext context) {
    pushNamed(AppRoutes.chooseLocation, context);
  }

  void _onExpansionChanged(bool value) {
    isExpanded.value = value;
  }
}
