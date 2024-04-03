import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fruit_market/core/constants/api_keys.dart';
import 'package:fruit_market/core/constants/hive_boxes.dart';
import 'package:fruit_market/features/auth/data/data%20sources/remote/auth_remote_data_source.dart';
import 'package:fruit_market/features/auth/data/repositories/auth_repository.dart';
import 'package:fruit_market/features/auth/domain/repositories/base_auth_repository.dart';
import 'package:fruit_market/features/auth/domain/usecases/login_usecase.dart';
import 'package:fruit_market/features/auth/domain/usecases/logout_usecase.dart';
import 'package:fruit_market/features/auth/domain/usecases/send_email_verification_usecase.dart';
import 'package:fruit_market/features/auth/domain/usecases/send_password_reset_email_usecase.dart';
import 'package:fruit_market/features/auth/domain/usecases/send_phone_verification_usecase.dart';
import 'package:fruit_market/features/auth/domain/usecases/sign_in_with_facebook_usecase.dart';
import 'package:fruit_market/features/auth/domain/usecases/sign_in_with_google_usecase.dart';
import 'package:fruit_market/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:fruit_market/features/auth/domain/usecases/verify_phone_usecase.dart';
import 'package:fruit_market/features/auth/presentation/screens/forgot%20password/phone%20input/bloc/phone_input_bloc.dart';
import 'package:fruit_market/features/auth/presentation/screens/login/bloc/login_bloc.dart';
import 'package:fruit_market/features/auth/presentation/screens/signup/bloc/signup_bloc.dart';
import 'package:fruit_market/features/auth/presentation/screens/verification/email/bloc/password_reset_email_bloc.dart';
import 'package:fruit_market/features/auth/presentation/screens/verification/phone/bloc/phone_verification_bloc.dart';
import 'package:fruit_market/features/products/data/data%20sources/local/products_local_data_source.dart';
import 'package:fruit_market/features/products/data/data%20sources/remote/products_remote_data_source.dart';
import 'package:fruit_market/features/products/data/models/category_model.dart';
import 'package:fruit_market/features/products/data/models/product_model.dart';
import 'package:fruit_market/features/products/data/models/sub_category_model.dart';
import 'package:fruit_market/features/products/data/repositories/products_repository.dart';
import 'package:fruit_market/features/products/domain/repositories/base_products_repository.dart';
import 'package:fruit_market/features/products/domain/usecases/add_to_cart_usecase.dart';
import 'package:fruit_market/features/products/domain/usecases/add_to_favourites_usecase.dart';
import 'package:fruit_market/features/products/domain/usecases/get_all_categories_usecase.dart';
import 'package:fruit_market/features/products/domain/usecases/get_all_products_in_category_usecase.dart';
import 'package:fruit_market/features/products/domain/usecases/get_all_sub_categories_in_category_usecase.dart';
import 'package:fruit_market/features/products/domain/usecases/remove_from_cart_usecase.dart';
import 'package:fruit_market/features/products/domain/usecases/remove_from_favourites_usecase.dart';
import 'package:fruit_market/features/products/domain/usecases/search_products_by_query_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt sl = GetIt.instance;

Future<void> initLocator() async {
  
  ///Blocs
  _initBlocs();

  ///UseCases
  _initUseCases();

  ///Repositories
  _initRepositories();

  ///Remote Data Sources
  _initRemoteDataSources();

  ///Local Data Sources
  _initLocalDataSources();

  //External
  await _initExternal();
}

///Init Blocs
void _initBlocs() {
  sl.registerFactory<LoginBloc>(
    () => LoginBloc(
      sl<LoginUseCase>(),
      sl<SignInWithGoogleUseCase>(),
      sl<SignInWithFacebookUseCase>(),
      sl<SendEmailVerificationUseCase>(),
    ),
  );
  sl.registerFactory<SignUpBloc>(
    () => SignUpBloc(
      sl<SignUpUseCase>(),
      sl<SendEmailVerificationUseCase>(),
    ),
  );
  
  sl.registerFactory<PasswordResetEmailBloc>(
    () => PasswordResetEmailBloc(
      sl<SendPasswordResetEmailUseCase>(),
    ),
  );
  
  sl.registerFactory<PhoneInputBloc>(
    () => PhoneInputBloc(
      sl<SendPhoneVerificationUseCase>(),
    ),
  );
  
  sl.registerFactory<PhoneVerificationBloc>(
    () => PhoneVerificationBloc(
      sl<SendPhoneVerificationUseCase>(),
      sl<VerifyPhoneUseCase>(),
    ),
  );
}

