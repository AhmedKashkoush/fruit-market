import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fruit_market/features/auth/data/data%20sources/remote/auth_remote_data_source.dart';
import 'package:fruit_market/features/auth/data/repositories/auth_repository.dart';
import 'package:fruit_market/features/auth/domain/repositories/base_auth_repository.dart';
import 'package:fruit_market/features/auth/domain/usecases/login_usecase.dart';
import 'package:fruit_market/features/auth/domain/usecases/logout_usecase.dart';
import 'package:fruit_market/features/auth/domain/usecases/sign_in_with_facebook_usecase.dart';
import 'package:fruit_market/features/auth/domain/usecases/sign_in_with_google_usecase.dart';
import 'package:fruit_market/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:fruit_market/features/auth/presentation/screens/login/bloc/login_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GetIt sl = GetIt.instance;

void initLocator() {
  ///Blocs
  sl.registerFactory<LoginBloc>(
    () => LoginBloc(
      sl<LoginUseCase>(),
      sl<SignInWithGoogleUseCase>(),
      sl<SignInWithFacebookUseCase>(),
    ),
  );

  ///UseCases
  sl.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(
      sl<BaseAuthRepository>(),
    ),
  );
  sl.registerLazySingleton<SignUpUseCase>(
    () => SignUpUseCase(
      sl<BaseAuthRepository>(),
    ),
  );

  sl.registerLazySingleton<SignInWithGoogleUseCase>(
    () => SignInWithGoogleUseCase(
      sl<BaseAuthRepository>(),
    ),
  );
  sl.registerLazySingleton<SignInWithFacebookUseCase>(
    () => SignInWithFacebookUseCase(
      sl<BaseAuthRepository>(),
    ),
  );

  sl.registerLazySingleton<LogoutUseCase>(
    () => LogoutUseCase(
      sl<BaseAuthRepository>(),
    ),
  );

  ///Repositories
  sl.registerLazySingleton<BaseAuthRepository>(
    () => AuthRepository(
      sl<BaseAuthRemoteDataSource>(),
    ),
  );

  ///Remote Data Sources
  sl.registerLazySingleton<BaseAuthRemoteDataSource>(
    () => AuthRemoteDataSource(sl<FirebaseAuth>(), sl<FirebaseFirestore>(),
        sl<GoogleSignIn>(), sl<FacebookAuth>(), sl<Connectivity>()),
  );

  //External
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  sl.registerLazySingleton<GoogleSignIn>(
    () => GoogleSignIn(),
  );
  sl.registerLazySingleton<FacebookAuth>(() => FacebookAuth.instance);
  sl.registerLazySingleton<Connectivity>(
    () => Connectivity(),
  );
}
