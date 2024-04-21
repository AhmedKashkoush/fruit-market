import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_market/core/helpers/shared_preferences_helper.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final SharedPreferencesHelper sharedPreferencesHelper;
  ThemeCubit(this.sharedPreferencesHelper) : super(ThemeMode.system);

  void changeTheme(ThemeMode themeMode) {
    emit(themeMode);
    sharedPreferencesHelper.write<String>('themeMode', themeMode.name);
  }

  ThemeMode getThemeMode() {
    final String? themeMode =
        (sharedPreferencesHelper.read<String>('themeMode')) as String?;
    if (themeMode != null) {
      return ThemeMode.values.where((mode) => themeMode == mode.name).first;
    }
    return ThemeMode.system;
  }
}