///Init UseCases
void _initUseCases() {
  ///Auth
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
  
  sl.registerLazySingleton<SendPasswordResetEmailUseCase>(
    () => SendPasswordResetEmailUseCase(
      sl<BaseAuthRepository>(),
    ),
  );
  
  sl.registerLazySingleton<SendEmailVerificationUseCase>(
    () => SendEmailVerificationUseCase(
      sl<BaseAuthRepository>(),
    ),
  );
  
  sl.registerLazySingleton<SendPhoneVerificationUseCase>(
    () => SendPhoneVerificationUseCase(
      sl<BaseAuthRepository>(),
    ),
  );
  
  sl.registerLazySingleton<VerifyPhoneUseCase>(
    () => VerifyPhoneUseCase(
      sl<BaseAuthRepository>(),
    ),
  );

  //Products
  sl.registerLazySingleton<GetAllCategoriesUseCase>(
    () => GetAllCategoriesUseCase(
      sl<BaseProductsRepository>(),
    ),
  );
  sl.registerLazySingleton<GetAllSubCategoriesInCategoryUseCase>(
    () => GetAllSubCategoriesInCategoryUseCase(
      sl<BaseProductsRepository>(),
    ),
  );
  sl.registerLazySingleton<GetAllProductsInCategoryUseCase>(
    () => GetAllProductsInCategoryUseCase(
      sl<BaseProductsRepository>(),
    ),
  );
  sl.registerLazySingleton<SearchProductsByQueryUseCase>(
    () => SearchProductsByQueryUseCase(
      sl<BaseProductsRepository>(),
    ),
  );
  sl.registerLazySingleton<AddToCartUseCase>(
    () => AddToCartUseCase(
      sl<BaseProductsRepository>(),
    ),
  );
  sl.registerLazySingleton<AddToFavouritesUseCase>(
    () => AddToFavouritesUseCase(
      sl<BaseProductsRepository>(),
    ),
  );
  sl.registerLazySingleton<RemoveFromCartUseCase>(
    () => RemoveFromCartUseCase(
      sl<BaseProductsRepository>(),
    ),
  );
  sl.registerLazySingleton<RemoveFromFavouritesUseCase>(
    () => RemoveFromFavouritesUseCase(
      sl<BaseProductsRepository>(),
    ),
  );
}

///Init Repositories
void _initRepositories() {
  sl.registerLazySingleton<BaseAuthRepository>(
    () => AuthRepository(
      sl<BaseAuthRemoteDataSource>(),
    ),
  );
  sl.registerLazySingleton<BaseProductsRepository>(
    () => ProductsRepository(
      sl<BaseProductsRemoteDataSource>(),
      sl<BaseProductsLocalDataSource>(),
    ),
  );
}


///Init Remote Data Sources
void _initRemoteDataSources() {
  sl.registerLazySingleton<BaseAuthRemoteDataSource>(
    () => AuthRemoteDataSource(
      sl<FirebaseAuth>(),
      sl<FirebaseFirestore>(),
      sl<FirebaseStorage>(),
      sl<GoogleSignIn>(),
      sl<FacebookAuth>(),
      sl<Connectivity>(),
    ),
  );
}


///Init Local Data Sources
void _initLocalDataSources() {
  sl.registerLazySingleton<BaseProductsLocalDataSource>(
    () => ProductsLocalDataSource(
      sl<Box<CategoryModel>>(),
      sl<Box<SubCategoryModel>>(),
      sl<Box<ProductModel>>(),
    ),
  );
}

///Init External
Future<void> _initExternal() async {
  ///Firebase Auth
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  ///Firebase Firestore
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  ///Firebase Storage
  sl.registerLazySingleton<FirebaseStorage>(() => FirebaseStorage.instance);
  
  ///Google Auth
  final List<String> scopes = ['email'];
  sl.registerLazySingleton<GoogleSignIn>(
    () => GoogleSignIn(clientId: googleWebClientId, scopes: scopes),
  );

  ///Facebook Auth
  sl.registerLazySingleton<FacebookAuth>(() => FacebookAuth.instance);
  if (kIsWeb) {
    sl<FacebookAuth>().webAndDesktopInitialize(
      appId: facebookAppId,
      cookie: true,
      xfbml: true,
      version: 'v15.0',
    );
  }

  ///Connectivity
  sl.registerLazySingleton<Connectivity>(
    () => Connectivity(),
  );

  ///Shared Preferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(
    () => prefs,
  );

  ///Hive
  final Box<CategoryModel> categoryBox =
      await Hive.openBox<CategoryModel>(HiveBoxes.categories);
  sl.registerLazySingleton<Box<CategoryModel>>(
    () => categoryBox,
  );
  final Box<SubCategoryModel> subCategoryBox =
      await Hive.openBox<SubCategoryModel>(HiveBoxes.subCategories);
  sl.registerLazySingleton<Box<SubCategoryModel>>(
    () => subCategoryBox,
  );
  final Box<ProductModel> productBox =
      await Hive.openBox<ProductModel>(HiveBoxes.products);
  sl.registerLazySingleton<Box<ProductModel>>(
    () => productBox,
  );
}
