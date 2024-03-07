import 'package:flutter/material.dart';
import 'package:fruit_market/core/constants/colors.dart';

class CustomeSelectableListTile<T> extends StatelessWidget {
  final T groupValue, value;
  final IconData icon;
  final String label;
  final void Function(T?)? onChanged;

  const CustomeSelectableListTile({
    super.key,
    required this.groupValue,
    required this.value,
    required this.icon,
    required this.label,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return RadioListTile<T>.adaptive(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      tileColor: lighterGrey.withOpacity(0.3),
      controlAffinity: ListTileControlAffinity.trailing,
      secondary: Icon(
        icon,
        color: groupValue == value ? primary : null,
      ),
      selectedTileColor: primary.withOpacity(0.5),
      selected: groupValue == value,
      title: Text(
        label,
        style: TextStyle(
          color: groupValue == value ? primary : null,
        ),
      ),
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
    );
  }
}
