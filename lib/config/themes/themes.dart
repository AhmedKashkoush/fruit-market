import 'package:flutter/material.dart';
import 'package:fruit_market/core/constants/colors.dart';

final ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: primary),
  useMaterial3: true,
  fontFamily: 'Poppins',
);

final ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: primary,  brightness: Brightness.dark,),
  useMaterial3: true,
  fontFamily: 'Poppins',
);

ThemeMode themeMode = ThemeMode.system;
