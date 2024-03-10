import 'package:flutter/material.dart';
import 'package:fruit_market/core/utils/enums.dart';
import 'package:fruit_market/core/widgets/buttons/custom_selectable_list_title.dart';
import 'package:gap/gap.dart';

class GenderFormField extends StatelessWidget {
  const GenderFormField({
    super.key,
    required ValueNotifier<GenderType?> gender,
  }) : _gender = gender;

  final ValueNotifier<GenderType?> _gender;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _gender,
        builder: (context, value, _) {
          return Row(
            children: [
              Expanded(
                child: CustomeSelectableListTile<GenderType?>(
                  groupValue: value,
                  value: GenderType.male,
                  icon: Icons.male_rounded,
                  label: 'Male',
                  onChanged: _onGenderChanged,
                ),
              ),
              const Gap(4),
              Expanded(
                child: CustomeSelectableListTile<GenderType?>(
                  groupValue: value,
                  value: GenderType.female,
                  icon: Icons.female_rounded,
                  label: 'Female',
                  onChanged: _onGenderChanged,
                ),
              ),
            ],
          );
        });
  }

  void _onGenderChanged(GenderType? gender) {
    _gender.value = gender;
  }
}
