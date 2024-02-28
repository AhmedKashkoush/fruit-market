import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_market/config/routes/router.dart';
import 'package:fruit_market/config/themes/themes.dart';
import 'package:fruit_market/core/constants/texts.dart';
import 'package:fruit_market/core/utils/locator.dart';
import 'package:fruit_market/core/utils/services.dart';
import 'package:fruit_market/features/auth/presentation/screens/login/bloc/login_bloc.dart';
import 'package:fruit_market/features/auth/presentation/screens/signup/bloc/signup_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (_) => sl<LoginBloc>(),
        ),
        BlocProvider<SignUpBloc>(
          create: (_) => sl<SignUpBloc>(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: appName,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: themeMode,
        routerConfig: router,
      ),
    );
  }
}
