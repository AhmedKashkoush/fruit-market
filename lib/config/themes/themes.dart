import 'package:flutter/material.dart';
import 'package:fruit_market/core/constants/colors.dart';

final ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: primary),
  splashFactory: InkRipple.splashFactory,
  highlightColor: Colors.transparent,
  useMaterial3: true,
  fontFamily: 'Poppins',
);

final ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: primary,  brightness: Brightness.dark,),
  splashFactory: InkRipple.splashFactory,
  highlightColor: Colors.transparent,
  useMaterial3: true,
  fontFamily: 'Poppins',
);
