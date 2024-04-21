import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_market/config/locales/locales.dart';
import 'package:fruit_market/config/locales/translations.dart';
import 'package:fruit_market/config/routes/router.dart';
import 'package:fruit_market/config/themes/cubit/theme_cubit.dart';
import 'package:fruit_market/config/themes/themes.dart';
import 'package:fruit_market/core/constants/texts.dart';
import 'package:fruit_market/core/utils/locator.dart';
import 'package:fruit_market/core/utils/services.dart';
import 'package:fruit_market/features/auth/presentation/screens/login/bloc/login_bloc.dart';
import 'package:fruit_market/features/auth/presentation/screens/signup/bloc/signup_bloc.dart';
import 'package:fruit_market/features/auth/presentation/screens/verification/email/bloc/password_reset_email_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: supportedLocales,
      fallbackLocale: supportedLocales.first,
      saveLocale: true,
      path: Translations.path,
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: sl<ThemeCubit>(),
          ),
          BlocProvider.value(
            value: sl<LoginBloc>(),
          ),
          BlocProvider.value(
            value: sl<SignUpBloc>(),
          ),
          BlocProvider.value(
            value: sl<PasswordResetEmailBloc>(),
          ),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: appName,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: context.read<ThemeCubit>().getThemeMode(),
          locale: context.locale,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          routerConfig: router,
        ),
      ),
    );
  }
}
